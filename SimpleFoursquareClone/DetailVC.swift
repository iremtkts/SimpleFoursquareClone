//
//  DetailVC.swift
//  SimpleFoursquareClone
//
//  Created by iremt on 9.03.2023.
//

import UIKit
import MapKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailPlaceNameLabel: UILabel!
    
    @IBOutlet weak var detailPlaceTypeLabel: UILabel!
    
    @IBOutlet weak var detailPlaceAtmosphereLabel: UILabel!
    
    
    @IBOutlet weak var detailMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
