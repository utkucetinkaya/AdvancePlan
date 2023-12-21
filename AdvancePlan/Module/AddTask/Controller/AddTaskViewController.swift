//
//  AddTaskViewController.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 11.12.2023.
///

import UIKit

final class AddTaskViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    let datePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    let sectionTitles = ["Title", "Reminder"]
    let rowHeights = [40, 40, 200]
    
    var titleText: String?
    var dueDate: Date?
    var isRemindMeOn: Bool = false
    
    var reminder: Reminder?
    var isDatePickerShown = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        registerTableView()
        setKeyboard()
        tableView.cellForRow(at: datePickerCellIndexPath)?.isHidden = true
    }
    
    // MARK: - SetNavBar
     func setNavBar() {
        self.navigationItem.title = "Add Plan"
   
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
//     MARK: - SetKeyboard
    private func setKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        tableView.keyboardDismissMode = .onDrag
    }
    
    // MARK: - objc func
    @objc func didTapDoneButton() {
        guard let titleCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleCell else {
            return
        }
        
        let titleText = titleCell.title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !titleText.isEmpty else {
            let alert = UIAlertController(title: "Error!", message: "The title cannot be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let newReminder = Reminder(title: titleText, dueDate: dueDate)
        
        ReminderManager.shared.create(reminder: newReminder)
        self.navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - TableViewRegister
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TitleCell.nameOfClass, bundle: nil), forCellReuseIdentifier: TitleCell.nameOfClass)
        tableView.register(UINib(nibName: DateCell.nameOfClass, bundle: nil), forCellReuseIdentifier: DateCell.nameOfClass)
        tableView.register(UINib(nibName: ReminderCell.nameOfClass, bundle: nil), forCellReuseIdentifier: ReminderCell.nameOfClass)
    }
    
    func updateCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - DateCellDelegate
extension AddTaskViewController: DateCellDelegate {
    func datePickerValueChanged(_ date: Date) {
        dueDate = date
    }
}

// MARK: - ReminderCellDelegate
extension AddTaskViewController: ReminderCellDelegate {
    func remindMeSwitchValueChanged(_ isOn: Bool) {
        isRemindMeOn = isOn
        if isRemindMeOn {
            tableView.beginUpdates()
            tableView.cellForRow(at: datePickerCellIndexPath)?.isHidden = false
            tableView.endUpdates()
            
        } else {
            tableView.beginUpdates()
            tableView.cellForRow(at: datePickerCellIndexPath)?.isHidden = true
            tableView.endUpdates()
            
            dueDate = nil
        }
        if !isRemindMeOn {
            isDatePickerShown = false
        }
        updateCells()
    }
}
