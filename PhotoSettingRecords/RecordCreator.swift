//
//  RecordCreator.swift
//  PhotoSettingRecords
//
//  Created by Steven Sommer on 8/13/21.
//

import UIKit
import SQLite3

class RecordCreator: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UnwindToHomeScreen(_ sender: UIStoryboardSegue){
       
    }
    
    @IBOutlet weak var ISOOutlet: UITextField!
    @IBOutlet weak var ApertureOutlet: UITextField!
    @IBOutlet weak var ShutterSpeedOutlet: UITextField!
    @IBOutlet weak var DescriptionOutlet: UITextField!
    
    
    @IBAction func CreateNewObject(_ sender: Any) {
        
    }
    
   
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let PassedISO = ISOOutlet?.text
        let PassedAper = ApertureOutlet?.text
        let PassedShutterSpeed = ShutterSpeedOutlet?.text
        let PassedDescription = DescriptionOutlet?.text
        
        //let NewObject = photoObject(ISO:PassedISO ?? " ", Aperature:PassedAper ?? " ", ShutterSpeed:PassedShutterSpeed ?? " ", Desc:PassedDescription ?? "No Description")
        
        let destVC = segue.destination as! ViewController
        //destVC.ObjectArray.append(NewObject)
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO Records (iso, aperture, shutterspeed, description) VALUES (?,?,?,?)"
        
        //preparing the query
        if sqlite3_prepare(destVC.db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(destVC.db)!)
                   print("error preparing insert: \(errmsg)")
                   return
               }
        
               //binding the parameters
               if sqlite3_bind_text(stmt, 1, PassedISO, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(destVC.db)!)
                   print("failure binding name: \(errmsg)")
                   return
               }
        
               if sqlite3_bind_text(stmt, 2, PassedAper, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(destVC.db)!)
                   print("failure binding name: \(errmsg)")
                   return
               }
        
            if sqlite3_bind_text(stmt, 3, PassedShutterSpeed, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(destVC.db)!)
                print("failure binding name: \(errmsg)")
                return
            }
        
            if sqlite3_bind_text(stmt, 3, PassedDescription, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(destVC.db)!)
                print("failure binding name: \(errmsg)")
                return
            }
        
        
            //executing the query to insert values
               if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(destVC.db)!)
                   print("failure inserting Record: \(errmsg)")
                   return
               }
        
               //emptying the textfields
               
        
        
                destVC.readValues()
        
               //displaying a success message
               print("Record saved successfully")
        
        
        
        
    }
    

 

}
