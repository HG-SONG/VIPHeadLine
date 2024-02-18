//
//  ListNewsViewController.swift
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

protocol ListNewsDisplayLogic: AnyObject
{
    func displayArticles(viewModel: ListNews.GetArticle.ViewModel)
}

class ListNewsViewController: UITableViewController, ListNewsDisplayLogic
{
    var interactor: ListNewsBusinessLogic?
    var router: (NSObjectProtocol & ListNewsRoutingLogic & ListNewsDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ListNewsInteractor()
        let presenter = ListNewsPresenter()
        let router = ListNewsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        self.title = "News"
        self.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getArticles()
    }
    
    // MARK: getArticles()
    
    var displayedArticles: [ListNews.GetArticle.ViewModel.DisplayedArticle] = []
    
    func getArticles()
    {
        let request = ListNews.GetArticle.Request()
        interactor?.getArticles(request: request)
    }
    
    // MARK: displayArticles()
    
    func displayArticles(viewModel: ListNews.GetArticle.ViewModel)
    {
        self.displayedArticles = viewModel.displayedArticles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension ListNewsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let displayedArticle = self.displayedArticles[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: displayedArticle.title, description: displayedArticle.description)
        
        return cell
    }
}

// MARK: - Table view Delegate

extension ListNewsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 뷰컨이동
    }
}
