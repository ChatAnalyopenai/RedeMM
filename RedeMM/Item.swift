//
//  Item.swift
//  RedeMM
//
//  Created by rafael dalazen araujo on 07/06/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var title: String
    var description: String
    var category: String
    
    init(timestamp: Date, title: String = "", description: String = "", category: String = "General") {
        self.timestamp = timestamp
        self.title = title
        self.description = description
        self.category = category
    }
}
