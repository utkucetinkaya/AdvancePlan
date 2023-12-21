//
//  ReminderCell.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 13.12.2023.
//

import UIKit

protocol ReminderCellDelegate: AnyObject {
    func remindMeSwitchValueChanged(_ isOn: Bool)
}

final class ReminderCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: ReminderCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var remindMeSwitch: UISwitch!

    // MARK: - IBActions
    @IBAction func remindMeSwitchValueChanged(_ sender: UISwitch) {
        delegate?.remindMeSwitchValueChanged(sender.isOn)
    }
}
