//
//  ViewController.swift
//  17_02_25_Sqlite_Demo
//
//  Created by Vishal Jagtap on 09/05/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBHelper.shared.insertStudentRecords(rN: 102, name: "Sakshi")
        DBHelper.shared.insertStudentRecords(rN: 103, name: "Suhaan")
        DBHelper.shared.insertStudentRecords(rN: 104, name: "Pooja")
        
        DBHelper.shared.deleteStudentRecord(rn: 102)
    }
}
