//
//  Delegates.swift
//  ShiftTracker
//
//  Created by SOAN on 5/02/2017.
//  Copyright © 2017 SOAN. All rights reserved.
//

import Foundation

protocol EarthQuakeDataRetreivedDelegate {
    func successfullyfetchedObjectsFromServer(earthQuakeArray: [EarthQuakeModel])
    func errorfetchingObjectsFromServer()
}
