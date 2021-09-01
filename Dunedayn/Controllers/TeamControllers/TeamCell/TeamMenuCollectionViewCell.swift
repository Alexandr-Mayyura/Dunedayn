//
//  TeamCalendarCollectionViewCell.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 01.09.2021.
//

import UIKit

class TeamMenuCollectionViewCell: UICollectionViewCell {
    
    var names: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        names = UILabel(frame: CGRect(x: contentView.bounds.size.height/2 - contentView.bounds.size.height/2.2, y: contentView.bounds.size.height/2 - contentView.bounds.size.height/4.5, width: contentView.bounds.size.width, height: 40))
        names?.textColor = .white
        names?.textAlignment = .center
        names?.font = names?.font.withSize(32)
        contentView.addSubview(names!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
