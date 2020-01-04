//
//  PNProfileViewController.swift
//  PNews
//
//  Created by Pramuka Dias on 10/6/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit
import SwiftMessages
import SkyFloatingLabelTextField

class PNProfileViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var userNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private var pnUser: PNUser!
    
    lazy private var userInfoDict = [
        "fullName" : self.fullNameTextField.text!.trim(),
        "userName" : self.userNameTextField.text!.trim(),
        "email"    : self.emailTextField.text!.trim(),
        "password" : self.passwordTextField.text!.trim()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
        
}

// MARK: Configure view

extension PNProfileViewController{
    
    private func configureView(){
        self.configureTextfields()
        guard  UserDefaults.standard.bool(forKey: PNMessages.USER_INFO_SAVED) else {
            self.title = "Register profile"
            self.registerButton.setTitle("Register", for: .normal)
            return
        }
        self.title = "Update profile"
        self.registerButton.setTitle("Update", for: .normal)
        self.setUserDetails()
    }
    
    private func configureTextfields(){
        self.fullNameTextField.titleFormatter = {$0}
        self.userNameTextField.titleFormatter = {$0}
        self.emailTextField.titleFormatter = {$0}
        self.passwordTextField.titleFormatter = {$0}
    }
    
    private func setUserDetails(){
        self.pnUser = PNCoreDataHandler.getUserDetails()
        self.fullNameTextField.text = self.pnUser.fullname
        self.userNameTextField.text = self.pnUser.username
        self.emailTextField.text = self.pnUser.email
        self.passwordTextField.text = self.pnUser.password
    }
    
}

// MARK: Button action

extension PNProfileViewController{
    
    @IBAction func registerButtonAction(_ sender: Any) {
        let (validationStatus, message) = self.validateUserInfo()
        guard validationStatus else {
            PNUtils.displayAlert(message: message, themeStyle: .error)
            return
        }
        guard UserDefaults.standard.bool(forKey: PNMessages.USER_INFO_SAVED) else {
            self.saveUserInfo()
            return
        }
        self.updateUserInfo()
    }
    
    @IBAction func actionShowPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !sender.isSelected
    }
}

// MARK: Validate user data

extension PNProfileViewController{
    
    private func validateUserInfo() -> (Bool, String) {
        guard !self.fullNameTextField!.isEmpty() else {
            return (false, PNMessages.FULL_NAME_ERROR_MESSAGE)
        }
        guard !self.userNameTextField.isEmpty() else {
            return (false, PNMessages.USERNAME_ERROR_MESSAGE)
        }
        guard !self.emailTextField.isEmpty() else{
            return (false, PNMessages.EMAIL_ERROR_MESSAGE)
        }
        guard self.emailTextField.text!.trim().isValidEmail() else {
            return (false, PNMessages.INVALID_EMAIL_ERROR_MESSAGE)
        }
        guard !self.passwordTextField.isEmpty() else {
            return (false, PNMessages.PASSWORD_ERROR_MESSAGE)
        }
        guard self.passwordTextField.text!.trim().count > 7  else {
            return (false, PNMessages.PASSWORD_LENGTH_ERROR_MESSAGE)
        }
        return (true, "")
    }
    
}

// MARK: Save / update user data

extension PNProfileViewController{
    
    private func saveUserInfo(){
        guard PNCoreDataHandler.saveUserDetails(userInfo: userInfoDict) else {
            PNUtils.displayAlert(message: PNMessages.USER_DATA_SAVED_FAILED_MESSAGE, themeStyle: .error)
            return
        }
        UserDefaults.standard.set(true, forKey: PNMessages.USER_INFO_SAVED)
        PNUtils.displayAlert(message: PNMessages.USER_DATA_SAVED_SUCCESS_MESSAGE, themeStyle: .success)
    }
    
    private func updateUserInfo(){
        guard PNCoreDataHandler.updateUserDetails(user: self.pnUser, updatedUserInfo: self.userInfoDict) else {
            PNUtils.displayAlert(message: PNMessages.USER_DATA_UPDATED_FAILED_MESSAGE, themeStyle: .error)
            return
        }
        PNUtils.displayAlert(message: PNMessages.USER_DATA_UPDATED_SUCCESS_MESSAGE, themeStyle: .success)
    }
}
