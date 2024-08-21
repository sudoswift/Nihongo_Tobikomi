//
//  LearnViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/18/24.
//

import Foundation
import FirebaseFirestore

class LearnViewModel: ObservableObject{
    @Published var words: [Learn] = []
    
    private let db = Firestore.firestore()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func fetchWords(for level: String) {
        let wordsRef = db.collection("Learn").document(level).collection("Words")
        wordsRef.order(by: "createdAt", descending: true).getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.words = snapshot.documents.compactMap { document in
                    let data = document.data()
                    return Learn(
                        id: document.documentID,
                        grade: data["grade"] as? String ?? "",
                        testYear: data["testYear"] as? Int ?? 0,
                        jpn: data["jpn"] as? String ?? "",
                        kr: data["kr"] as? String ?? "",
                        createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                    )
                }
            } else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
            }
            
        }
    }//func fetchWords
    
    func addWord(level: String, jpn: String, kr: String, grade: String, testYear: Int, createdAt: Date) {
        let wordsRef = db.collection("Learn").document(level).collection("Words").document()
        
        wordsRef.setData([
            "jpn": jpn,
            "kr": kr,
            "grade": grade,
            "testYear": testYear,
            "createdAt": Timestamp(date: createdAt)
        ]) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                // Successfully added the document
                self.fetchWords(for: level) // Optionally refresh data
            }
        }
    }//func addWord
    
} //class
