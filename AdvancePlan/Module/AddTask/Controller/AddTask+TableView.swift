//
//  AddTask+TableView.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 21.12.2023.
//

import UIKit

// MARK: - TableViewProtocols
extension AddTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.nameOfClass, for: indexPath) as? TitleCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.nameOfClass, for: indexPath) as? ReminderCell else {
                    return UITableViewCell()
                }
                cell.delegate = self
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.nameOfClass, for: indexPath) as? DateCell else {
                    return UITableViewCell()
                }
                cell.setDatePickerMinimumDate()
                cell.updateDateViews()
                cell.delegate = self
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 1 {
            isDatePickerShown.toggle()
            updateCells()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == datePickerCellIndexPath {
            return isRemindMeOn ? CGFloat(rowHeights[indexPath.section]) : 1
        }
        return CGFloat(rowHeights[indexPath.section])
    }
}
