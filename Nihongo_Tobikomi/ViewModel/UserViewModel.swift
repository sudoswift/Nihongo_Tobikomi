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
    
    //MARK: - Firebase User 컬렉션에서 정보를 가져옴
    private func fetchUserData(uid: String) {
        // 사용자 데이터를 가져오는 로직
    }
    
    //MARK: - 로그인
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign In Error: \(error.localizedDescription)")
            } else {
                //Auth.auth().signIn으로 email과 password가 일치 했을 때 로그인이 되고 userUID를 가져와서 fetchUserData에서 uid를 기반으로 유저의 정보를 가져온다.
                self.fetchUserData(uid: authResult?.user.uid ?? "")
            }
        }
    }
    
    //MARK: - 회원가입
    func signUp(email: String, password: String, userName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign Up Error: \(error.localizedDescription)")
            } else {
                let uid = authResult?.user.uid ?? "" // uid 생성
                let newUser = User(userName: userName, userUID: uid, userEmail: email) //newUser에 회원가입 화면에서 입력받은 userName, email과 윗줄의 uid를 저장함
                self.saveUserData(user: newUser) //saveUserData를 이용해 firebase에 user 정보를 입력함(userName, userEmail, userUID)
                self.user = newUser
            }
        }
    }
    
    private func saveUserData(user: User) {
        // 사용자 데이터를 저장하는 로직
    }
}
