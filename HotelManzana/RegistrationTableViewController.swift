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
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
              let registration = addRegistrationTableViewController.registration else { return }
        
        registrations.append(registration)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let cell = tableView.indexPathForSelectedRow!
            let detailCell = registrations[cell.row]
            let addRegistrationTableViewController = segue.destination as? AddRegistrationTableViewController
            
            addRegistrationTableViewController?.checkInDatePicker.date = detailCell.checkInDate
            addRegistrationTableViewController?.checkOutDatePicker.date = detailCell.checkOutDate
            addRegistrationTableViewController?.firstNameTextField.text = detailCell.firstName
            addRegistrationTableViewController?.lastNameTextField.text = detailCell.lastName
            addRegistrationTableViewController?.emailTextField.text = detailCell.emailAddress
            addRegistrationTableViewController?.numberOfAdultsStepper.value = Double(detailCell.numbersOfAdults)
            addRegistrationTableViewController?.numberOfChildrenStepper.value = Double(detailCell.numbersOfChildren)
            addRegistrationTableViewController?.wifiSwitch.isEnabled = detailCell.wifi
            addRegistrationTableViewController?.roomType = detailCell.roomType
            addRegistrationTableViewController?.updateNumberOfGuests()
            addRegistrationTableViewController?.updateRoomType()
            addRegistrationTableViewController?.updateDateViews()
        }
    }
    
}
