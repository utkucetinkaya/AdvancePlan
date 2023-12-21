//
//  TaskModel.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 1.12.2023.
//

import Foundation

struct Reminder: Codable {
    var id = UUID().uuidString
    var title: String
    var dueDate: Date?
    var isCompleted: Bool = false
}
