//
//  LetterTableViewController.swift
//  Oculetter
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData

// Array estático con todas las letras del abecedario
let letrasStaticArray: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

// Array estático con todos los atributos posibles
let atributosStaticArray: [String] = ["high", "onpix", "width", "x2bar", "x2ybr", "xbar", "xbox", "xege", "xegvy", "xybar", "y2bar", "ybox", "yege", "yegvx"]

class LetterTableViewController: UITableViewController {
    
    var paciente: Pacient?
    
    var prueba: NSManagedObject?
    
    var letras = [NSManagedObject]()
    
    var letrasPruebaArray = [String]()
    
    var pruebaCreada: Bool?
    
    var fecha : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: date)
        let year = components.year
        let month = components.month
        let day = components.day
        fecha =  "\(day)-"+"\(month)-"+"\(year)"
        
        while letrasPruebaArray.count < 5 {
            // Generate a random index
            let randomIndex = Int(arc4random_uniform(UInt32(letrasStaticArray.count)))
            
            // Get a random letter
            let randomLetter = letrasStaticArray[randomIndex]
            
            if(letrasPruebaArray.contains(randomLetter) == false){
                letrasPruebaArray.append(randomLetter)
            }
        }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        
        if(pruebaCreada == false){
            crearPrueba()
        }
        
        self.letras = self.prueba!.mutableSetValueForKey("tiene").allObjects as! [NSManagedObject]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Cada prueba constará de 5 letras
        return letras.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LetterCell", forIndexPath: indexPath) as! LetterCell
        
        cell.nameLabel.text = letras[indexPath.row].valueForKey("nombre") as? String
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "finalizarPrueba" {
            let destinoVC = segue.destinationViewController as! PruebaSeleccionadaViewController
            
            destinoVC.prueba = self.prueba
        }
        
        if segue.identifier == "mostrarDetalle" {
            let celdaRef = sender as! LetterCell
            let destinoVC = segue.destinationViewController as! LetterViewController
        
            let filaSeleccionada = tableView.indexPathForCell(celdaRef)
        
            destinoVC.letra = self.letras[(filaSeleccionada?.row)!]
        
            destinoVC.paciente = self.paciente
            destinoVC.letrasPruebaArray = self.letrasPruebaArray
            destinoVC.pruebaCreada = self.pruebaCreada
            destinoVC.prueba = self.prueba
            
        } else {return}
    }
    
    func crearPrueba(){
        pruebaCreada = true

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Prueba", inManagedObjectContext: managedContext)
        prueba = Prueba(entity:entity!, insertIntoManagedObjectContext: managedContext)

        prueba?.setValue(fecha, forKey: "fecha")
        
        self.paciente!.mutableSetValueForKey("hace").addObject(prueba!)
        
        do {
            try managedContext.save()
            pruebaCreada = true            
        } catch {
            print("Error al crear la prueba")
        }
        
        crearLetras()
    }
    
    func crearLetras() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        for letraName in letrasPruebaArray{
            let entity = NSEntityDescription.entityForName("Letter", inManagedObjectContext: managedContext)
            
            let letra = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            letra.setValue(letraName, forKey: "nombre")
            letra.setValue(false, forKey: "reconocida")
            
            prueba!.mutableSetValueForKey("tiene").addObject(letra)
            
            do {
                try managedContext.save()
            } catch {
                print("Error al crear las letras")
            }
        }
    }
}

class LetterCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}
