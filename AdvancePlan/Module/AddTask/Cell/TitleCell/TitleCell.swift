//
//  TitleCell.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 12.12.2023.
//

import UIKit

final class TitleCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleTextField: UITextField!
    
    // MARK: - Properties
    
    var title: String {
        get {
            return titleTextField.text ?? ""
        }
        set {
            titleTextField.text = newValue
        }
    }

    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        titleTextField.delegate = self
        titleTextField.returnKeyType = .done
    }
}

// MARK: - UITextFieldDelegate
extension TitleCell: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
