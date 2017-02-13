//
//  EarthQuakeDetailTableViewController.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import UIKit
import CoreLocation

enum TableSections: Int {
    case MapData = 0, EarthQuakeData
}

enum TableRows: Int {
    case region = 0, timeDate, depth, magnitude, longitude, latitude, distanceFromYou ,source
}

class EarthQuakeDetailTableViewController: UITableViewController, EarthQuakeDistanceDelegate {

    var earthQuakeObject:EarthQuakeModel?
    var earthQuakeDistance:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case TableSections.MapData.rawValue:
            return 1
        case TableSections.EarthQuakeData.rawValue:
            return TableRows.source.rawValue + 1
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        switch indexPath.section {
        case TableSections.MapData.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapTableViewCell
            cell.earthQuakeLocation = CLLocationCoordinate2D(latitude: Double((earthQuakeObject?.lat)!)!,longitude: Double((earthQuakeObject?.lon)!)!)
            cell.delegate = self
            cell.configureCell()
            return cell
        case TableSections.EarthQuakeData.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
            switch indexPath.row {
            case TableRows.region.rawValue:
                cell.textLabel?.text = earthQuakeObject?.region
                cell.detailTextLabel?.text = "Region"
                break
            case TableRows.timeDate.rawValue:
                cell.textLabel?.text = earthQuakeObject?.timeDate?.earthQuakeDateString
                cell.detailTextLabel?.text = "Time"
                break
            case TableRows.depth.rawValue:
                if let depth = earthQuakeObject?.depth{
                    cell.textLabel?.text = String(format: "\(depth)")
                }
                else {
                    cell.textLabel?.text = "Unknown"
                }
                cell.detailTextLabel?.text = "Depth"
                break
            case TableRows.magnitude.rawValue:
                if let magnitude = earthQuakeObject?.magnitude{
                    cell.textLabel?.text = String(format: "\(magnitude)")
                }
                else {
                    cell.textLabel?.text = "Unknown"
                }
                
                cell.detailTextLabel?.text = "Magnitude"
                break
            case TableRows.longitude.rawValue:
                cell.textLabel?.text = earthQuakeObject?.lon
                cell.detailTextLabel?.text = "Longitude"
                break
            case TableRows.latitude.rawValue:
                cell.textLabel?.text = earthQuakeObject?.lat
                cell.detailTextLabel?.text = "Latitude"
                break
            case TableRows.distanceFromYou.rawValue:
                if let distance = earthQuakeDistance{
                    cell.textLabel?.text = String(format: "%.2f Kms",distance)
                }
                else {
                    cell.textLabel?.text = "Distance Not Available"
                }
                cell.detailTextLabel?.text = "Distance From Current Location"
                break
            case TableRows.source.rawValue:
                cell.textLabel?.text = earthQuakeObject?.src
                cell.detailTextLabel?.text = "Source"
                break
            default:
                cell.detailTextLabel?.text = ""
                cell.textLabel?.text = "Unknown"
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
            return cell
            
        }
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case TableSections.MapData.rawValue:
            return 300
        case TableSections.EarthQuakeData.rawValue:
            return 44
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case TableSections.MapData.rawValue:
            return "Map"
        case TableSections.EarthQuakeData.rawValue:
            return "Details"
        default:
            return "Unknown"
        }
    }
    
    func earthQuakeDistanceRetreived(earthQuakeDist: Double){
        earthQuakeDistance = earthQuakeDist
        self.tableView.reloadRows(at: [IndexPath(item: TableRows.distanceFromYou.rawValue, section: TableSections.EarthQuakeData.rawValue)], with:UITableViewRowAnimation.right)
    }
    
}
