//
//  CommentsTableViewHeader.swift
//  Blogs
//
//  Created by Ali Hassan on 11/05/2021.
//

import UIKit

class CommentsTableViewHeader : UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.subHeader)
        label.textColor = AppColor.white.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let headerContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColor.textGray.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(headerContainer)
        
        headerContainer.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor),
            headerContainer.leftAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leftAnchor),
            headerContainer.rightAnchor.constraint(equalTo:self.safeAreaLayoutGuide.rightAnchor),
            headerContainer.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant:50),
            titleLabel.leadingAnchor.constraint(equalTo:headerContainer.leadingAnchor, constant:20),
            titleLabel.centerYAnchor.constraint(equalTo:headerContainer.centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
