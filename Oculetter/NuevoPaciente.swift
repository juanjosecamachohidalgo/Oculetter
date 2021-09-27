//
//  NuevoPaciente.swift
//  Oculetter
//
//  Created by Aula11 on 17/1/19.
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData

class NuevoPacienteViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    var listaPacientes = [Pacient]()
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var sexo: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var imagen: UIImageView!

    @IBOutlet weak var observaciones: UITextField!
    
    
    @IBAction func aniadirPaciente(sender: UIButton) {
        let userid = NSUserDefaults.standardUserDefaults().objectForKey("nombre") as! String
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity = NSEntityDescription.entityForName("Pacient", inManagedObjectContext: managedContext)
        let paciente = Pacient(entity:entity!, insertIntoManagedObjectContext: managedContext)
        paciente.nombre = nombre.text
        paciente.apellidos = apellidos.text
        let x = edad.text
        let myX = Int(x!)
        paciente.edad = myX!
        paciente.sexo = sexo.text
        paciente.telefono = telefono.text
        paciente.doctor = userid
        
        do{
            try managedContext.save()
            print ("CREADO: ", paciente)
            
        }catch{
            
        }
        let fetchRequestUsuario = NSFetchRequest(entityName: "Usuario")
        let fetchRequestPacientes = NSFetchRequest (entityName: "Pacient")
        
        do{
            let resultsUsuario = try managedContext.executeFetchRequest(fetchRequestPacientes)
            for usuario in resultsUsuario as! [Pacient]{
               print(usuario.nombre)
            }
            
        }
        catch{
            print("error")
        }

        
        
        do{
            let resultsUsuario = try managedContext.executeFetchRequest(fetchRequestUsuario)
            for usuario in resultsUsuario as! [Usuario]{
                if(usuario.nombre == userid){
                    paciente.medico = usuario
                    listaPacientes.append(paciente)
                    
                }
                
                print(paciente.medico?.nombre)
                print(listaPacientes)
                
            }
            
        }
        catch{
            print("error")
        }
        
        //print("Pacientes: ", )
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}

