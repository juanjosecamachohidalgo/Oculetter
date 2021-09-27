//
//  ViewController.swift
//  Oculetter
//
//  Created by Aula11 on 3/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nombreUsuario: UILabel!
    let userid = NSUserDefaults.standardUserDefaults().objectForKey("nombre") as! String
    var  nombreUsuarioFinal = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if(nombreUsuario != nil){
            nombreUsuario.text = "Hola, doctor " + userid
        }
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

