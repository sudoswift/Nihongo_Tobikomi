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
    //MARK: - addData / Upload라는 컬랙션에 document 이름은 랜덤 uuid로 생성된 랜덤 숫자이고, firestore의 필드값인 "kanji"에 위에서 @Published 한 kanji를 넣는다.
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
    //MARK: - FetchData()
//    func FetchAllData(){
//        uploadList.removeAll()
//        Task{
//            do{
//                try await database.collection("Upload").order(by: "createdAt", descending: false)
//                    .getDocuments{ snapshot, error in
//                        self.uploadList.removeAll()
//                        if let snapshot{
//                            for document in snapshot.documents{
//                                let _: String = document.documentID
//                                let docData = document.data()
//
//                                let title: String = docData["title"] as? String ?? ""
//                                let body: String = docData["body"] as? String ?? ""
//                                let userUID: String = docData["userUID"] as? String ?? ""
//                                let userName: String = docData["userName"] as? String ?? ""
//                                let userProfileURL: String = docData["userProfileURL"] as? String ?? ""
//                                let createdAtTimeStamp = docData["CreatedAt"] as? Timestamp ?? Timestamp()
//                                let createdAt: Date = createdAtTimeStamp.dateValue()
//
//                                let upload: Upload = Upload(title: title, body: body, userUID: userUID, userName: userName, userProfileURL: userProfileURL, createdAt: createdAt)
//                                self.uploadList.append(upload)
//                            }
//                        }
//                    }
//            }catch{
//                print("Cannot Fetch All Data")
//            }
//        }//Task
//    }//FetchAllData()

    
}//class UploadViewModel
