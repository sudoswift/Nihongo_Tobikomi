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
        //사용자의 데이터를 가져옴
        let db = Firestore.firestore()
        db.collection("User").document(uid).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                do {
                    // Firestore에서 가져온 데이터 디코딩
                    let userData = try document.data(as: User.self)
                    // user 프로퍼티 업데이트
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
                //Auth.auth().signIn으로 email과 password가 일치 했을 때 로그인이 되고 userUID를 가져와서 fetchUserData에서 uid를 기반으로 유저의 정보를 가져온다.
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
                let uid = authResult?.user.uid ?? "" // uid 생성
                let newUser = User(userName: userName, userUID: uid, userEmail: email) //newUser에 회원가입 화면에서 입력받은 userName, email과 윗줄의 uid를 저장함
                self.saveUserData(user: newUser) //saveUserData를 이용해 firebase에 user 정보를 입력함(userName, userEmail, userUID)
                self.user = newUser
                completion(true)
            }
        }
    }
    //MARK: - 회원가입 시 firebase의 User 컬렉션에 정보 입력
    private func saveUserData(user: User) {
        let db = Firestore.firestore()
        do {
            try db.collection("User").document(user.userUID).setData(from: user)
        } catch {
            print("Error saving user data: \(error.localizedDescription)")
        }
    }

}
