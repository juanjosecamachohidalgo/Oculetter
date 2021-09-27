//
//  ViewController.swift
//  Oculetter
//
//  Created by Aula11 on 3/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData

class VistaPacienteViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    //MARK: atributos
    
    var paciente: Pacient?
    var listaPruebasPaciente = [NSManagedObject]()
    
    @IBOutlet weak var namePaciente: UITextField!
    @IBOutlet weak var surnamePaciente: UITextField!
    @IBOutlet weak var tlfPaciente: UITextField!
    @IBOutlet weak var agePaciente: UITextField!
    @IBOutlet weak var sexPaciente: UITextField!
    @IBOutlet weak var pruebasPaciente: UITableView!
    @IBOutlet weak var observacionesPaciente: UITextView!
    
    //MARK: propiedades
    
    @IBOutlet weak var imgPaciente: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        
        // Do any additional setup after loading the view, typically from a nib.
        pruebasPaciente.delegate = self
        pruebasPaciente.dataSource = self

        cargarDatos()
    }
    
    //MARK: functions
    func crearPrueba(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity = NSEntityDescription.entityForName("Prueba", inManagedObjectContext: managedContext)
        let prueba = Prueba(entity:entity!, insertIntoManagedObjectContext: managedContext)
        prueba.fecha = ""
        
        do {
            try managedContext.save()
        } catch{
            print("Error al crear la prueba")
        }
        
    }
    
    func cargarDatos(){
        self.agePaciente.text = "\(paciente!.edad)"
        self.namePaciente.text = paciente!.nombre
        self.surnamePaciente.text = paciente!.apellidos
        self.tlfPaciente.text = paciente!.telefono
        self.sexPaciente.text = paciente!.sexo
        
        
        self.listaPruebasPaciente = self.paciente!.mutableSetValueForKey("hace").allObjects as! [NSManagedObject]
        
        /*
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequestPacientes = NSFetchRequest (entityName: "Prueba")
        
        do{
            let resultsUsuario = try managedContext.executeFetchRequest(fetchRequestPacientes)
            print(resultsUsuario)
            //resultsUsuario as! Prueba
            for usuario in resultsUsuario{
                //usuario as! Prueba!
                print(usuario.fecha)
                listaPruebasPaciente.append(usuario)
            }
            
        }
        catch{
            print("Error comprobar cuantas pruebas hay")
        }
*/
    }
    
    @IBAction func eliminarPaciente(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //managedContext.deletedObject(paciente)
        managedContext.deleteObject(paciente!)
        do{
            try managedContext.save()
        }catch{
            print("Error al eliminar")
        }
    }
    
    
    //MARK: UIImageViewControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgPaciente.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaPruebasPaciente.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PruebaDePacienteCell", forIndexPath: indexPath) as! pruebaPacienteViewCell
        
        let prueba = listaPruebasPaciente[indexPath.row]
        
        cell.pruebaLbl.text = prueba.valueForKey("fecha") as? String
        
        return cell
    }

    
    //MARK: Navegación
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mostrarDetallePrueba"{
            let destinoViewController = segue.destinationViewController as! PruebaSeleccionadaViewController
            
            let selectedCell = sender as! pruebaPacienteViewCell
            let selectedRow = self.pruebasPaciente.indexPathForCell(selectedCell)
            
            destinoViewController.prueba = self.listaPruebasPaciente[(selectedRow?.row)!]
        }
        
        else if segue.identifier == "mostrarPrueba" {
            let destinoVC = segue.destinationViewController as! LetterTableViewController
            
            destinoVC.paciente = self.paciente
            destinoVC.pruebaCreada = false
        }
        
        else {return}
    }

}
