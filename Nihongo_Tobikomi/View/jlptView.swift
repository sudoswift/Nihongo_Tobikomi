//
//  jlptView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/17/24.
//

import SwiftUI

struct jlptView: View {
    var level: String
    @StateObject private var learnViewModel = LearnViewModel()
    @State private var showAddWordView = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List(learnViewModel.words) { word in
                    VStack(alignment: .leading) {
                        Text(word.jpn)
                            .font(.headline)
                        Text(word.kr)
                            .font(.subheadline)
                        Text("급수: \(word.grade) | 기출년도: \(word.testYear)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .onAppear {
                    learnViewModel.fetchWords(for: level)
                }
                .navigationTitle(level)
            }
            
            // Floating Action Button
            Button(action: {
                showAddWordView.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .padding()
            }
            .sheet(isPresented: $showAddWordView) {
                addWordView(level: level)
                    .environmentObject(learnViewModel)
            }
            .padding() // Adjusts the spacing from the screen edges
        }
    }
}

#Preview {
    jlptView(level: "JLPT_N1")
}
