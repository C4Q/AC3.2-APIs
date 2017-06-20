//
//  User.swift
//  FacesterGram
//
//  Created by Louis Tur on 10/21/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct User {
    internal let firstName: String
    internal let lastName: String
    internal let username: String
    internal let emailAddress: String
    internal let thumbnailURL: String
    
    init(firstName: String, lastName: String, username: String, emailAddress: String, thumbnailURL: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.emailAddress = emailAddress
        self.thumbnailURL = thumbnailURL
    }
    
    init?(data: Data) {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
            
            // 4. parse out name
            guard
                let name: [String : String] = jsonData["name"] as? [String : String],
                let first: String = name["first"],
                let last: String = name["last"]
                else {
                    return nil
            }
            
            // 6. parse out user name
            guard
                let login: [String : String] = jsonData["login"] as? [String : String],
                let username: String = login["username"]
                else {
                    return nil
            }
            
            // 8. parse out image URLs
            guard
                let pictures: [String : String] = jsonData["picture"] as? [String : String],
                let thumbnail: String = pictures["thumbnail"]
                else {
                    return nil
            }
            
            // 9. the rest
            guard let email: String = jsonData["email"] as? String else {
                return nil
            }
            
            self = User(firstName: first,
                        lastName: last,
                        username: username,
                        emailAddress: email,
                        thumbnailURL: thumbnail)
            
        }
        catch {
            print("Error encountered with parsing: \(error)")
            return nil
        }
    }
}
