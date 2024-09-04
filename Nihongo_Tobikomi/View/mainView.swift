//
//  mainView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct mainView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    let jlptLevels = ["JLPT_N1", "JLPT_N2", "JLPT_N3", "JLPT_N4", "JLPT_N5"]

    private func height(for level: String) -> CGFloat {
        switch level {
        case "JLPT_N1":
            return 180
        case "JLPT_N2":
            return 140
        case "JLPT_N3":
            return 90
        case "JLPT_N4":
            return 60
        case "JLPT_N5":
            return 40
        default:
            return 60
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(jlptLevels, id: \.self) { level in
                            NavigationLink(destination: jlptView(level: level)
                                .environmentObject(userViewModel)) { // Add this line
                                Text(level)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, minHeight: height(for: level))
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                    )
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }

                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle(userViewModel.user?.userName ?? "ソヒョン")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("signOut")
                        userViewModel.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }
                    .tint(.black)
                }
            }
        }
    }
}

#Preview {
    mainView()
        .environmentObject(UserViewModel()) // UserViewModel 주입
}
