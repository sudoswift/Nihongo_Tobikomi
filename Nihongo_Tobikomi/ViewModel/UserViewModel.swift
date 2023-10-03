//
//  UserViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class UserViewModel: ObservableObject{
    //MARK: - Login
    @Published var emailID: String = ""
    //MARK: - Current User
    @Published var currentUser: Firebase.User?
    //MARK: - Register
    @Published var registerEmail: String = ""
    @Published var userName: String = ""
    //MARK: - Fetch Current User's Data
    @Published var currentUserData: User?
    //MARK: - UserDefaults Log Status
    @Published var logStatus: Bool = false{
        didSet{
            UserDefaults.standard.set(logStatus, forKey: "logStatus")
        }
    }
    init(){
        self.logStatus = UserDefaults.standard.bool(forKey: "logStatus")
    }
    //MARK:- Fetch Data
    let database = Firestore.firestore()
    //MARK: - 
    
}// class UserViewModel
