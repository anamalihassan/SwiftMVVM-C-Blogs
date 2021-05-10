//
//  PostsTableViewCell.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class PostsTableViewCell: AppTableViewCell {
    
    // MARK: - Properties
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.bold.customFont, size: AppFonts.Size.header)
        label.textColor = AppColor.appPrimary.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.subHeader)
        label.textColor = AppColor.appPrimary.color
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - UI Setup
    
    override func prepareView() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    // MARK: - Setup Layout
    
    override func setConstraintsView() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:16),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-16),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:-16),
        ])
    }

}

extension PostsTableViewCell {
    
    func configureCell(data: PostObject) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.body
        
    }
}
