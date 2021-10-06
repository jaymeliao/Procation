//
//  ViewController.swift
//  Procation
//
//  Created by Jayme on 2021-10-04.
//  Copyright © 2021 VJGuo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController {
    @IBOutlet weak var LatLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    //attributes
    var locationManager = CLLocationManager();
    var currentLocation:CLLocation!
    var lock=NSLock()
    
    
    
    // methods
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest

        locationManager.distanceFilter = 50
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
    }
    
    
    
    @IBAction func GoToSettingButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSetting", sender: self)
        
    }
    
    
    

    
    


}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        //lock.lock()
        // get the last location
        if let currentLocation=locations.last {
            print("==============dd=======")
            print("Lat: \(currentLocation.coordinate.latitude)")
            print(currentLocation.coordinate.longitude)
            LatLabel.text = String(format: "%.4f", currentLocation.coordinate.latitude)  // format %.4f : 4 digits after dot
            render(currentLocation)
        }
        
        //print("Lat: \(currentLocation.coordinate.latitude)")
         //print(currentLocation.coordinate.longitude)
         
        
         //LatLabel.text = String(format: "%.4f", currentLocation.coordinate.latitude)  // format %.4f : 4 digits after dot
        
        //lock.unlock()
    }
    
    func render(_ currentLocation:CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        // how zoom : smaller delta value will be closer
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let regino = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(regino, animated: true)
        //add pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
       
    }
    
    private func locationManager(manager:  CLLocationManager, didFailWithError error: NSError) {
        print("Can not Navigate Your Location ！！\(error)")
        
    }
}
