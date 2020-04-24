//
//  AddNewLocationViewController.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-22.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import UIKit
import MapKit

class AddNewLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var selectedLocationLabel: UILabel!
    @IBOutlet weak var selectedLocationButton: UIButton!
    @IBOutlet weak var findOnMapButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var isLoadingSpinner: UIActivityIndicatorView!
    
    var originalMapRegion: MKCoordinateRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        selectedLocationLabel.isHidden = true
        selectedLocationButton.isHidden = true
        submitButton.isEnabled = false
        
        originalMapRegion = self.mapView.region
        
    }

    @IBAction func findOnMapButton(_ sender: Any) {
        let geocode = CLGeocoder()
        
        isLoadingSpinner.startAnimating()
        mapView.alpha = 0.2
        
        guard let address = inputTextField.text else {
            isLoadingSpinner.stopAnimating()
            mapView.alpha = 1.0
            return
        }
        
        geocode.geocodeAddressString(address) { (place, error) in
            if let place = place {
                if (place.count > 0) {

                    // clear previous pin
                    self.mapView.removeAnnotations(self.mapView.annotations)

                    let location = place[0]
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: location.location!.coordinate.latitude, longitude: location.location!.coordinate.longitude)
                    annotation.title = "\(address)"
                    self.mapView.addAnnotation(annotation)
                    let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
                    
                    self.mapView.setRegion(coordinateRegion, animated: true)
                    self.titleLabel.text = "Link to share"
                    self.selectedLocationButton.isHidden = false
                    self.selectedLocationLabel.isHidden = false
                    self.selectedLocationLabel.text = address
                    print(place[0])
                    self.inputTextField.text = ""
                    self.findOnMapButton.isHidden = true
                    self.submitButton.isEnabled = true
                    self.isLoadingSpinner.stopAnimating()
                    self.mapView.alpha = 1.0
                }
            }

            if error != nil {
                self.isLoadingSpinner.stopAnimating()
                self.mapView.alpha = 1.0
                self.showAlertFailure(message: "Place not found")
            }
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
    private func showAlertFailure(message: String) {
        let alertViewController = UIAlertController(title: "Location Error", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    @IBAction func removeSelectedLocation(_ sender: Any) {
        self.titleLabel.text = "Where are you studying?"
        self.selectedLocationButton.isHidden = true
        self.selectedLocationLabel.text = ""
        self.selectedLocationLabel.isHidden = true
        self.findOnMapButton.isHidden = false
        mapView.removeAnnotations(mapView.annotations)
        mapView.setRegion(originalMapRegion!, animated: true)
        inputTextField.text = ""
        submitButton.isEnabled = false
    }
    
    
}
