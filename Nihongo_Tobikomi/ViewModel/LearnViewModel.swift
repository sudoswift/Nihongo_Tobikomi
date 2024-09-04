//
//  LearnViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/18/24.
//

import Foundation
import FirebaseFirestore

class LearnViewModel: ObservableObject {
    @Published var words: [Learn] = []
    
    private let db = Firestore.firestore()
    private var currentUserUID: String? // 현재 로그인한 사용자의 UID를 저장
    
    // MARK: - Fetch words
    func fetchWords(for level: String) {
        let wordsRef = db.collection("Learn").document(level).collection("Words")
        wordsRef.order(by: "createdAt", descending: true).getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.words = snapshot.documents.compactMap { document in
                    let data = document.data()
                    return Learn(
                        id: document.documentID,
                        grade: data["grade"] as? String ?? "",
                        testYear: data["testYear"] as? String ?? "",
                        jpn: data["jpn"] as? String ?? "",
                        kr: data["kr"] as? String ?? "",
                        createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                    )
                }
            } else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    // MARK: - Add word
    func addWord(level: String, jpn: String, kr: String, grade: String, testYear: String, createdAt: Date) {
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
                self.fetchWords(for: level) // Optionally refresh data
            }
        }
    }

    // MARK: - Check if word exists
    func checkIfWordExists(level: String, jpn: String, completion: @escaping (Bool) -> Void) {
        db.collection("Learn").document(level).collection("Words")
            .whereField("jpn", isEqualTo: jpn)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error checking if word exists: \(error)")
                    completion(false)
                } else {
                    let exists = !querySnapshot!.isEmpty
                    completion(exists)
                }
            }
    }

    // MARK: - Bookmark Management
    func toggleBookmark(for wordID: String) {
        guard let uid = currentUserUID else { return }

        let bookmarkRef = db.collection("Bookmark").document(uid)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let bookmarkDocument: DocumentSnapshot
            do {
                bookmarkDocument = try transaction.getDocument(bookmarkRef)
            } catch let error as NSError {
                print("Error getting document: \(error.localizedDescription)")
                return nil
            }

            let currentBookmarks = bookmarkDocument.data()?["bookmarkedWords"] as? [String] ?? []
            var updatedBookmarks = currentBookmarks

            if updatedBookmarks.contains(wordID) {
                // Remove from bookmarks if it already exists
                updatedBookmarks.removeAll { $0 == wordID }
            } else {
                // Add to bookmarks
                updatedBookmarks.append(wordID)
            }

            transaction.updateData(["bookmarkedWords": updatedBookmarks], forDocument: bookmarkRef)
            return nil
        }) { (object, error) in
            if let error = error {
                print("Error updating bookmarks: \(error.localizedDescription)")
            }
        }
    }

    func isBookmarked(wordID: String, completion: @escaping (Bool) -> Void) {
        guard let uid = currentUserUID else {
            completion(false)
            return
        }

        let bookmarkRef = db.collection("Bookmark").document(uid)
        bookmarkRef.getDocument { document, error in
            if let document = document, document.exists {
                let bookmarkedWords = document.data()?["bookmarkedWords"] as? [String] ?? []
                completion(bookmarkedWords.contains(wordID))
            } else {
                completion(false)
            }
        }
    }
}
