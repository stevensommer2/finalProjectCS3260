//
//  ViewController.swift
//  PhotoSettingRecords
//
//  Created by Steven Sommer on 8/11/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var ObjectArray = [photoObject]()
    //var object = photoObject(ISO:"2000", Aperature:"f2.8", ShutterSpeed:"1/100", Desc:"Dark Indoor")
    //var object1 = photoObject(ISO:"1000", Aperature:"f5.4", ShutterSpeed:"1/1000", Desc:"Low Light")
    var passingIndexPath = 5000
    var db: OpaquePointer?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ObjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        cell.textLabel?.text = ObjectArray[indexPath.row].Description
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = "ISO: " + ObjectArray[indexPath.row].ISOSetting + " Aperature: " + ObjectArray[indexPath.row].AperatureSetting + " Shutter Speed: " + ObjectArray[indexPath.row].ShutterSpeedSetting
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            ObjectArray.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        passingIndexPath = indexPath.row
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ObjectArray.append(object)
        //ObjectArray.append(object1)
        self.title = "Photo Records"
        
        //the database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("HeroesDatabase.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Records (id INTEGER PRIMARY KEY AUTOINCREMENT, iso TEXT, aperture TEXT, shutterspeed TEXT, description TEXT)", nil, nil, nil) != SQLITE_OK {
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error creating table: \(errmsg)")
        }
        
        readValues()
        
    }
    
    func prepare(for segue:UIStoryboardSegue, sender: UITableViewCell) {
        
        let destVCEntrance = segue.destination as! RecordEditor
        destVCEntrance.passedIndexPath = passingIndexPath
        
    }
    
    func readValues(){
     
            //first empty the list of heroes
            ObjectArray.removeAll()
     
            //this is our select query
            let queryString = "SELECT * FROM Records"
     
            //statement pointer
            var stmt:OpaquePointer?
     
            //preparing the query
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
     
            //traversing through all the records
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = sqlite3_column_int(stmt, 0)
                let iso = String(cString: sqlite3_column_text(stmt, 1))
                let aperture = String(cString: sqlite3_column_text(stmt, 2))
                let shutterspeed = String(cString: sqlite3_column_text(stmt, 3))
                let description = String(cString: sqlite3_column_text(stmt, 4))
                
                //adding values to list
                let newRecord = photoObject(ID: Int(id), ISO: String(iso), Aperature: String(aperture), ShutterSpeed: String(shutterspeed), Desc: String(description))
                
                
                    ObjectArray.append(newRecord)
            }
        
    }
    
    
    



}
