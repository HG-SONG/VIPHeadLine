//
//  ListNewsWorker.swift
//  VIPHeadLine
//
//  Created by SONG on 2/11/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class ListNewsWorker
{
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
