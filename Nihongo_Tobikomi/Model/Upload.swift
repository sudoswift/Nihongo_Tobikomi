//
//  Upload.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Foundation
import FirebaseFirestoreSwift

struct Upload: Identifiable, Codable{
    @DocumentID var id: String?
    var kanji: String
    var hanguru: String
    var kanjiLevel: String
    var createdAt: Date
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yy-MM-dd"
        
        let dateCreatedAt = createdAt
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
