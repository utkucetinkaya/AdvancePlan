//
//  DateCell.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 12.12.2023.
//

import UIKit

protocol DateCellDelegate: AnyObject {
    func datePickerValueChanged(_ date: Date)
}

final class DateCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: DateCellDelegate?
    
    // MARK: - IBOutlet
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - IBAction
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        delegate?.datePickerValueChanged(sender.date)
    }
    
    // MARK: - Functions
    func updateDateViews() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    func setDatePickerMinimumDate() {
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .minute)
        datePicker.minimumDate = Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
}
