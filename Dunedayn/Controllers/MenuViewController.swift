//
//  MenuViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 19.08.2021.
//

import UIKit

class MenuViewController: UIViewController {

    let colorCell = [UIColor.red, UIColor.green, UIColor.gray, UIColor.blue, UIColor.yellow, UIColor.purple]
    let nameMenu = ["Календарь", "Статистика", "Посещение", "Кит лист", "Заказы", "Чек лист", "Калькулятор"]
    
    let image = UIImage(named: "kryptek")

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        
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

extension MenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath)
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 10
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: cell.bounds.size.height/2 - cell.bounds.size.height/2.2, y: cell.bounds.size.height/2 - cell.bounds.size.height/4.5, width: cell.bounds.size.width, height: 40)
        
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = nameLabel.font.withSize(32)
        
        nameLabel.text = nameMenu[indexPath.row]
        
        cell.contentView.addSubview(nameLabel)
        
        return cell
    }
    
//    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        performSegue(withIdentifier: "userCell", sender: indexPath)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == 0 {
                let viewController = UserTableViewController() // or your custom view controller
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
