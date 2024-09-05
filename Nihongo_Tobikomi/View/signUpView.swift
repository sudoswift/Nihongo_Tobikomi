//
//  signUpView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 9/4/24.
//

import SwiftUI

struct signUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var userViewModel = UserViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userName: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("이메일", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                SecureField("비밀번호", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("사용자 이름", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                Button(action: {
                    signUp()
                }) {
                    Text("회원가입")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("회원가입")
            .navigationBarItems(trailing: Button(action: {
                // SignInView로 돌아가기 위해 현재 뷰를 닫음
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("회원가입 실패"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func signUp() {
        userViewModel.signUp(email: email, password: password, userName: userName) { success in
            if success {
                // 회원가입 성공 시, 현재 뷰를 닫고 signInView로 돌아가게 함
                presentationMode.wrappedValue.dismiss()
            } else {
                alertMessage = "회원가입에 실패했습니다."
                showAlert = true
            }
        }
    }
}

#Preview {
    signUpView()
}
