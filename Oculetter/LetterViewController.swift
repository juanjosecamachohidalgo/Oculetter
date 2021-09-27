//
//  LetterViewController.swift
//  Oculetter
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import UIKit
import CoreData

class LetterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var prueba: NSManagedObject?
    
    var paciente: Pacient?
    
    var letraName: String?
    
    var pruebaCreada: Bool?
    
    // El NSManagedObject de cada Letter se crea en la vista detalle, cuando se guardan los cambios
    var letra: NSManagedObject?
    
    var attributesValuesTemp: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var letrasPruebaArray = [String]()
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var attributesTableView: UITableView!
    @IBOutlet weak var letraVistaTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attributesTableView.delegate = self
        attributesTableView.dataSource = self
        
        letraName = letra!.valueForKey("nombre") as? String
        
        nombreLabel.text = letraName
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        attributesTableView.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributesValuesTemp.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = attributesTableView.dequeueReusableCellWithIdentifier("AttributeCell")! as! AttributesTableViewCell
        
        let atributo = atributosStaticArray[indexPath.row]
        
        cell.attributeLabel.text = atributo
        cell.backgroundColor = UIColor.clearColor()
        
        attributesValuesTemp[indexPath.row] = cell.attributeSlider.value
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = attributesTableView.cellForRowAtIndexPath(indexPath) as! AttributesTableViewCell
        
        attributesValuesTemp[indexPath.row] = cell.attributeSlider.value
    }

    @IBAction func saveResults(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        do {
            for i in 1...atributosStaticArray.count - 1{
                print(atributosStaticArray[i])
                letra!.setValue(attributesValuesTemp[i], forKey: "\(atributosStaticArray[i])")
            }
            
            if(letraName == letraVistaTF.text){
                letra!.setValue(true, forKey: "reconocida")
            }
            
            try managedContext.save()
        } catch {
            print("Error al añadir letra a su prueba correspondiente")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier != "mostrarResultados" {return}

        let destinoVC = segue.destinationViewController as! CorreccionViewController
        
        destinoVC.letraExpuesta = letraName!
        destinoVC.letraVista = self.letraVistaTF.text!
        destinoVC.letrasPruebaArray = self.letrasPruebaArray
        destinoVC.paciente = self.paciente
        destinoVC.pruebaCreada = self.pruebaCreada
        destinoVC.prueba = self.prueba
    }
}

class AttributesTableViewCell: UITableViewCell {
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attributeSlider: UISlider!
    @IBOutlet weak var attributeValueLabel: UILabel!
    
    @IBAction func sliderValueChanged(sender: UISlider){
        let currentValue = Int(sender.value)
        
        attributeValueLabel.text = "\(currentValue)"
    }
}
