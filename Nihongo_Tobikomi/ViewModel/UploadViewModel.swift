//
//  UploadViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class UploadViewModel: ObservableObject{
    @Published var uploadList: [Upload] = []
    
    @Published var kanji: String = ""
    @Published var hanguru: String = ""
    @Published var kanjiLevel: String = ""
    @Published var createdAt: Date = Date.now
    
    //MARK: - firestore
    let database = Firestore.firestore()
    
    //MARK: - init
    init(){
        uploadList = [
            Upload(kanji: "例", hanguru: "init예시", kanjiLevel: "N1", createdAt: Date())
        ]
    }
    //MARK: - add data
    func addData() {
        Task{
            do{
                try await database.collection("Upload").document(UUID().uuidString)
                    .setData([
                        "kanji" : kanji,
                        "hanguru" : hanguru,
                        "kanjiLevel" : kanjiLevel,
                        "createdAt" : createdAt,
                    ])
            }catch{
                print("UploadViewModel addData error")
            }
        }//Task
    }// addData()
    
    
    
    
}//class UploadViewModel
