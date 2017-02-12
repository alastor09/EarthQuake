//
//  MapTableViewCell.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapTableViewCell: UITableViewCell, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var earthQuakeLocation = CLLocationCoordinate2D()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //MapView
        mapView!.showsPointsOfInterest = true
        if let mapView = self.mapView
        {
            mapView.delegate = self
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell() {
        locateMe()
    }
    
}

// MARK: Location Delegates
extension MapTableViewCell: CLLocationManagerDelegate{
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
        updateLocationOnView()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func updateLocationOnView() {
        let startLatitude = Double(currentLocation.latitude)
        let startLongitude = Double(currentLocation.longitude)
        
        let startCoordinates = CLLocationCoordinate2DMake(startLatitude, startLongitude)
        
        let earthQuakeLatitude = Double(earthQuakeLocation.latitude)
        let earthQuakeLongitude = Double(earthQuakeLocation.longitude)
        
        let earthQuakeCoordinates = CLLocationCoordinate2DMake(earthQuakeLatitude, earthQuakeLongitude)
        
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: startCoordinates, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let objectStartAnnotation = MKPointAnnotation()
        objectStartAnnotation.coordinate = startCoordinates
        self.mapView.addAnnotation(objectStartAnnotation)
        
        let objectEarthQuakeAnnotation = MKPointAnnotation()
        objectEarthQuakeAnnotation.coordinate = earthQuakeCoordinates
        self.mapView.addAnnotation(objectEarthQuakeAnnotation)
        
        self.zoomToFitMapAnnotations(aMapView: self.mapView)
    }
    
    func zoomToFitMapAnnotations(aMapView: MKMapView) {
        guard aMapView.annotations.count > 0 else {
            return
        }
        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        topLeftCoord.latitude = -90
        topLeftCoord.longitude = 180
        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        bottomRightCoord.latitude = 90
        bottomRightCoord.longitude = -180
        for annotation: MKAnnotation in aMapView.annotations {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }
        
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.4
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.4
        region = aMapView.regionThatFits(region)
        aMapView.setRegion(region, animated: true)
    }
    
}
