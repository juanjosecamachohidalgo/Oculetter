//
//  AttributesTableViewController.swift
//  Oculetter
//
//  Created by Francis Gálvez on 9/1/19.
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//

import UIKit

class AttributesTableViewController: UITableViewController {
    
    var atributos = [Letter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atributos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LetterTableViewCell", forIndexPath: indexPath) as! LetterTableViewCell
        
        //cell.nombreLabel.text = letras[indexPath.row].nombre
        
        return cell
    }
}

