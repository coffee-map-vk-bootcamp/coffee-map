//
//  ImageCache.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 17.08.2022.
//

import Foundation
import UIKit

protocol ImageCacheDescription {
    func obtain(with key: String) -> UIImage?
    func save(object: UIImage, for key: String)
}

final class ImageCache: ImageCacheDescription {
    private let cache: NSCache<NSString, UIImage>

    init() {
        cache = NSCache()
        cache.countLimit = Constants.maxImagesCount
        cache.totalCostLimit = Constants.totalSize
    }

    private struct Constants {
        static let maxImagesCount: Int = 75
        static let totalSize: Int = 50 * 1024 * 1024 // 50 MB
    }

    func obtain(with key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    func save(object: UIImage, for key: String) {
        cache.setObject(object, forKey: NSString(string: key))
    }
}
