//
//  mainView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        NavigationStack {
            Text("NOW VIEW")
                .navigationTitle("ソヒョン")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button {
                            print("alaram")
                        } label: {
                            Image(systemName: "bell")
                        } //alaram Button
                        .tint(.black)
                        Button {
                            print("ranking")
                        } label: {
                            Image(systemName: "crown")
                        } //ranking Button
                        .tint(.black)
                        Button {
                            print("setting")
                        } label: {
                            Image(systemName: "gearshape")
                        } //setting Button
                        .tint(.black)
                    }
                }
        }//NavigationStack
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
