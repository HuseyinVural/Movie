//
//  ImageLoader.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import UIKit

public protocol ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    func cancelImageLoad(from url: URL)
}

public final class ImageLoader: ImageLoaderProtocol {
    private let cache = NSCache<NSURL, UIImage>()
    private var runningTasks: [NSURL: URLSessionDataTask] = [:]
    private let session: URLSession
    
    /// Initializes the ImageLoader with an optional URLSession.
    ///
    /// - Parameter session: The URLSession used for downloading images. Defaults to `.shared`.
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Loads an image from the specified URL. The method first checks the in-memory cache and then fetches it from the network if not cached.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to load.
    ///   - completion: The completion handler to call when the load request is complete.
    public func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let nsURL = url as NSURL
        
        // Check in-memory cache
        if let cachedImage = cache.object(forKey: nsURL) {
            completion(cachedImage)
            return
        }
        
        // Download from the network
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.runningTasks.removeValue(forKey: nsURL) }
            
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            // Cache the image in memory
            self.cache.setObject(image, forKey: nsURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        runningTasks[nsURL] = task
        task.resume()
    }
    
    /// Cancels an ongoing image load task for the specified URL.
    ///
    /// - Parameter url: The URL of the image load task to cancel.
    public func cancelImageLoad(from url: URL) {
        let nsURL = url as NSURL
        runningTasks[nsURL]?.cancel()
        runningTasks.removeValue(forKey: nsURL)
    }
}

public extension UIImageView {
    /// Loads an image from a URL and sets it to the UIImageView.
    /// - Parameters:
    ///   - url: The URL of the image to load.
    ///   - placeholder: A placeholder image to display while the image is loading.
    func setImage(from url: URL?, placeholder: UIImage? = nil) {
        // Set placeholder image if provided
        self.image = placeholder
        let loader = DependencyContainer.shared.resolve(ImageLoaderProtocol.self)
         
        guard let url else {
            return
        }
        
        // Load the image from the URL
        loader.loadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    /// Cancels the image load request for the given URL.
    /// - Parameter url: The URL of the image load task to cancel.
    func cancelImageLoad(from url: URL?) {
        guard let url else {
            return
        }
        
        let loader = DependencyContainer.shared.resolve(ImageLoaderProtocol.self)
        loader.cancelImageLoad(from: url)
    }
}
