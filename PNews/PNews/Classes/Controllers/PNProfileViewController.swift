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
import RealmSwift

class PNProfileViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var userNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private var pnUser: NUser!
    
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
        configureUpdatedView()
        self.setUserDetails()
    }
    
    private func configureTextfields(){
        self.fullNameTextField.titleFormatter = {$0}
        self.userNameTextField.titleFormatter = {$0}
        self.emailTextField.titleFormatter = {$0}
        self.passwordTextField.titleFormatter = {$0}
    }
    
    private func setUserDetails(){
        self.fullNameTextField.text = self.pnUser.fullname
        self.userNameTextField.text = self.pnUser.username
        self.emailTextField.text = self.pnUser.email
        self.passwordTextField.text = self.pnUser.password
    }
    
    private func configureUpdatedView(){
        self.pnUser = RealmService.shared.realm.objects(NUser.self).first
        self.title = "Update profile"
        self.registerButton.setTitle("Update", for: .normal)
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
        guard RealmService.shared.create(getUser()) else {
            PNUtils.displayAlert(message: PNMessages.USER_DATA_SAVED_FAILED_MESSAGE, themeStyle: .error)
            return
        }
        UserDefaults.standard.set(true, forKey: PNMessages.USER_INFO_SAVED)
        configureUpdatedView()
        PNUtils.displayAlert(message: PNMessages.USER_DATA_SAVED_SUCCESS_MESSAGE, themeStyle: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateUserInfo(){
        guard RealmService.shared.update(self.pnUser, with: getUpdatedUserDictionary()) else {
            PNUtils.displayAlert(message: PNMessages.USER_DATA_UPDATED_FAILED_MESSAGE, themeStyle: .error)
            return
        }
        PNUtils.displayAlert(message: PNMessages.USER_DATA_UPDATED_SUCCESS_MESSAGE, themeStyle: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getUser() -> NUser{
        let user = NUser(fullname:  self.fullNameTextField.text!.trim(), username: self.userNameTextField.text!.trim(), email: self.emailTextField.text!.trim(), password: self.passwordTextField.text!.trim())
        return user
    }
    
    private func getUpdatedUserDictionary() -> [String: Any]{
        let userInfoDict = [
            "fullname" : self.fullNameTextField.text!.trim(),
            "username" : self.userNameTextField.text!.trim(),
            "email"    : self.emailTextField.text!.trim(),
            "password" : self.passwordTextField.text!.trim()
        ]
        return userInfoDict
    }
}
