//
//  TeamViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 31.08.2021.
//

import UIKit

class TeamMenuViewController: UIViewController {
    
    let menu = ["Календарь", "Статистика", "Устав", "Казна", "Памятка"]
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TeamMenuCollectionViewCell.self, forCellWithReuseIdentifier: "teamMenuCell")
        
        return cv
    }()

    override func viewWillAppear(_ animated: Bool) {
        collectionView.backgroundColor = .black
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
                        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
                        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.title = "Dunedayn"
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
    }
}

extension TeamMenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/4)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamMenuCell", for: indexPath) as! TeamMenuCollectionViewCell
        
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 10
        
        let name = menu[indexPath.row]
        
        cell.names?.text = name
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController = TeamCalendarViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
