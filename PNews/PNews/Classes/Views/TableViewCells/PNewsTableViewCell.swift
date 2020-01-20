//
//  PNewsTableViewCell.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit

class PNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UIAlignedLabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.contentMode = .topLeft
    }
}

// MARK: Configure news

extension PNewsTableViewCell{
    
    func configureNewsDetails(anArticle: Article){
        self.titleLabel.text = anArticle.title
        self.dateLabel.text = anArticle.publishedDate?.formattedNewsDate(isNewsDetail: false)
        guard let imageUrl = anArticle.urlToImage else { return }
        self.newsImageView.setupImage(imageUrl: imageUrl, imageViewSize: self.newsImageView.frame.size, placeholderImage: "newssmallplaceholder")
    }
}
