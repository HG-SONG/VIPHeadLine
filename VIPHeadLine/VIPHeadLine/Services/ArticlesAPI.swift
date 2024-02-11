//
//  ArticlesAPI.swift
//  VIPHeadLine
//
//  Created by SONG on 2/11/24.
//

import Foundation

class ArticlesAPI: ArticlesStoreProtocol {
    func getArticles(url: URL, completion: @escaping (Result<[Article], Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                    completion(.success(articleList.articles))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            }
        }.resume()
    }
}
