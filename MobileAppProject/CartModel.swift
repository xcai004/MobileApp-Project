
import Foundation
import CoreData
import UIKit

class CartModel {
    
    private var Cart:[CartItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let sharedInstance = CartModel()
    // create one instance of this class
    
    private init ()
    {
        fetchCart()
    }
    
    public func fetchCart(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    Cart.append(CartItem(
                        picture: (result.value(forKey: "picture") as? String)!,
                        name: (result.value(forKey: "name") as? String)!,
                        price: (result.value(forKey: "price") as? String)!,
                        size: (result.value(forKey: "size") as? String)!,
                        quantity: (result.value(forKey: "quantity") as? String)!
                    ))
                }
            }
            
        }catch {
            // process errors here
        }
        
    }
    
    public func listCount() -> Int {
        if Cart.count > 0{
            return Cart.count
        } else{
            return 0
        }
    }
    
    public func getCart() -> [CartItem] {
        
        return Cart
    }
    
    public func addToCart(price: String, name: String, size: String, picture: String, quantity: String){
    
        let newCartItem = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
        
        newCartItem.setValue(price, forKey: "price")
        newCartItem.setValue(name, forKey: "name")
        newCartItem.setValue(size, forKey: "size")
        newCartItem.setValue(picture, forKey: "picture")
        newCartItem.setValue(quantity, forKey: "quantity")

        do{
            try context.save()
        }catch {
            // error processing here
        }
        
        
    }
    
    public func updateCartItem(){
    
    }
    
    public func clearCart()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
            }
            
        }catch {
            // process errors here
        }

    }
    
}

struct CartItem { // struct for contact
    
    var picture: String
    var name: String
    var price: String
    var size: String
    var quantity: String
}
