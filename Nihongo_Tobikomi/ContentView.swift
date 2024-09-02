//
//  ContentView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()

    var body: some View {
        Group {
            if Auth.auth().currentUser != nil {
                TabView {
                    mainView()
                        .tabItem {
                            Label("学習", systemImage: "list.bullet.rectangle.portrait.fill")
                        }
                    bookmarkView()
                        .tabItem {
                            Label("復習", systemImage: "book.fill")
                        }
                }
            } else {
                signInView()
            }
        }
        .environmentObject(userViewModel)
    }
}


#Preview {
    ContentView()
}
