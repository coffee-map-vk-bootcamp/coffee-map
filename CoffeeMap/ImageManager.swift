//
//  ImageManager.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 17.08.2022.
//

import Foundation
import UIKit

protocol ImageManagerDescription {
    func loadImage(with imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
    func cancel(with imageUrl: String)
}

enum ImageManagerError: LocalizedError {
    case parseError
}

final class ImageManager: ImageManagerDescription {
    private let cacheManager: ImageCacheDescription
    private let networkQueue: OperationQueue
    private let session: URLSession

    private let tasksQueue: DispatchQueue = DispatchQueue(label: "ImageManager.tasksQueue", qos: .userInitiated)
    private var tasks: [String: URLSessionTask] = [:]

    static let shared: ImageManagerDescription = ImageManager()

    private init(cacheManager: ImageCacheDescription = ImageCache()) {
        self.cacheManager = cacheManager
        self.networkQueue = OperationQueue()
        self.networkQueue.qualityOfService = .utility
        self.session = URLSession(configuration: .default, delegate: nil, delegateQueue: self.networkQueue)
    }

    private func add(task: URLSessionTask, url: String) {
        let key = url

        tasksQueue.sync {
            _ = tasks.updateValue(task, forKey: key)
        }
    }

    private func removeTask(url: String) {
        let key = url

        tasksQueue.sync {
            _ = tasks.removeValue(forKey: key)
        }
    }

    func loadImage(with imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cacheImage = cacheManager.obtain(with: imageUrl.path) {
            completion(.success(cacheImage))
            return
        }

        let request = URLRequest(url: imageUrl)

        let task = session.dataTask(with: request) { [weak self] data, _, error in
            let mainThreadCompletion: (Result<UIImage, Error>) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                mainThreadCompletion(.failure(error))
                self?.removeTask(url: imageUrl.path)
                return
            }

            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                mainThreadCompletion(.failure(ImageManagerError.parseError))
                self?.removeTask(url: imageUrl.path)
                return
            }

            mainThreadCompletion(.success(image))
            self?.removeTask(url: imageUrl.path)
            self?.cacheManager.save(object: image, for: imageUrl.path)
        }

        add(task: task, url: imageUrl.path)

        task.resume()
    }

    func cancel(with imageUrl: String) {
        guard let task = tasks[imageUrl] else {
            return
        }

        task.cancel()
        removeTask(url: imageUrl)
    }
}
