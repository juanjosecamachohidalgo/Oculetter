//
//  PruebaSeleccionadoViewController.swift
//  Oculetter
//
//  Created by Macintosh on 16/1/19.
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData

class PruebaSeleccionadaViewController: UITableViewController {

    //MARK: atributos
    
    var prueba: NSManagedObject?
    
    var letrasPruebaArray = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.letrasPruebaArray = prueba!.mutableSetValueForKey("tiene").allObjects as! [NSManagedObject]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Cada prueba constará de 5 letras
        return letrasPruebaArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PruebaCell", forIndexPath: indexPath) as! VerPruebaTableViewCell
        
        cell.letraLabel.text = letrasPruebaArray[indexPath.row].valueForKey("nombre") as? String
        let reconocida = letrasPruebaArray[indexPath.row].valueForKey("reconocida") as? Bool
        
        if(reconocida == true){
            cell.reconocidaLabel.text = "Reconocida"
            cell.reconocidaLabel.backgroundColor = UIColor.greenColor()
        } else {
            cell.reconocidaLabel.text = "No reconocida"
            cell.reconocidaLabel.backgroundColor = UIColor.redColor()
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
}

class VerPruebaTableViewCell: UITableViewCell{
    @IBOutlet weak var letraLabel: UILabel!
    @IBOutlet weak var reconocidaLabel: UILabel!
}
