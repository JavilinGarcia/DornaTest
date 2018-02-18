//
//  DataManager
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

protocol GrandPrixesDelegate {
    func didGetAllGrandPrixes(prixes: [GrandPrix])
    func didGetGrandPrixDetail(gpSessions: [GPSession])
}

class DataManager: NSObject {
        
    static let sharedInstance = DataManager()
    var delegate: GrandPrixesDelegate?
    var currentGpId: String?
    
    //MARK: - Public Methods
    
    func getAllGrandPrixes(delegate: GrandPrixesDelegate) {
        self.delegate = delegate
        getFromLocal { (results) in
            if results.count == 0 {
                CommunicatorManager.sharedInstance.getAllGrandPrixes(delegate: self)
            } else {
                delegate.didGetAllGrandPrixes(prixes: results)
            }
        }
    }
    
    func getGrandPrixDetail(gpID: String, delegate: GrandPrixesDelegate) {
        self.delegate = delegate
        currentGpId = gpID
        
        // Intento recuperar de CoreData, si no hay elementos llamo al servicio
        
        getDetailFromLocal(id: gpID) { (results) in
            if results.count == 0 {
                CommunicatorManager.sharedInstance.getGrandPrixDetail(id: gpID, delegate: self)
            } else {
                delegate.didGetGrandPrixDetail(gpSessions: results)
            }
        }
    }
    
    func reloadData(delegate: GrandPrixesDelegate) {
        self.delegate = delegate
        deleteAllEntities { (success) in
            CommunicatorManager.sharedInstance.getAllGrandPrixes(delegate: self)
        }
    }
    
    // MARK: - Get from local
    
    func getFromLocal(completion: (_ results: [GrandPrix]) -> Void) {
        print("Fech GPs from local")
        var gps:[GrandPrix] = [GrandPrix]()
        
        let managedContext = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GrandPrixEntity")

        // Sort by date begin
        let sortDescriptor = NSSortDescriptor(key: "date_begin", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count > 0 {
                
                var gp: GrandPrix
                
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? String,
                        let name = result.value(forKey: "name") as? String,
                        let date_begin = result.value(forKey: "date_begin") as? String,
                        let date_finish = result.value(forKey: "date_finish") as? String,
                        let top_mobile_image_data = result.value(forKey: "top_mobile_image_data") as? Data,
                        let circuit_flag_data = result.value(forKey: "circuit_flag_data") as? Data {
                        
                        gp = GrandPrix.init(withImageData: id, name: name, date_begin: date_begin, date_finish: date_finish, top_mobile_image_data: top_mobile_image_data, circuit_flag_data: circuit_flag_data)
                        gps.append(gp)
                    }
                }
                completion(gps)
            }
            else {
                completion([GrandPrix]())
            }
        } catch {
            completion([GrandPrix]())
        }
    }
    
    func getDetailFromLocal(id: String, completion: (_ results: [GPSession]) -> Void) {
        print("Fech sessions from local")
        let managedContext = self.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GPSessionEntity")
        
        let predicate = NSPredicate(format:"gpID == '\(id)'")
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count > 0 {
                
                var sessions: [GPSession] = [GPSession]()
                
                for result in results  {
                    if let id = result.value(forKey: "sessionID") as? String,
                        let gpID = result.value(forKey: "gpID") as? String,
                        let name = result.value(forKey: "name") as? String,
                        let start_time = result.value(forKey: "start_time") as? String,
                        let end_time = result.value(forKey: "end_time") as? String,
                        let champ_name = result.value(forKey: "champ_name") as? String {
                        
                        let session = GPSession.init(gpID: gpID, sessionID: id, start_time: start_time, end_time: end_time, champ_name: champ_name, name: name)
                        
                        sessions.append(session)
                    }
                }
                completion(sessions)
            }
            else {
                completion([GPSession]())
            }
        } catch {
            completion([GPSession]())
        }
    }
    
    // MARK: - Save to local

    func saveGrandPrixesIntoCoreData(prixes: [GrandPrix], completion: (_ result: Bool) -> Void)  {
        print("Save GPs")
        let managedContext = self.persistentContainer.viewContext
        
        for aGP:GrandPrix in prixes {
            let entity = NSEntityDescription.entity(forEntityName: "GrandPrixEntity", in: managedContext)!
            let gp = NSManagedObject(entity: entity, insertInto: managedContext)
            
            gp.setValue(aGP.id, forKey: "id")
            gp.setValue(aGP.name, forKey: "name")
            gp.setValue(aGP.date_begin, forKey: "date_begin")
            gp.setValue(aGP.date_finish, forKey: "date_finish")
            gp.setValue(aGP.circuit_flag_data, forKey: "circuit_flag_data")
            gp.setValue(aGP.top_mobile_image_data, forKey: "top_mobile_image_data")
        }
        do {
            try managedContext.save()
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func saveGPDetailIntoCoreData(sessions: [GPSession], completion: (_ result: Bool) -> Void)  {
        print("Save sessions")
        let managedContext = self.persistentContainer.viewContext
        
        for session: GPSession in sessions {
            let entity = NSEntityDescription.entity(forEntityName: "GPSessionEntity", in: managedContext)!
            let aSession = NSManagedObject(entity: entity, insertInto: managedContext)
            
            aSession.setValue(session.sessionID, forKey: "sessionID")
            aSession.setValue(session.gpID, forKey: "gpID")
            aSession.setValue(session.name, forKey: "name")
            aSession.setValue(session.start_time, forKey: "start_time")
            aSession.setValue(session.end_time, forKey: "end_time")
            aSession.setValue(session.champ_name, forKey: "champ_name")
        }
        do {
            try managedContext.save()
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    // MARK: - Delete From Local
    
    func deleteAllEntities(completion: (_ result: Bool) -> Void)  {
        let managedContext = self.persistentContainer.viewContext
        
        let deleteGPFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "GrandPrixEntity")
        let deleteGPRequest = NSBatchDeleteRequest(fetchRequest: deleteGPFetch)
        let deleteSessionFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "GPSessionEntity")
        let deleteSessionRequest = NSBatchDeleteRequest(fetchRequest: deleteSessionFetch)
        
        do {
            try managedContext.execute(deleteGPRequest)
            try managedContext.execute(deleteSessionRequest)

            try managedContext.save()
            completion(true)
            
        } catch {
            completion(false)
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DornaTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Extensions

extension DataManager: GrandPrixesRequestDelegate {
    
    func didGetAllGrandPrixesResponse(prixes: [GrandPrix]) {
        deleteAllEntities { (success) in // 1 - Delete from Core Data
            saveGrandPrixesIntoCoreData(prixes: prixes, completion: { (result) in // 2 - Save again
                getFromLocal(completion: { (results) in // 3 - Fecht from Core Data
                    delegate?.didGetAllGrandPrixes(prixes: results)
                })
            })
        }
    }
    
    func didGetGrandPrixDetailResponse(gpSessions: [GPSession]) {
        saveGPDetailIntoCoreData(sessions: gpSessions, completion: { (result) in // 1 - Save in Core Data
            getDetailFromLocal(id: currentGpId!, completion: { (results) in // 2 - Fetch from Core Data
                delegate?.didGetGrandPrixDetail(gpSessions: results)
            })
        })
    }
}

