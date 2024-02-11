//
//  ArticlesWorker.swift
//  VIPHeadLine
//
//  Created by SONG on 2/11/24.
//

import Foundation

class ArticlesWorker {
    var articlesManager: ArticlesStoreProtocol
    private let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c3430169acc24c87849bfdcf1f93fb40")
    //민감한정보 숨기는 작업 생략. 
    
    init(articlesManager: ArticlesStoreProtocol) {
        self.articlesManager = articlesManager
    }
    
    func getArticles(completion: @escaping ([Article]) -> ()) {
        guard let url = self.url else {
            return
        }
        
        self.articlesManager.getArticles(url: url) { result in
            switch result {
            case .success(let articles):
                completion(articles)
            case .failure(let error):
                completion([])
            }
        }
    }
}

protocol ArticlesStoreProtocol {
    //CRUD와 에러타입은 다음에 ^^
    func getArticles(url: URL, completion: @escaping (Result<[Article],Error>) -> ())
}
