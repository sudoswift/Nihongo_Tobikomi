//
//  LearnViewModel.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/18/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class LearnViewModel: ObservableObject {
    @Published var words: [Learn] = []
    @Published var bookmarkedWords: [Learn] = [] // 북마크된 단어를 저장할 프로퍼티
    
    private let db = Firestore.firestore()

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
    
    // MARK: - Bookmark functions
    func toggleBookmark(for word: Learn) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let bookmarkRef = db.collection("Bookmark").document(userID)
        
        bookmarkRef.getDocument { document, error in
            if let document = document, document.exists {
                var bookmarkData = document.data() ?? [:]
                var bookmarkedIDs = bookmarkData["bookmarkedWords"] as? [String] ?? []
                
                if let index = bookmarkedIDs.firstIndex(of: word.id) {
                    bookmarkedIDs.remove(at: index) // Remove bookmark
                } else {
                    bookmarkedIDs.append(word.id) // Add bookmark
                }
                
                bookmarkRef.setData(["bookmarkedWords": bookmarkedIDs]) { error in
                    if let error = error {
                        print("Error updating bookmark: \(error.localizedDescription)")
                    }
                }
            } else {
                // Create a new bookmark document
                bookmarkRef.setData(["bookmarkedWords": [word.id]]) { error in
                    if let error = error {
                        print("Error adding bookmark: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    // MARK: - Fetch Bookmarked Words
    func fetchBookmarkedWords(for level: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let bookmarkRef = db.collection("Bookmark").document(userID)
        bookmarkRef.getDocument { document, error in
            if let document = document, document.exists {
                if let bookmarkedIDs = document.data()?["bookmarkedWords"] as? [String] {
                    self.fetchWordsDetails(for: bookmarkedIDs, level: level)
                }
            } else {
                print("No bookmarks found for user.")
            }
        }
    }

    private func fetchWordsDetails(for ids: [String], level: String) {
        let group = DispatchGroup()
        var tempBookmarkedWords: [Learn] = []

        for id in ids {
            group.enter()
            let docRef = db.collection("Learn").document(level).collection("Words").document(id)
            docRef.getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data() ?? [:]
                    let word = Learn(
                        id: document.documentID,
                        grade: data["grade"] as? String ?? "",
                        testYear: data["testYear"] as? String ?? "",
                        jpn: data["jpn"] as? String ?? "",
                        kr: data["kr"] as? String ?? "",
                        createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                    )
                    tempBookmarkedWords.append(word)
                } else {
                    print("Error fetching word details: \(error?.localizedDescription ?? "Unknown error")")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.bookmarkedWords = tempBookmarkedWords
        }
    }
}
