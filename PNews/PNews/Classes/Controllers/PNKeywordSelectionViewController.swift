//
//  PNKeywordSelectionViewController.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit

class PNKeywordSelectionViewController: PNBaseViewController {
    
    @IBOutlet weak var keywordsTableView : UITableView!
    private let customArray = ["Bitcoin", "Apple", "Earthquake", "Animal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureKeywordView()
    }
    
}

// MARK: Configure TableView

extension PNKeywordSelectionViewController{
    
    private func configureKeywordView(){
        self.title = "Custom News Selection"
        self.configureTableView()
    }
    
    private func configureTableView(){
        self.keywordsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.keywordsTableView.dataSource = self
        self.keywordsTableView.delegate = self
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension PNKeywordSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = customArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsView = self.storyboard?.instantiateViewController(withIdentifier: "PNewsView") as! PNewsViewController
        newsView.keyword = customArray[indexPath.row]
        newsView.viewType = .customNewsview
        navigationController?.pushViewController(newsView,animated: true)
    }
    
}
