//
//  TaskTableViewController.swift
//  RemindersApp
//
//  Created by Pratheeksha Ravindra Naik on 2018-10-26.
//  Copyright © 2018 . All rights reserved.
//

import os.log
import UIKit

class TaskTableViewController: UITableViewController {
    
    //MARK: Priorities
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedTasks = loadTasks() {
            tasks += savedTasks
        }
        else {
            loadSampleTasks()
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "taskTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let task = tasks[indexPath.row]
        
        cell.ToDoLabel.text  = task.title
        cell.photoImage.image = (task.thumbnail == nil) ? task.photo : task.thumbnail
        cell.dueLabel.text = task.dueDate
        cell.priorityLabel.text = task.priority

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let taskDetailViewController = segue.destination as? TaskViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTaskCell = sender as? TaskTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTask = tasks[indexPath.row]
            taskDetailViewController.task = selectedTask
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        

        if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
            else {
            // Add a new meal.
            let newIndexPath = IndexPath(row: tasks.count, section: 0)
            tasks.append(task)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
            saveTasks()
      }
    }
    
    private func loadSampleTasks() {
        
        let photo1 = UIImage(named: "task1")
        let photo2 = UIImage(named: "task2")
        let photo3 = UIImage(named: "task3")
        
        guard let task1 = Task(title: "Pay Bills", photo: photo1, currentDate: "String", dueDate: "String", priority: "High", notes: "mmm" )
            else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let task2 = Task(title: "Birthday", photo: photo2, currentDate: "String", dueDate: "String", priority: "High", notes: "mmm" ) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let task3 = Task(title: "Call Electrician", photo: photo3, currentDate: "String", dueDate: "String", priority: "High", notes: "mmm"  ) else {
            fatalError("Unable to instantiate meal1")
        }
        
        tasks += [task1, task2, task3]
        
}

    private func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Tasks successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save tasks...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTasks() -> [Task]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
        
    }
    
}
