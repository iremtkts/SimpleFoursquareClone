//
//  DetailVC.swift
//  SimpleFoursquareClone
//
//  Created by iremt on 9.03.2023.
//

import UIKit
import MapKit
import Parse

class DetailVC: UIViewController , MKMapViewDelegate {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailPlaceNameLabel: UILabel!
    
    @IBOutlet weak var detailPlaceTypeLabel: UILabel!
    
    @IBOutlet weak var detailPlaceAtmosphereLabel: UILabel!
    
    var chosenPlaceID = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    @IBOutlet weak var detailMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        detailMapView.delegate = self
    }
    
    func getDataFromParse () {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceID)
        query.findObjectsInBackground{ objects , error in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        
                        //objects
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.detailPlaceNameLabel.text = placeName
                        }
                        
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.detailPlaceTypeLabel.text = placeType
                        }
                        
                        if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.detailPlaceAtmosphereLabel.text = placeAtmosphere
                        }
                        
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { data , error in
                                if error == nil {
                                    if data != nil {
                                        self.detailImageView.image = UIImage(data: data!)
                                    }
                                }
                                
                            }
                        }
                        
                        
                        // maps
                        
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                        
                        let region = MKCoordinateRegion(center: location, span: span)
                        
                        self.detailMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailPlaceNameLabel.text!
                        annotation.subtitle = self.detailPlaceTypeLabel.text!
                        self.detailMapView.addAnnotation(annotation)
                    }
                }
            }
        }
           
        func mapView(_ mapView: MKMapView, viewForAnnotation annotation : MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                pinView?.tintColor = .systemPink
                let button = UIButton(type: .detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
            } else {
                pinView?.annotation = annotation
            }
            return pinView
        }

        
        func mapView(_ mapView:MKMapView,annotationView view:MKAnnotationView,calloutAccessoryControlTapped control:UIControl) {
            if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
                let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                
                CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks , error in
                    if let placemark = placemarks {
                        if placemark.count > 0 {
                            let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                            let mapItem = MKMapItem(placemark: mkPlaceMark)
                            mapItem.name = self.detailPlaceNameLabel.text
                            
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            
                            mapItem.openInMaps(launchOptions: launchOptions)
                        }
                    }
                    
                }
            }
        }
        
        
    }
    

}
