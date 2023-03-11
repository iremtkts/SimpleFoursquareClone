//
//  PlaceModel.swift
//  SimpleFoursquareClone
//
//  Created by iremt on 11.03.2023.
//

import Foundation
import UIKit

class PlaceModel{
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    
    private init(){
        
    }
    
}
