//
//  Letter+CoreDataProperties.swift
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

extension Letter {

    @NSManaged var high: NSNumber?
    @NSManaged var nombre: String?
    @NSManaged var onpix: NSNumber?
    @NSManaged var reconocida: NSNumber?
    @NSManaged var width: NSNumber?
    @NSManaged var x2bar: NSNumber?
    @NSManaged var x2ybr: NSNumber?
    @NSManaged var xbar: NSNumber?
    @NSManaged var xbox: NSNumber?
    @NSManaged var xege: NSNumber?
    @NSManaged var xegvy: NSNumber?
    @NSManaged var xybar: NSNumber?
    @NSManaged var y2bar: NSNumber?
    @NSManaged var ybar: NSNumber?
    @NSManaged var ybox: NSNumber?
    @NSManaged var yege: NSNumber?
    @NSManaged var yegvx: NSNumber?
    @NSManaged var prueba: NSSet?

}
