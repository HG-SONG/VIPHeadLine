//
//  ListNewsModels.swift
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

enum ListNews
{
  // MARK: Use cases
  
  enum GetArticle
  {
    struct Request
    {
    }
    struct Response
    {
        var articles: [Article]
    }
    struct ViewModel
    {
        struct DisplayedArticle {
            var title: String
            var description: String
        }
        var displayedArticles : [DisplayedArticle] 
    }
  }
}
