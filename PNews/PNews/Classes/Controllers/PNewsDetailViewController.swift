//
//  PNewsDetailViewController.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit

class PNewsDetailViewController: PNBaseViewController {
    
    @IBOutlet weak var detailNewsTableView : UITableView!
    
    var didSelectArticle = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDetailView()
    }
    
    private func configureDetailView(){
        self.title = "News Detail"
        self.configureTableView()
    }
    
    @objc private func goToNewsButtonAction(sender: UIButton!) {
        guard let urlS = self.didSelectArticle.url else { return }
        guard let url = URL(string:urlS),UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
}

// MARK: Configure TableView

extension PNewsDetailViewController{
    
    private func configureTableView(){
        self.detailNewsTableView.register(UINib(nibName: "PNewsDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PNewsDetailTableViewCell")
        self.detailNewsTableView.dataSource = self
        self.detailNewsTableView.delegate = self
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension PNewsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PNewsDetailTableViewCell") as! PNewsDetailTableViewCell
        cell.configureNewsDetails(anArticle: self.didSelectArticle)
        cell.goToNewsButton.addTarget(self, action: #selector(self.goToNewsButtonAction(sender:)), for: .touchUpInside)
        return cell
    }
    
}
