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
        let db = Firestore.firestore()
        db.collection("User").document(uid).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                do {
                    let userData = try document.data(as: User.self)
                    self?.user = userData
                } catch {
                    print("사용자 데이터 디코딩 오류: \(error.localizedDescription)")
                }
            } else {
                print("문서가 존재하지 않습니다.")
            }
        }
    }
    
    //MARK: - 로그인
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign In Error: \(error.localizedDescription)")
                completion(false)
            } else {
                self.fetchUserData(uid: authResult?.user.uid ?? "")
                completion(true)
            }
        }
    }
    
    //MARK: - 회원가입
    func signUp(email: String, password: String, userName: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign Up Error: \(error.localizedDescription)")
                completion(false)
            } else {
                let uid = authResult?.user.uid ?? ""
                let newUser = User(userName: userName, userUID: uid, userEmail: email)
                self.saveUserData(user: newUser)
                self.user = newUser
                completion(true)
            }
        }
    }
    //MARK: - 회원가입 후 firebase의 User 컬렉션에 저장
    private func saveUserData(user: User) {
        let db = Firestore.firestore()
        do {
            try db.collection("User").document(user.userUID).setData(from: user)
        } catch {
            print("Error saving user data: \(error.localizedDescription)")
        }
    }
    //MARK: - 로그아웃
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign Out Error: \(error.localizedDescription)")
        }
    }
    
}

