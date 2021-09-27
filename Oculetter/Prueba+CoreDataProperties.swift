//
//  Prueba+CoreDataProperties.swift
//  Oculetter
//
//  Created by Inmaculada Mª Martínez Muñoz on 18/1/19.
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Prueba {

    @NSManaged var fecha: String?
    @NSManaged var resultados: NSObject?
    @NSManaged var pertenece_a: Pacient?
    @NSManaged var tiene: NSSet?

}
