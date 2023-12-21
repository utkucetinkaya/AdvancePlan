//
//  TaskListViewController.swift
//  AdvancePlan
//
//  Created by Utku Çetinkaya on 5.12.2023.
//

import UIKit

final class TaskListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReminderManager.shared.loadReminders()
        tableView.reloadData()
    }
    
    private func setNavBar() {
        self.navigationItem.title = "Advance Plan"
        navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .primaryTint
    }
    
    @objc private func didTapAddButton() {
        let vc = AddTaskViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - RegisterCollectionView
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TaskListCell.nameOfClass, bundle: nil), forCellReuseIdentifier: TaskListCell.nameOfClass)
    }
}

// MARK: - UITableViewDelegate,DataSource
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderManager.shared.getAllReminders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskListCell.nameOfClass, for: indexPath) as? TaskListCell else {
            return UITableViewCell()
        }
        
        let reminder = ReminderManager.shared.getAllReminders()[indexPath.row]
        cell.setCell(with: reminder)
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .listCellBackground
        cell.backgroundConfiguration = backgroundConfiguration

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedReminder = ReminderManager.shared.getAllReminders()[indexPath.row]
        
        let completeAction = UIContextualAction(style: .normal, title: nil, handler: { (_, _, completion) in
            completion(true)
            
            ReminderManager.shared.setComplete(reminder: selectedReminder)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            tableView.reloadData()
        })
        
        completeAction.image = selectedReminder.isCompleted ? UIImage(systemName: "minus.circle.fill") : UIImage(systemName: "checkmark.circle.fill")
        completeAction.backgroundColor = selectedReminder.isCompleted ? .defaultTagView : .primaryTint
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let reminderToDelete = ReminderManager.shared.getAllReminders()[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completed) in
            completed(true)
            ReminderManager.shared.delete(reminder: reminderToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
