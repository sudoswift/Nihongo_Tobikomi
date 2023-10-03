//
//  User.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable{
    @DocumentID var id: String?
    var userName: String
    var userStateMessage: String
    var userIconURL: String
    var userUID: String
    var userEmail: String
    var userTarget: String
}
