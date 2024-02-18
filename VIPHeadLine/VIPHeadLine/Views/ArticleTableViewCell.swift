//
//  ArticleTableViewCell.swift
//  VIPHeadLine
//
//  Created by SONG on 2/12/24.
//

import UIKit

protocol Abc where Self: UITableViewCell {
    func configure(title:String ,description:String)
}

class ArticleTableViewCell: UITableViewCell,Abc {
    static let identifier = "ArticleTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    
    
    func configure(title: String , description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = title
    }
    
    private func setLayout() {
        if !self.stackView.contains(self.titleLabel) {
            self.stackView.addArrangedSubview(self.titleLabel)
        }
        
        if !self.stackView.contains(self.descriptionLabel) {
            self.stackView.addArrangedSubview(self.descriptionLabel)
        }
        
        if !self.contentView.contains(self.stackView) {
            contentView.addSubview(self.stackView)
        }
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            self.stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            self.stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            self.stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.stackView.widthAnchor,multiplier: 0.98),
            self.descriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: self.stackView.widthAnchor,multiplier: 0.98)
        ])
    }
}
