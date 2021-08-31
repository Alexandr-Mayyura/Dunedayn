//
//  UsersTableViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 27.08.2021.
//

import UIKit
import Firebase

class MyCell: UICollectionViewCell {
    
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


class UserCalendarTableViewController: UIViewController {
    
//MARK: add collectionView
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyCell.self, forCellWithReuseIdentifier: "userCell")
        
        return cv
    }()
    
    var refObservers = [DatabaseHandle]()
    let ref = Database.database().reference(withPath: "Games")
    var items = [Games]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Календарь"
        self.navigationController?.navigationBar.tintColor = .white
        
        loadItems()
       
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        }
    
// MARK: load items for Firebase
    
        func loadItems() {
                       
            let completed = ref
              .queryOrdered(byChild: "Games")
              .observe(.value) { snapshot in
                var newItems: [Games] = []
                for child in snapshot.children {
                  if
                    let snapshot = child as? DataSnapshot,
                    let groceryItem = Games(snapshot: snapshot) {
                    newItems.append(groceryItem)
                    newItems.sort(by: {$0.data < $1.data})
                  }
                }
               
                self.items = newItems
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
              }
            refObservers.append(completed)
            
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}

extension UserCalendarTableViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/4)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! MyCell

        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 10
        
        let item = items[indexPath.row]
        
        let isoDate = item.data

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoDate)!
        let dateFormatted = DateFormatter()
        dateFormatted.locale = .init(identifier: "ru_RU_POSIX")
        dateFormatted.dateFormat = "d MMMM yyyy"
        let finalDate = dateFormatted.string(from: date)

        cell.nameLabel?.text = "\(item.name)\n\(item.organizer)\n\(finalDate)"
        
        if item.mark == true {
            cell.markView?.backgroundColor = .green
        } else {
            cell.markView?.backgroundColor = .red
        }
        
        

        return cell
    }
    
    
}
    
