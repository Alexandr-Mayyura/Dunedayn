//
//  TeamCalendarViewController.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 31.08.2021.
//

import UIKit

class CalendarCell: UITableViewCell {
    
    var nameLabel: UILabel?
    var myViewHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel()
        contentView.addSubview(nameLabel!)
        nameLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0) .isActive = true
        nameLabel?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0) .isActive = true
        nameLabel?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0) .isActive = true
        nameLabel?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0) .isActive = true
        
        nameLabel?.numberOfLines = 0
        nameLabel?.textAlignment = .center
        nameLabel?.font = nameLabel?.font.withSize(30)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class TeamCalendarViewController: UIViewController {
    
    let image = UIImage(named: "kryptek")
    
    let  messageArray = ["One "]
    
    fileprivate let tableview: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(CalendarCell.self, forCellReuseIdentifier: "teamCell")
        return tv
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Календарь"
        self.navigationController?.navigationBar.tintColor = .white
               
        tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
//        tableview.estimatedRowHeight = 200
        tableview.rowHeight = UITableView.automaticDimension

        tableview.tableFooterView = UILabel()
        tableview.backgroundView = UIImageView(image: image)
        
       
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)

    }

}

extension TeamCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! CalendarCell
        
        cell.backgroundConfiguration = .clear()
        cell.nameLabel?.text = messageArray[indexPath.row]
        
        return cell
    }
    
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    
    
}
