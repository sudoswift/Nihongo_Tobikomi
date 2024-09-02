//
//  addWordView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/17/24.
//

import SwiftUI

struct addWordView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var learnViewModel: LearnViewModel
    
    @State private var jpn: String = ""
    @State private var kr: String = ""
    @State private var grade: String = ""
    @State private var testYear: String = ""
    @State private var createdAt: Date = Date()
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var level: String
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16) {
                    TextField("日本語", text: $jpn)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("한국어", text: $kr)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("JLPT 급수", text: $grade)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("기출년도", text: $testYear)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                Button(action: {
                    checkForDuplicateAndAddWord()
                }) {
                    Text("등록")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("단어 추가")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("등록불가"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func checkForDuplicateAndAddWord() {
        learnViewModel.checkIfWordExists(level: level, jpn: jpn) { exists in
            if exists {
                alertMessage = "중복된 단어입니다"
                showAlert = true
            } else {
                addWordToFirestore()
            }
        }
    }
    
    private func addWordToFirestore() {
        learnViewModel.addWord(level: level, jpn: jpn, kr: kr, grade: grade, testYear: testYear, createdAt: createdAt)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    addWordView(level: "JLPT_N1")
}
