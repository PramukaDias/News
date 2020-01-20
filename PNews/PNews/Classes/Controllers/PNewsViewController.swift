//
//  PNewsViewController.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit

class PNewsViewController: PNBaseViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tabViewHeight: NSLayoutConstraint!
    
    private var articlesArray = [Article]()
    var keyword: String = ""
    var viewType: NewsViewType = .newsListView
    
    private var loadingText: String{
        get{
            switch viewType {
            case .newsListView:
                return PNMessages.FETCHING_NEWS
            case .topHeadlineView:
                return PNMessages.FETCHING_TOP_HEADLINE_NEWS
            case .customNewsview:
                return "Fetching \(keyword) News..."
            }
        }
    }
    
    private var viewTitle: String{
        get{
            switch viewType {
            case .newsListView:
                return "News"
            case .topHeadlineView:
                return "Top Headline News"
            case .customNewsview:
                return self.keyword + " News"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch viewType {
        case .newsListView:
        self.tabViewHeight.constant = (UIDevice.current.isIpad()) ?  60.0 : 50.0
        self.menuView.isHidden = false
        case .topHeadlineView, .customNewsview:
            self.tabViewHeight.constant = 0.0
            self.menuView.isHidden = true
        }
    }
    
    private func configureView(){
        self.configureTableView()
        self.title = viewTitle
        self.getNews()
    }
    
}

// MARK: Configure TableView

extension PNewsViewController{
    
    private func configureTableView(){
        self.newsTableView.register(UINib(nibName: "PNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "PNewsTableViewCell")
        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
    }
}

// MARK: API

extension PNewsViewController{
    
    private func getNews(){
        if !PNUtils.isConnectedToInternet(){ return }
        self.startActivityAnimating(message: self.loadingText)
        PNewsAPI.getNews(viewType: self.viewType, keyword: self.keyword, onSuccess: {( newsArray : [Article]?) -> Void in
            self.stopActicityAnimating()
            self.articlesArray = newsArray!
            self.newsTableView.reloadData()
        }, onError: {(_ message) -> Void in
            self.stopActicityAnimating()
            PNUtils.displayAlert(message: message, themeStyle: .error)
        })
    }
}

// MARK: Navigation

extension PNewsViewController{
    
    @IBAction func topHeadlineButtonAction(_ sender: Any) {
        let newsView = self.storyboard?.instantiateViewController(withIdentifier: "PNewsView") as! PNewsViewController
        newsView.viewType = .topHeadlineView
        navigationController?.pushViewController(newsView,animated: true)
    }
    
    @IBAction func customNewsButtonAction(_ sender: Any) {
        let keywordSelectionView = self.storyboard?.instantiateViewController(withIdentifier: "PNKeywordSelectionView") as! PNKeywordSelectionViewController
        navigationController?.pushViewController(keywordSelectionView,animated: true)
    }
    
    @IBAction func profileButtonAction(_ sender: Any) {
        let profileView = self.storyboard?.instantiateViewController(withIdentifier: "PNProfileView") as! PNProfileViewController
        navigationController?.pushViewController(profileView,animated: true)
    }
    
    private func navigateToNewsDetailView(anArticle: Article){
        let newsDetailView = self.storyboard?.instantiateViewController(withIdentifier: "PNDetailView") as! PNewsDetailViewController
        newsDetailView.didSelectArticle = anArticle
        navigationController?.pushViewController(newsDetailView,animated: true)
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension PNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PNewsTableViewCell") as! PNewsTableViewCell
        let anArticle = self.articlesArray[indexPath.row]
        cell.configureNewsDetails(anArticle: anArticle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigateToNewsDetailView(anArticle: self.articlesArray[indexPath.row])
    }
    
}
