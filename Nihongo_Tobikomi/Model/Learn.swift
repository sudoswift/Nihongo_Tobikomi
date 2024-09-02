//
//  Learn.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/18/24.
//

import Foundation

struct Learn: Identifiable{
    var id: String = UUID().uuidString
    var grade: String
    var testYear: String
    var jpn: String
    var kr: String
    var createdAt: Date
}
