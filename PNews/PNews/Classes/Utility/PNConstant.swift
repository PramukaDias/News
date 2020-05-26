//
//  PNConstant.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit

struct PNApplicationInfo {
    static let API_KEY        =  "acf4aa23a5094e1b95da36117539693d"
    static let APP_BASE_URL        =  "https://newsapi.org/v2/"
}

struct PNMessages {
    static let NO_INTERNET                = "The Internet connection appears to be offline."
    static let ERROR_MESSAGE              = "Something went wrong"
    
    static let FETCHING_NEWS              = "Fetching News..."
    static let FETCHING_TOP_HEADLINE_NEWS = "Fetching Top Headline News..."
    
    static let USER_INFO_SAVED              = "usersaved"
    
    static let FULL_NAME_ERROR_MESSAGE              = "Full Name required"
    static let USERNAME_ERROR_MESSAGE              = "Username required"
    static let EMAIL_ERROR_MESSAGE              = "Email required"
    static let INVALID_EMAIL_ERROR_MESSAGE              = "Invalid E-mail"
    static let PASSWORD_ERROR_MESSAGE              = "Password required"
    static let PASSWORD_LENGTH_ERROR_MESSAGE              = "You have to enter at least 7 digit for Password"
    
    
    static let USER_DATA_SAVED_SUCCESS_MESSAGE              = "Registered user details successfully"
    static let USER_DATA_SAVED_FAILED_MESSAGE              = "Can not register user details"
    static let USER_DATA_UPDATED_SUCCESS_MESSAGE              = "Updated user details successfully"
    static let USER_DATA_UPDATED_FAILED_MESSAGE              = "Can not updated user details"    
}

struct PNColors {
    static let APP_THEME_COLOR        =  UIColor.init(red: 107.0/255.0, green: 94.0/255.0, blue: 184.0/255.0, alpha: 1.0)
}

// MARK: News view types
enum NewsViewType {
    case newsListView
    case topHeadlineView
    case customNewsview
}
