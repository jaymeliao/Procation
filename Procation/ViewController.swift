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
    @IBOutlet weak var LongLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    //attributes
    var locationManager = CLLocationManager();
    var currentLocation:CLLocation!
    var lock=NSLock()
    
    //Text on Contact btns
    @IBOutlet weak var ContactBtnOneName: UIButton!

    //===========================
    
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! SettingPageViewController
       
        vc.mycompletionHandler = { text in
            //self.ContactName1.text=text
            self.ContactBtnOneName.setTitle(text, for: .normal)
        }
        present(vc,animated: true)
        
        
        
        // performSegue(withIdentifier: "goToSetting", sender: self)
        
    }
    
    @IBAction func callContact1(_ sender: UIButton) {
        

        callNumber(phoneNumber: "7788065724")
        
        
    }
    
    
    
    
    
    /*===================Backup start
    @IBAction func callContact1(_ sender: UIButton) {
        
        print("Hello")
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! SettingPageViewController
       
        vc.mycompletionHandler = { text in
            //self.ContactName1.text=text
            self.ContactBtnOneName.setTitle(text, for: .normal)
        }
        present(vc,animated: true)
        //callNumber(phoneNumber: "7788065724")
        
        
    }
    
    
    ===============Backup callContact1 end*/
    
    private func callNumber(phoneNumber:String) {
       //"tel://\(+46706106310)"
       if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
          application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
       }
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
            LatLabel.text = "Latitute:  " + String(format: "%.4f", currentLocation.coordinate.latitude)  // format %.4f : 4 digits after dot
            LongLabel.text = "Longitude:  " + String(format: "%.4f", currentLocation.coordinate.longitude)
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

