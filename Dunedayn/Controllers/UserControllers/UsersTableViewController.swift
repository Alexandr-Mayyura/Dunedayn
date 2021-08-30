//
//  UsersTableViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 27.08.2021.
//

import UIKit
import Firebase

class UsersTableViewController: UIViewController {

    fileprivate let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tv
    }()

        var ref: DatabaseReference!
    var refObservers = [DatabaseHandle]()
    
    var items = [Games]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        loadItems()
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }

        func loadItems() {
            
            ref = Database.database().reference()
            ref.child("Games").child("Берег").observe(.value) { (snapshot) in
                
                let result = snapshot.value as? [String: AnyObject]
                let data = result?["data"]
                let name = result?["name"]
                let link = result?["link"]
                let description = result?["description"]
                let mark = result?["mark"]
                let organizer = result?["organizer"]
                let items = Games(name: (name as? String ?? "Game"), description: (description as? String ?? "description"), data: (data as? String ?? "не известна"), link: (link as? String ?? ""), mark: (mark as? Bool ?? true), organizer: (organizer as? String ?? ""))
             
                    self.items.append(items)
                print(items)
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
       
    }

}


extension UsersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        
        let eventItems = items[indexPath.row]
        
        cell.textLabel?.text = eventItems.name
        return cell
    }
}



