//
//  Usuario+CoreDataProperties.swift
//  Oculetter
//
//  Created by Aula11 on 14/1/19.
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Usuario {

    @NSManaged var nombre: String?
    @NSManaged var contrasenia: String?
    @NSManaged var tiene: NSSet?

}
