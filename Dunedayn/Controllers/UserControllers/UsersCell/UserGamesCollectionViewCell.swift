//
//  UserGamesCollectionViewCell.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 01.09.2021.
//

import UIKit

class UserGamesCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel?
    var markView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = UILabel(frame:  CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height))
        nameLabel?.textColor = .white
        nameLabel?.textAlignment = .center
        nameLabel?.font = nameLabel?.font.withSize(24)
        nameLabel?.numberOfLines = 3
        self.contentView.addSubview(nameLabel!)
        
   
        markView = UIView(frame: CGRect(x: 10, y: contentView.bounds.size.height - contentView.bounds.size.height/1.6, width: 20, height: 20))
        markView?.layer.cornerRadius = .pi * .pi
        self.contentView.addSubview(markView!)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
