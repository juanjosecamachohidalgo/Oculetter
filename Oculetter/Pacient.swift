//
//  Paciente.swift
//  Oculetter
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 Universidad de Almeria. All rights reserved.
//

import Foundation
import CoreData

class Pacient: NSManagedObject{
    @NSManaged var nombre: String?
    @NSManaged var apellidos: String?
    @NSManaged var sexo: String?
    @NSManaged var telefono: String?
    @NSManaged var edad: NSNumber
    @NSManaged var foto: NSString
    @NSManaged var doctor: String
    
    @NSManaged var medico: Usuario?
    
}