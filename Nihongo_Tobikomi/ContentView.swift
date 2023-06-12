//
//  ContentView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.volleyball")
                .font(.system(size: 60))
                .foregroundColor(.black)
                .padding(.bottom, 60)
            Text("にほんご飛び込み")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
