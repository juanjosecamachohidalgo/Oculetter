//
//  ViewController.swift
//  ProyectoLPS
//
//  Created by Razvan andrei lismanu on 1/12/19.
//  Copyright © 2019 Razvan andrei lismanu. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usuario: UITextField!
    
    @IBOutlet weak var contrasenia: UITextField!
    
    
    
    @IBAction func iniciarSesion(sender: UIButton) {
        if(usuario.text == "" || contrasenia.text == ""){
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Usuario o contraseña vacios", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestAlumno = NSFetchRequest(entityName: "Usuario")
        do{
            let resultsAlumno = try managedContext.executeFetchRequest(fetchRequestAlumno)
            for alumno in resultsAlumno as! [Usuario]{
                print(alumno.nombre)
                if(usuario.text == alumno.nombre ){
                    if(contrasenia.text == alumno.contrasenia){
                        NSUserDefaults.standardUserDefaults().setObject(usuario.text, forKey: "nombre")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        performSegueWithIdentifier("idPerfil", sender: self)
                        
                    }else{
                        let alertController = UIAlertController(title: "¡Cuidado!", message: "Contraseña no coincide", preferredStyle: .Alert)
                        let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                    }
                }else{
                    continue
                    
                }

                
                
            }
            
        }
        catch{
            print("error")
        }
        let alertController = UIAlertController(title: "¡Cuidado!", message: "Usuario no existe", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "idPerfil" {return}
        let n = segue.destinationViewController as! ViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

