//
//  jlptView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/17/24.
//

import SwiftUI

struct jlptView: View {
    var level: String
    @StateObject private var learnviewModel = LearnViewModel()
    @State private var showingAddWordView = false
    
    var body: some View {
        VStack {
            List(learnviewModel.words) { word in
                VStack(alignment: .leading) {
                    Text(word.jpn)
                        .font(.headline)
                    Text(word.kr)
                        .font(.subheadline)
                    Text("Grade: \(word.grade) | Year: \(word.testYear)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Created at: \(word.createdAt, formatter: learnviewModel.dateFormatter)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            // Floating action button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddWordView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(level)
        .onAppear {
            learnviewModel.fetchWords(for: level)
        }
        .sheet(isPresented: $showingAddWordView) {
            addWordView(level: level)
                .environmentObject(learnviewModel)
        }
    }
}

#Preview {
    jlptView(level: "JLPT_N1")
}
