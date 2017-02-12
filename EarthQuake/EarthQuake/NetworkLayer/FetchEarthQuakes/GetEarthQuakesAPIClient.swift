//
//  GetEarthQuakesAPIClient.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import UIKit

class GetEarthQuakesAPIClient: GetBaseAPIClient {

    var delegate: EarthQuakeDataRetreivedDelegate?
    
    
    override func requestUrl() -> String {
        return "http://www.seismi.org/api/eqs/"
    }
    
    override func processResponseSuccessData(dataArray : NSDictionary)  {
        let arrayOfEarthQuakes = arrayOfEarthQuakeData(jsonData: dataArray)
        delegate?.successfullyfetchedObjectsFromServer(earthQuakeArray: arrayOfEarthQuakes)
    }
    
    override func processResponseFailureError(error : NSError)  {
        delegate?.errorfetchingObjectsFromServer()
    }
    
    func retreiveEarthQuakeModel(dictObject: Dictionary<String, String>) -> EarthQuakeModel {
        let earthQuakeModelObject = EarthQuakeModel(earthQuakeMagnitudeEqid: dictObject["eqid"]!, source: dictObject["src"]!, lattitude: dictObject["lat"]!, longitude: dictObject["lon"]!, earthQuakeMagnitude: Double(dictObject["magnitude"]!)!, earthQuakeDepth: Double(dictObject["depth"]!)!, earthQuakeRegion: dictObject["region"]!, earthQuakeTimeDate: dictObject["timedate"]!.dateFromServerString!)
        return earthQuakeModelObject
    }
    
    func arrayOfEarthQuakeData(jsonData: NSDictionary) -> [EarthQuakeModel] {
        let arrofData = jsonData["earthquakes"]
        var arrayOfEarthQuakeModels:[EarthQuakeModel] = []
        
        for dict in arrofData as! [NSDictionary]{
            arrayOfEarthQuakeModels.append(retreiveEarthQuakeModel(dictObject: dict as! Dictionary<String, String>))
        }
        
        return arrayOfEarthQuakeModels
    }
}


/*
 
 
 var iso8601: String { return Formatter.earthQuakeServerDateFormatter.string(from: self) }

 
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
