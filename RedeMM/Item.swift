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
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
