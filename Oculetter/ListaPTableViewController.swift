//
//  ListaPController.swift
//  Oculetter
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class listaPTableViewController: UITableViewController {
    
    //MARK: propiedades
    let userid = NSUserDefaults.standardUserDefaults().objectForKey("nombre") as! String
    
    
    var listaPacientes = [Pacient]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.sendSubviewToBack(UIImageView (image: UIImage(named: "fondo")))
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        // Do any additional setup after loading the view, typically from a nib.
        cargarDatos()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: funciones
    
   
    func cargarDatos(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetch = NSFetchRequest(entityName: "Pacient")
        let sort = NSSortDescriptor(key: "nombre", ascending: true)
        fetch.sortDescriptors = [sort]
        fetch.sortDescriptors?.append(sort)
        //print("Soy el userid hijoputa",userid,"habrá espacios?")
        fetch.predicate = NSPredicate(format: "doctor == %@", userid)
        print("Este es el userid ", userid)
        //print(paciente.medico.nombre)
        
        //fetch.predicate = predicate
        
        do{
           
            let resultsPaciente = try managedContext.executeFetchRequest(fetch)
            listaPacientes = resultsPaciente as! [Pacient]
            
            
            
            
        } catch{
            print("error")
        }
        
    }
    
    func cargarDatosEjemplo(){

        
    }
    
    func guardarDatos(){
        
    }
    


    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaPacientes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PacienteCell") as! PacienteViewCell
        let paciente = listaPacientes[indexPath.row]
        
        cell.nombre.text = paciente.nombre
        let edadx = paciente.edad
        let myEdad = String(edadx)
        cell.edad.text = myEdad
    
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath
        indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /*override func tableView(tableView: UITableView, commitEditingStyle
        editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle != .Delete {return}
        listaPacientes.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }*/
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "mostrarPaciente" {return}
        
        //print("Mostrando detalle")
        let celdaRef = sender as! PacienteViewCell
        let destinoVC = segue.destinationViewController as! VistaPacienteViewController
        
        let filaSeleccionada = tableView.indexPathForCell(celdaRef)
        destinoVC.paciente = listaPacientes[(filaSeleccionada?.row)!]
    }
    
   
    
    
    
    
}