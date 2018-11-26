//
//  Products+CoreDataProperties.swift
//  Comparer
//
//  Created by Karol Cápay on 21/11/2018.
//  Copyright © 2018 Karol Cápay. All rights reserved.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var consumption: Float
    @NSManaged public var descript: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Float

}
