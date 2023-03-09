//
//  PlacesVC.swift
//  SimpleFoursquareClone
//
//  Created by iremt on 9.03.2023.
//

import UIKit

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
    }
    

    @objc func addButtonClicked(){
        //segue
    }
   
}
