//
//  ModelManager.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import Foundation

class EarthQuakeModelManager{
    
    var delegate: EarthQuakeDataRetreivedDelegate?
    
    static let shared = EarthQuakeModelManager()
    var arrayOfEarthQuakeModels:[EarthQuakeModel] = []

    func retreiveEarthQuakeData() {
       let fetchEarthQuakeData:GetEarthQuakesAPIClient = GetEarthQuakesAPIClient()
        fetchEarthQuakeData.delegate = self
        fetchEarthQuakeData.fetchDataFromURLRequest()
    }
    
    func fetchEarthQuakeModelForLocation(longitude: String, latitude: String) -> EarthQuakeModel {
       let arrOfModels = arrayOfEarthQuakeModels.filter { (earthQuakeModelObject) -> Bool in
            if(earthQuakeModelObject.lon == longitude && earthQuakeModelObject.lat == latitude){
                return true
            }
            else{
                return false
            }
        }
        return arrOfModels.first!
    }
}


extension EarthQuakeModelManager : EarthQuakeDataRetreivedDelegate{
    func successfullyfetchedObjectsFromServer(earthQuakeArray: [EarthQuakeModel]){
        arrayOfEarthQuakeModels = earthQuakeArray
        self.delegate?.successfullyfetchedObjectsFromServer(earthQuakeArray: self.arrayOfEarthQuakeModels)
    }
    func errorfetchingObjectsFromServer(){
        arrayOfEarthQuakeModels = []
        self.delegate?.errorfetchingObjectsFromServer()
    }
}
