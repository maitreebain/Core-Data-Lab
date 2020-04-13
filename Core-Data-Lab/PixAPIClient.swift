//
//  PixAPIClient.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/12/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation
import NetworkHelper

struct ImageAPIClient {
    
    static func fetchImages(for search: String, completion: @escaping (Result<[Image], AppError>) -> ()){
        
        let userSearch = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        let endPointurl = "https://pixabay.com/api/?key=\(SecretKey.appKey)&q=\(userSearch)&image_type=photo&pretty=true"
        
        guard let url = URL(string: endPointurl) else{
            completion(.failure(.badURL(endPointurl)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let imageData = try JSONDecoder().decode(ImageDataLoad.self, from: data)
                    
                    completion(.success(imageData.hits))
                }
                catch {
                    completion(.failure(.decodingError(error)))
                }
                
                
            }
        }
        
    }
}
