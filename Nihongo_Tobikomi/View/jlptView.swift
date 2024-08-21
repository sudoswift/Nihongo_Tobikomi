//
//  jlptView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/17/24.
//

import SwiftUI
import FirebaseFirestore

struct jlptView: View {
    var levels: String
    @StateObject private var viewModel = LearnViewModel()
    
    var body: some View {
        List(viewModel.words) { word in
            VStack(alignment: .leading){
                Text(word.jpn)
                    .font(.headline)
                Text(word.kr)
                    .font(.subheadline)
                Text("Grade: \(word.grade) | Year: \(word.testYear)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Created at: \(word.createdAt, formatter: viewModel.dateFormatter)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }//VStack
        }//List
    }
}

#Preview {
    jlptView(levels: "JLPT_N1")
}
