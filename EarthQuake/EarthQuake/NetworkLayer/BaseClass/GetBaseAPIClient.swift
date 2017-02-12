//
//  GetBaseAPIClient.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import Foundation

class GetBaseAPIClient {
    func fetchDataFromURLRequest() {
        let urlPath: String = self.requestUrl()
        
        let requestUrl: URL = URL(string: urlPath)!
        
        var request: URLRequest = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, serverError: Error?) in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? NSDictionary {
                    self.processResponseSuccessData(dataArray: jsonResult)
                }
            } catch let error as NSError {
                self.processResponseFailureError(error: error)
            }
        }
        
        task.resume()
    }
    
    func requestUrl() -> String {
        return "http://www.seismi.org/api/eqs/"
    }
    
    func processResponseSuccessData(dataArray : NSDictionary)  {
    }
    
    func processResponseFailureError(error : NSError)  {
    }
}
