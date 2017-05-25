//
//  User_class.swift
//  EXchangeApp
//
//  Created by Sergey on 4/17/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import Foundation
import UIKit

struct User{
    var profileImage : UIImage!
    var avatarReference : String?
    var uid : String!
    var email : String!
    var name : String!
}

struct CurrentUser{
    static var profileImage : UIImage!
    static var avatarReference : String?
    static var uid : String!
    static var email : String!
    static var name : String!
}
