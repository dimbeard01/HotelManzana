//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Dima Surkov on 12.10.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var registrations: [Registration] = []
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("Саня Здрова)")
        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let register = registrations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.textLabel?.text = "\(register.firstName) \(register.lastName)"
        cell.detailTextLabel?.text =  dateFormatter.string(from: register.checkInDate) + " - " + dateFormatter.string(from: register.checkOutDate) + " : " + register.roomType.name
        return cell
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController else {
            fatalError("cant cast AddRegistrationTableViewController")
        }
              /*let registration = addRegistrationTableViewController.registration */
        guard let registration = addRegistrationTableViewController.getRegistration() else {
            guard let rega = addRegistrationTableViewController.registration else { return }
            
            guard registrations[selectedIndexPath.row] != nil else {
                fatalError("no item found")
            }
            
            registrations[selectedIndexPath.row] = rega
            tableView.reloadData()
            return
        }
        
        registrations.append(registration)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let cell = tableView.indexPathForSelectedRow!
            let registration = registrations[cell.row]
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("UINavigationController not found")
            }
            guard let addRegistrationTableViewController = navigationController.viewControllers.first as? AddRegistrationTableViewController else {
                fatalError("Can't cast to AddRegistrationTableViewController")
            }
            
            addRegistrationTableViewController.registration = registration
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
}
