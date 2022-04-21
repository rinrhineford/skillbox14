//
//  ViewController3.swift
//  Skillbox HW 14
//
//  Created by Nikita Selianin on 09.09.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit
import CoreData

class ViewController3: UIViewController {

    var tasks = [Task]()
    var user: User!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func pushAddAction(_ sender: Any) {
        let ac = UIAlertController(title: "Добавить задачу", message: "Добавить задачу?", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Добавить", style: .cancel, handler: { action in
            let textField = ac.textFields?.first
            
            let context = connectContext()
            let task = Task(context: context)
            task.taskDescription = textField?.text
            
            let tasks = self.user.tasks?.mutableCopy() as? NSMutableOrderedSet
            tasks?.add(task)
            self.user.tasks = tasks
            
            saveContext(context: context)
            self.tableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        ac.addTextField(configurationHandler: { textField in
        })
        ac.addAction(add)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.tableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
    }

}

extension ViewController3: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let userTasks = user.tasks else { print("No tasks atm."); return 1 }
        return userTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task")
        
        guard let task = user.tasks?[indexPath.row] as? Task, let taskDescription = task.taskDescription else {
            return UITableViewCell()
        }
        
        cell?.textLabel?.text = taskDescription
        
        if task.isResolved {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let taskToDelete = user.tasks?[indexPath.row] as? Task, editingStyle == .delete else { print("No task to delete."); return }
        let context = connectContext()
        context.delete(taskToDelete)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let taskToMove = user.tasks?[sourceIndexPath.row] as? Task else { print("No task to move."); return }
        let context = connectContext()
        context.delete(taskToMove)
        
        let task = Task(context: context)
        task.isResolved = taskToMove.isResolved
        task.taskDescription = taskToMove.taskDescription
        
        let tasks = self.user.tasks?.mutableCopy() as? NSMutableOrderedSet
        tasks?.insert(task, at: destinationIndexPath.row)
        user.tasks = tasks
        
        saveContext(context: context)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let task = user.tasks?[indexPath.row] as? Task else { print("Can't insert task to complete."); return }
        task.isResolved.toggle()
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        let context = connectContext()
        saveContext(context: context)
    }
}

extension ViewController3 {
    func loadTasks() {
        let userName = "User"
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", userName)
        let context = connectContext()
        
        do {
            let users = try context.fetch(fetchRequest)
            if users.isEmpty {
                user = User(context: context)
                user.name = userName
                try context.save()
            } else {
                user = users.first
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
}
