//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-21.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var addPinButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var isAddingPin: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        // tap
        let singleTapRecognize = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(singleTapRecognize)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    
    // MARK: - MapView
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!)
            }
        }
    }
    
    @IBAction func insertPin(_ sender: Any) {
        let addNewLocationViewController = self.storyboard?.instantiateViewController(identifier: "AddNewLocation") as! AddNewLocationViewController
        present(addNewLocationViewController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func reloadMap(_ sender: Any) {
    }
    
    
    // MARK: - Gestures
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("==============================> tap")
        return !(touch.view is MKPinAnnotationView)
//        return true
    }
    
    
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Title"
            annotation.subtitle = "Subtitle"
            
            mapView.addAnnotation(annotation)
            
            print("loooong tap")
            print(coordinate.latitude)
            print(coordinate.longitude)
            print(mapView.annotations.count)
            print("-----------")
        }
        
        
    }
    
}
