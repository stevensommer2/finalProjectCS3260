//
//  ObjectClass.swift
//  PhotoSettingRecords
//
//  Created by Steven Sommer on 8/12/21.
//

import Foundation

class photoObject {
    var id : Int
    var ISOSetting : String
    var AperatureSetting : String
    var ShutterSpeedSetting : String
    var Description : String
    
    init( ID : Int, ISO : String, Aperature : String, ShutterSpeed : String, Desc : String){
        self.id = ID
        self.ISOSetting = ISO
        self.AperatureSetting = Aperature
        self.ShutterSpeedSetting = ShutterSpeed
        self.Description = Desc
    }
    
    
    
    //Possibly will need to store the image that will be uploaded from the camera roll
}
