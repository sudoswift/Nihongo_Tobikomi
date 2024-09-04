//
//  UserViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Firebase
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: User?
    private var isSignIn: AuthStateDidChangeListenerHandle?
    
    init() {
        setupAuthListener()
    }
    
    private func setupAuthListener() {
        isSignIn = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let user = user {
                // 사용자가 로그인된 상태일 때
                self?.fetchUserData(uid: user.uid)
            } else {
                // 사용자가 로그인되지 않은 상태일 때
                self?.user = nil
            }
        }
    }
    
    deinit {
        if let listener = isSignIn {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    private func fetchUserData(uid: String) {
        // 사용자 데이터를 가져오는 로직
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign In Error: \(error.localizedDescription)")
                completion(false)
            } else {
                self.fetchUserData(uid: result?.user.uid ?? "")
                completion(true)
            }
        }
    }
    
    func signUp(email: String, password: String, userName: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign Up Error: \(error.localizedDescription)")
                completion(false)
            } else {
                let uid = result?.user.uid ?? ""
                let newUser = User(userName: userName, userUID: uid, userEmail: email)
                self.saveUserData(user: newUser)
                self.user = newUser
                completion(true)
            }
        }
    }
    
    private func saveUserData(user: User) {
        // 사용자 데이터를 저장하는 로직
    }
}


