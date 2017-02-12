//
//  EarthQuakeDetailTableViewController.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import UIKit
import CoreLocation

class EarthQuakeDetailTableViewController: UITableViewController {

    var earthQuakeObject:EarthQuakeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "mapCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapTableViewCell
        cell.earthQuakeLocation = CLLocationCoordinate2D(latitude: Double((earthQuakeObject?.lat)!)!,longitude: Double((earthQuakeObject?.lon)!)!)
        cell.configureCell()
        return cell
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 250
        }
        return 44
    }

}
