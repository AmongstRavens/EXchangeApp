//
//  User_class.swift
//  EXchangeApp
//
//  Created by Sergey on 4/17/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import Foundation
import UIKit

class User{
    var profileImage : UIImage!
    var avatarReference : String?
    var email : String
    var firstName : String
    var lastName : String
    private var rate : Int
    
    init(image: UIImage, email: String, firstName: String, lastName : String) {
        self.profileImage = image
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        rate = 0
    }
    
    func addRate(){
        self.rate += 1
    }
}
