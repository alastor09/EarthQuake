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
