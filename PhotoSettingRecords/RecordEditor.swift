//
//  RecordEditor.swift
//  PhotoSettingRecords
//
//  Created by Steven Sommer on 8/12/21.
//

import UIKit

class RecordEditor: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit"
        
        
        
    }
    
    
    var passedIndexPath = 0
    @IBOutlet weak var ISOOutletEdit: UITextField!
    @IBOutlet weak var ApertureOutletEdit: UITextField!
    @IBOutlet weak var ShutterSpeedOutletEdit: UITextField!
    @IBOutlet weak var DescriptionOutletEdit: UITextField!
    
    //func tableView(_ tableView: UITableVIew, didSelectRowat indexPath: IndexPath) {
        
    //}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let PassedISO = ISOOutletEdit?.text
        let PassedAper = ApertureOutletEdit?.text
        let PassedShutterSpeed = ShutterSpeedOutletEdit?.text
        let PassedDescription = DescriptionOutletEdit?.text
        
        let EditedObject = photoObject(ID: passedIndexPath, ISO:PassedISO ?? " ", Aperature:PassedAper ?? " ", ShutterSpeed:PassedShutterSpeed ?? " ", Desc:PassedDescription ?? "No Description")
        
        let destVC = segue.destination as! ViewController
        destVC.ObjectArray[passedIndexPath] = EditedObject
        //destVC.ObjectArray[] = EditedObject
        
        
        
    }}
