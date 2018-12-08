//
//  DetailTableViewController.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-07.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import UIKit
import CoreData

class DetailTableViewController: UITableViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var student: StudentEntity!
    var editGrade: [String:GradeEntity]!
    
    var gradeByTerm: [Int:[GradeEntity]] {
        var result: [Int:[GradeEntity]] = [:]
        result[1] = editGrade.values.filter({ (grade) -> Bool in
            grade.course!.term == Int32(1)
        })
        result[2] = editGrade.values.filter({ (grade) -> Bool in
            grade.course!.term == Int32(2)
        })
        
        return result
    }
    
    var courses: [CourseEntity] {
        return self.fetch().sorted{$0.code! < $1.code!}.sorted(by: {$0.term < $1.term})
    }
    func fetch() -> [CourseEntity] {
        return try! context.fetch(CourseEntity.fetchRequest())
    }
    
    var courseByTerm: [Int:[CourseEntity]] {
        var result: [Int:[CourseEntity]] = [:]
        result[1] = courses.filter({ (course) -> Bool in
            course.term == Int32(1)
        })
        result[2] = courses.filter({ (course) -> Bool in
            course.term == Int32(2)
        })
        
        return result
    }
    
    var termPoint: [Int:Double] = [:]
    
    @IBAction func btnSave(_ sender: Any) {
        reloadAll()
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            context.rollback()
            print("ROLLBACK")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func calcGpa(grades: [GradeEntity]) -> (totalCredit: Int32, totalWeightedGradePoint: Double, gpa: Double) {
        var totalCredit: Int32 = 0
        var totalWeightedGradePoint: Double = 0.0
        for grade in grades {
            totalCredit += grade.course?.credit ?? 0
            totalWeightedGradePoint += grade.weightedGradePoint
        }
        let gpa = (totalWeightedGradePoint / Double(totalCredit) * 1000).rounded() / 1000
        return (totalCredit, totalWeightedGradePoint, gpa)
    }
    
    func reloadTerm(term: Int) {
        let gpa = calcGpa(grades: gradeByTerm[term]!)
        self.termPoint[term] = gpa.gpa
    }
    
    func reloadTotal() {
        var totalGrades: [GradeEntity] = []
        for grade in editGrade.values {
            totalGrades.append(grade)
        }
        let gpa = calcGpa(grades: totalGrades)
        
        student.totalCredit = gpa.totalCredit
        student.totalWeightGradePoint = gpa.totalWeightedGradePoint
        student.gpa = gpa.gpa
    }
    
    func reloadAll() {
        reloadTerm(term: 1)
        reloadTerm(term: 2)
        reloadTotal()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // edit student
        if let student = self.student {
            self.editGrade = [:]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<GradeEntity> = GradeEntity.fetchRequest();
            fetchRequest.predicate = NSPredicate(format: "student = %@", student)
            let grades: [GradeEntity] = try! context.fetch(fetchRequest)
            for grade in grades {
                if let code = grade.course?.code {
                    self.editGrade[code] = grade
                }
            }
        }
        // new student
        else {
            self.student = StudentEntity(context: context)
            self.editGrade = [:]
            for course in self.courses {
                if let code = course.code {
                    let grade = GradeEntity(context: context);
                    grade.course = course
                    grade.gradePoint = 0
                    grade.student = student
                    self.editGrade[code] = grade
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadAll()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return self.courseByTerm[section]?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Name"
        } else {
            return "TERM" + String(section) + " GPA: " + String(termPoint[section]!)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == tableView.numberOfSections - 1 {
            return "TOTAL GPA: " + String(student.gpa)
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? NameTableViewCell {
                cell.txtName.text = student.name
                cell.editStudent = student
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NameTableViewCell.")
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailTableViewCell {
                if let courses = self.courseByTerm[indexPath.section] {
                    let record = courses[indexPath.row]
                    cell.lbKey.text = record.name
                    if let grade = self.editGrade[record.code!] {
                        cell.editGrade = grade
                        cell.lbValue.text = Mark.getType(point: grade.gradePoint).rawValue
                    }
                    
                    cell.reload = { value in
                        if value {
                            print("Reload")
                            self.reloadAll()
                        }
                    }
                }
                
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of DetailTableViewCell.")
            }
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


