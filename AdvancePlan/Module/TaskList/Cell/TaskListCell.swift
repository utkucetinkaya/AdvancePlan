//
//  TaskListCell.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 5.12.2023.
//

import UIKit

final class TaskListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tagView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - SetCell
    func setCell(with reminder: Reminder) {
        titleLabel.text = reminder.title
        tagView.backgroundColor = reminder.isCompleted ? .primaryTint : .lightGray
        if let dueDate = reminder.dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "tr")
            dateLabel.text = dateFormatter.string(from: dueDate)
        } else {
            dateLabel.text = nil
        }
    }
}
