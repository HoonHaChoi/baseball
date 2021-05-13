//
//  ImageLoader.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/13.
//

import UIKit
import Combine

class ImageLoader {
    
    func request(url: String) -> AnyPublisher<UIImage, Never> {
        guard let url = makeURL(to: url) else {
            return Just(UIImage()).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) ?? UIImage() }
            .catch { error in return Just(UIImage()) }
            .eraseToAnyPublisher()
    }
    
    func makeURL(to url: String) -> URL?{
        guard let url = URL(string: url) else {
            return nil
        }
        return url
    }
}
