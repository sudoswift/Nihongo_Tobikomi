//
//  UserViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user: User?
    private var db = Firestore.firestore()

    //MARK: - signIn
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
    //MARK: - signUp
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
    //MARK: - fetchUserData
    private func fetchUserData(uid: String) {
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.user = try document.data(as: User.self)
                } catch {
                    print("Error decoding user data: \(error)")
                }
            }
        }
    }
    //MARK: - saveUserData
    private func saveUserData(user: User) {
        do {
            try db.collection("users").document(user.userUID).setData(from: user)
        } catch {
            print("Error saving user data: \(error)")
        }
    }
}
