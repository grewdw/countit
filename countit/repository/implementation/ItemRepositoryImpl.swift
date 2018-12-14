//
//  ItemRepository.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ItemRepositoryImpl: ItemRepository {
    
    private final let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init () {
    }
    
    func saveItem(itemDto: ItemDto) {
        let item = ItemEntity(context: context)
        if let id = itemDto.id?.get() {
            item.id = id
        }
        item.name = itemDto.name
        item.itemDescription = itemDto.description
        saveContext()
        print("success")
    }
    
    private func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
        
    }
}
