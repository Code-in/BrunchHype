//
//  BrunchSpotController.swift
//  BrunchHype
//
//  Created by Pete Parks on 4/23/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class BrunchSpotController {
    // Singleton
    let shared = BrunchSpotController()
    // SoT Fetch results thing
    let fetchResultsController: NSFetchedResultsController<BrunchSpot>
    
    init() {
        let request: NSFetchRequest<BrunchSpot> = BrunchSpot.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "tier", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
        let resultController: NSFetchedResultsController<BrunchSpot> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "tier", cacheName: nil)
        fetchResultsController = resultController
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch \(error.localizedDescription)")"
        }
        
    }
    
    
    //CRUD
    
    // Create
    func create(brunchSpotWith name: String) {
        let _ = BrunchSpot(name: name)
        
        // persistance store save
        saveToPersistentStore()
    }
    
    // Update
    func update(brunchSpot: BrunchSpot, name: String, tier: String, summary: String) {
        brunchSpot.name = name
        brunchSpot.tier = tier
        brunchSpot.summary = summary
    }
    
    // Delete
    func remove(brunchSpot: BrunchSpot) {
        CoreDataStack.context.delete(brunchSpot)
    }
    
    
    // Persistance Store via CoreData and MOC
    // Save
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error - saveToPeresistence: \(error), \(error.localizedDescription)")
        }
    }
    

    
    
} // End of Class
