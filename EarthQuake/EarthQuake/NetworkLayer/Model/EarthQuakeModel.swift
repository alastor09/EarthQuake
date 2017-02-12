//
//  EarthQuakeModel.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import Foundation

class EarthQuakeModel {
    public var eqid: String?
    public var src: String?
    public var lat: String?
    public var lon: String?
    public var magnitude: Double?
    public var depth: Double?
    public var region: String?
    public var timeDate: Date?
    
    init(earthQuakeMagnitudeEqid: String, source: String, lattitude: String, longitude: String, earthQuakeMagnitude: Double, earthQuakeDepth: Double, earthQuakeRegion: String, earthQuakeTimeDate: Date){
        
        self.eqid = earthQuakeMagnitudeEqid
        self.src = source
        self.lat = lattitude
        self.lon = longitude
        self.magnitude = earthQuakeMagnitude
        self.depth = earthQuakeDepth
        self.region = earthQuakeRegion
        self.timeDate = earthQuakeTimeDate
      
    }
    
}

/*
 
 {
 "count": "21740",
 "earthquakes": [
 {
 "src": "us",
 "eqid": "c000is61",
 "timedate": "2013-07-29 22:22:48",
 "lat": "7.6413",
 "lon": "93.6871",
 "magnitude": "4.6",
 "depth": "40.90",
 "region": "Nicobar Islands, India region"
 },
 {
 "src": "us",
 "eqid": "c000is4s",
 "timedate": "2013-07-29 21:52:12",
 "lat": "-57.7816",
 "lon": "-25.3260",
 "magnitude": "5.2",
 "depth": "53.50",
 "region": "South Sandwich Islands region"
 }
 ]
 }
 
 */
