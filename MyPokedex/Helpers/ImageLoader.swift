//
//  ImageLoader.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 16/01/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(from url: URL) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    
                }
            }
        }
        
    }
}
