//
//  StudentTableViewController.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-06.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import UIKit
import CoreData

class StudentTableViewController: UITableViewController {

    var dataArray: [StudentEntity] {
        return self.fetch().sorted(by: { $0.name! < $1.name! })
    }
    
    var selectedStudent: StudentEntity?
    
    var context: NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetch() -> [StudentEntity] {
        return try! context.fetch(StudentEntity.fetchRequest())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        context.rollback()
        self.tableView.reloadData()
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as? StudentTableViewCell {
            
            let record = self.dataArray[indexPath.row]
            cell.lbName.text = record.name
            cell.lbGrade.text = String(record.gpa)
            
            return cell
        } else {
            fatalError("The dequeued cell is not an instance of RestaurantTableViewCell.")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedStudent = self.dataArray[indexPath.row]
        self.performSegue(withIdentifier: "details", sender: indexPath.row)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailTableViewController {
            if let selected = self.selectedStudent {
                dest.student = selected
            }
        }
    }
 
    // ADD Button
    @IBAction func btnAdd(_ sender: Any) {
        self.selectedStudent = nil
        self.performSegue(withIdentifier: "details", sender: 0)
    }
    
}
