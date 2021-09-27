//
//  CorreccionViewController.swift
//  Oculetter
//
//  Created by Aula11 on 17/1/19.
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData

class CorreccionViewController: UIViewController {
    
    var letraExpuesta: String = ""
    var letraVista: String = ""
    var letrasPruebaArray = [String]()
    
    var paciente: Pacient?
    var pruebaCreada: Bool?
    var prueba: NSManagedObject?
    
    @IBOutlet weak var letraExpuestaLabel: UILabel!
    @IBOutlet weak var letraVistaLabel: UILabel!
    @IBOutlet weak var veredictoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letraExpuestaLabel.text = letraExpuesta
        letraVistaLabel.text = letraVista
        
        if(letraVista != letraExpuesta){
            veredictoLabel.text = "No reconocida"
            veredictoLabel.backgroundColor = UIColor.redColor()
        } else {
            veredictoLabel.text = "Reconocida"
            veredictoLabel.backgroundColor = UIColor.greenColor()
        }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "mostrarTablaDeNuevo" {return}
        
        let destinoVC = segue.destinationViewController as! LetterTableViewController

        destinoVC.letrasPruebaArray = self.letrasPruebaArray
        destinoVC.paciente = self.paciente
        destinoVC.pruebaCreada = self.pruebaCreada
        destinoVC.prueba = self.prueba
    }
}
