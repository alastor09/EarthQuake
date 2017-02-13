//
//  SecondViewController.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EarthQuakeModelManager.shared.delegate = self
        EarthQuakeModelManager.shared.retreiveEarthQuakeData()

        locateMe()
    }
    @IBAction func refreshData(_ sender: Any) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        EarthQuakeModelManager.shared.delegate = self
        EarthQuakeModelManager.shared.retreiveEarthQuakeData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailPopoverSegue"){
            let annotationview = sender as! MKAnnotationView
            let destinationController: EarthQuakeDetailTableViewController = segue.destination as! EarthQuakeDetailTableViewController
            destinationController.earthQuakeObject = EarthQuakeModelManager.shared.fetchEarthQuakeModelForLocation(longitude: (annotationview.annotation?.coordinate.longitude)!, latitude: (annotationview.annotation?.coordinate.latitude)!)
        }
    }
    
}

// MARK: Location Delegates
extension MapViewController: CLLocationManagerDelegate{
    func locateMe() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        currentLocation = userLocation.coordinate
        locationManager.stopUpdatingLocation()
        
        let coordinations = CLLocationCoordinate2D(latitude: currentLocation.latitude,longitude: currentLocation.longitude)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

extension MapViewController : EarthQuakeDataRetreivedDelegate{
    func successfullyfetchedObjectsFromServer(earthQuakeArray: [EarthQuakeModel]){
        
        for earthObject in earthQuakeArray{
         
            let quakeLatitude = Double(earthObject.lat!)
            let quakeLongitude = Double(earthObject.lon!)
            
            let startCoordinates = CLLocationCoordinate2DMake(quakeLatitude!, quakeLongitude!)
            
            let objectStartAnnotation = MKPointAnnotation()
            objectStartAnnotation.coordinate = startCoordinates
            objectStartAnnotation.title = earthObject.region
            self.mapView.addAnnotation(objectStartAnnotation)
            
        }
    }
    
    func errorfetchingObjectsFromServer(){

    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "infoView"
        if(annotation.coordinate.longitude == currentLocation.longitude && annotation.coordinate.latitude == currentLocation.latitude){
            return nil
        }
        let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
        annotationView.isEnabled = true
        annotationView.canShowCallout = true
        annotationView.animatesDrop = true
        
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "detailPopoverSegue", sender: view)
    }
}
