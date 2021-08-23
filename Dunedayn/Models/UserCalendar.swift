//
//  UserCalendar.swift
//  Dunedayn
//
//  Created by Aleksandr Mayyura on 22.08.2021.
//

import Foundation
import Firebase

struct UserCalendar {
    
    let ref: DatabaseReference?
    let key: String
    let data: Data
    let eventName: String
    let eventLink: String
    let eventDescription: String
    var mark: Bool
    
    init(data: Data, eventName: String, eventLink: String, eventDescription: String, mark: Bool, key: String = "") {
        self.ref = nil
        self.key = key
        self.data = data
        self.eventName = eventName
        self.eventLink = eventLink
        self.eventDescription = eventDescription
        self.mark = mark
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let data = value["data"] as? Data,
            let eventName = value["eventName"] as? String,
            let eventLink = value["eventLink"] as? String,
            let eventDescription = value["eventDescription"] as? String,
            let mark = value["mark"] as? Bool
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.eventName = eventName
        self.eventLink = eventLink
        self.eventDescription = eventDescription
        self.mark = mark
        self.data = data
    }

    func toAnyObject() -> Any {
      return [
        "eventName": eventName,
        "eventLink": eventLink,
        "eventDescription": eventDescription,
        "mark": mark,
        "data": data
        
      ]
    }
}

