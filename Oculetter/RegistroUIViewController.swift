//
//  RegistroUIViewController.swift
//  ProyectoLPS
//
//  Created by Razvan andrei lismanu on 1/12/19.
//  Copyright © 2019 Razvan andrei lismanu. All rights reserved.
//

import UIKit
import CoreData

class RegistroUIViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var usuario: UITextField!
    
    @IBOutlet weak var contrasenia: UITextField!
    @IBOutlet weak var repetirContrasenia: UITextField!
    
   
    
    @IBAction func registro(sender: UIButton) {
        if(usuario.text == "" || contrasenia.text == "" || repetirContrasenia == ""){
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Usuario o contraseña vacios", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestUsuario = NSFetchRequest(entityName: "Usuario")
        do{
            let resultsUsuario = try managedContext.executeFetchRequest(fetchRequestUsuario)
            for alumno in resultsUsuario as! [Usuario]{
               
                if(usuario.text == alumno.nombre){               
                    
                    let alertController = UIAlertController(title: "¡Cuidado!", message: "El usuario ya existe", preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return
                }
            }
            
        }
        catch{
            print("error")
        }
        let entity = NSEntityDescription.entityForName("Usuario", inManagedObjectContext: managedContext)
        
        let user = Usuario(entity:entity!, insertIntoManagedObjectContext: managedContext)
        user.nombre = usuario.text!
        user.contrasenia = contrasenia.text!
        do{
            try managedContext.save()
            performSegueWithIdentifier("idRegistro", sender: self)
            
        }
        catch{
            
            print("error")
        }
        
        print("Añadido alumno: Nombre = ",user.nombre, " ; pass = ",user.contrasenia)


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "idRegistro" {return}
        var destino = segue.destinationViewController as! LoginViewController
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
