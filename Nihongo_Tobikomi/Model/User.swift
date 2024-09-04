//
//  User.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/10/03.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Equatable{
    @DocumentID var id: String?
    var userName: String
    var userUID: String
    var userEmail: String
}
