//
//  PNewsDetailTableViewCell.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit

class PNewsDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var goToNewsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

// MARK: Configure news details

extension PNewsDetailTableViewCell{
    
    func configureNewsDetails(anArticle: Article) {
        self.titleLabel.text = anArticle.title
        self.dateLabel.text = anArticle.publishedDate?.formattedNewsDate(isNewsDetail: true)
        self.newsDescriptionLabel.text = anArticle.description
        self.authorLabel.text = (anArticle.author == nil) ? "" :  "Author : \(anArticle.author!)" 
        guard let imageUrl = anArticle.urlToImage else { return }
        self.newsImageView.setupImage(imageUrl: imageUrl, imageViewSize: self.newsImageView.frame.size, placeholderImage: "newsplaceholder")
    }
}
