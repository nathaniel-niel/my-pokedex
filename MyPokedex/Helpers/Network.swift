//
//  Network.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import Foundation
import RxSwift

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func loadData<T>(resource: Resource<T>) -> Single<T> {
        return Single<T>.create { single in
            let resource = URLRequest(url: resource.url)
            let task = URLSession.shared.dataTask(with: resource) { data, response, error in
                if let error = error {
                    single(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    return
                }
                
                if let data  = data {
                    let result = try? JSONDecoder().decode(T.self, from: data)
                    single(.success(result!))
                }
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
