//
//  signInView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 9/4/24.
//

import SwiftUI

struct signInView: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showingSignUpSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("이메일", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("비밀번호", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    signIn()
                }) {
                    Text("로그인")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                Button(action: {
                    showingSignUpSheet.toggle()
                }) {
                    Text("회원가입")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .navigationTitle("로그인")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("로그인 실패"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            .fullScreenCover(isPresented: $showingSignUpSheet) {
                signUpView()
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func signIn() {
        userViewModel.signIn(email: email, password: password) { success in
            if success {
                // Navigate to main content
            } else {
                alertMessage = "로그인 정보가 올바르지 않습니다."
                showAlert = true
            }
        }
    }
}

#Preview {
    signInView()
}
