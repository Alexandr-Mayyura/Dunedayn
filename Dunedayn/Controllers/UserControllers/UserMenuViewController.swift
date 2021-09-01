//
//  MenuViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 19.08.2021.
//

import UIKit

class UserMenuCell: UICollectionViewCell {
    var nameLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        nameLabel = UILabel(frame: CGRect(x: contentView.bounds.size.height/2 - contentView.bounds.size.height/2.2, y: contentView.bounds.size.height/2 - contentView.bounds.size.height/4.5, width: contentView.bounds.size.width, height: 40))
        
        nameLabel?.textColor = .white
        nameLabel?.textAlignment = .center
        nameLabel?.font = nameLabel?.font.withSize(32)
        
        contentView.addSubview(nameLabel!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class UserMenuViewController: UIViewController {

    let nameMenu = ["Игры", "Статистика", "Посещение", "Кит лист", "Заказы", "Чек лист", "Калькулятор"]
    
    let image = UIImage(named: "kryptek")

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UserMenuCell.self, forCellWithReuseIdentifier: "menuCell")
        
        return cv
    }()

    override func viewWillAppear(_ animated: Bool) {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .black
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
                        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
                        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        self.title = "Lock"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
             
        collectionView.dataSource = self
        collectionView.delegate = self
                
        view.addSubview(collectionView)
    }
}

extension UserMenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! UserMenuCell
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 10
        
        cell.nameLabel?.text = nameMenu[indexPath.row]

        return cell
    }
    
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegue(withIdentifier: "userCells", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == 0 {
                let viewController = UserCalendarTableViewController() 
                self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
}
