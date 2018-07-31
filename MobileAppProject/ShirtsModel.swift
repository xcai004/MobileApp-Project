
import Foundation
import CoreData
import UIKit

class ShirtsModel {
    
    private var Shirts:[ShirtItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let sharedInstance = ShirtsModel()
    // create one instance of this class
    
    private init ()
    {
       
    }
    
    public func fetchShirts(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Shirts")
        request.returnsObjectsAsFaults = false;
        Shirts.removeAll()
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    Shirts.append(ShirtItem(
                        picture: (result.value(forKey: "picture") as? String)!,
                        name: (result.value(forKey: "name") as? String)!,
                        price: (result.value(forKey: "price") as? String)!,
                        id: (result.value(forKey: "id") as? String)!,
                        desc: (result.value(forKey: "desc") as? String)!
                    ))
                }
            }
            
        }catch {
            // process errors here
        }
        
    }
    
    public func listCount() -> Int {
        if Shirts.count > 0{
            return Shirts.count
        } else{
            return 0
        }
    }
    
    public func getShirts() -> [ShirtItem] {
        
        return Shirts
    }
    
    public func addShirt(price: String, name: String, id: String, picture: String, desc: String){
        
        // first check if shirt already exists
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Shirts")
        request.returnsObjectsAsFaults = false;
        let predicate = NSPredicate(format: "#id == " + id)
        request.predicate = predicate
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                // shirt already exists dont add
                print("shirt exists, not adding")
                return
            }else{
                // shirt does not exist
                print("shirt does not exist, adding")
                let newShirtItem = NSEntityDescription.insertNewObject(forEntityName: "Shirts", into: context)
                
                newShirtItem.setValue(price, forKey: "price")
                newShirtItem.setValue(name, forKey: "name")
                newShirtItem.setValue(id, forKey: "id")
                newShirtItem.setValue(picture, forKey: "picture")
                newShirtItem.setValue(desc, forKey: "desc")
                
                do{
                    try context.save()
                }catch {
                    // error processing here
                }

            }
            
        }catch {
            // process errors here
        }
        
    }
    
    public func getShirtById(id: String) -> ShirtItem {
        
        return Shirts.first(where: { $0.id == id })!
        
    }
    
    public func clearData(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Shirts")
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                  context.delete(result)                }
            }
            
        }catch {
            // process errors here
        }
    }
}


struct ShirtItem { // struct for contact
    
    var picture: String
    var name: String
    var price: String
    var id: String
    var desc: String
}
