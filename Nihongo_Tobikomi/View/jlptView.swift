//
//  jlptView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/17/24.
//

import SwiftUI
import FirebaseFirestore

struct jlptView: View {
    var level: String
    @StateObject private var learnviewModel = LearnViewModel()
    
    var body: some View {
        List(learnviewModel.words) { word in
            VStack(alignment: .leading){
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
            }//VStack
        }//List
        .navigationTitle(level)
        .onAppear{
            learnviewModel.fetchWords(for: level)
        }
    }
}

#Preview {
    jlptView(level: "JLPT_N1")
}
