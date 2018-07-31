
import Foundation
import CoreData
import UIKit

class CartModel {
    //Holds all items in order
    private var Cart:[CartItem] = []
    //Create Context object to access/save Order info
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static let sharedInstance = CartModel()
    // create one instance of this class
    
    private init ()
    {
    
    }
    
    //Get Order infor from CoreData
    public func fetchCart(){
        
        Cart.removeAll() //Ensure cart is empty Before adding from CoreData
        
        //Create request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(request) //Execute request
            
            //Turn results into CartItems
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    Cart.append(CartItem(
                        picture: (result.value(forKey: "picture") as? String)!,
                        name: (result.value(forKey: "name") as? String)!,
                        price: (result.value(forKey: "price") as? String)!,
                        size: (result.value(forKey: "size") as? String)!,
                        quantity: (result.value(forKey: "quantity") as? String)!,
                        id: (result.value(forKey: "id") as? String)!
                    ))
                }
            }
            
        }catch {
            // process errors here
        }
        
    }
    
    //Getter for count of items in cart
    public func listCount() -> Int {
        if Cart.count > 0{
            return Cart.count
        } else{
            return 0
        }
    }
    
    //Getter for array of items in cart
    public func getCart() -> [CartItem] {
        
        return Cart
    }
    
    //Setter for adding items to cart
    public func addToCart(price: String, name: String, size: String, picture: String, quantity: String, id: String){
    
        let newCartItem = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
        
        newCartItem.setValue(price, forKey: "price")
        newCartItem.setValue(name, forKey: "name")
        newCartItem.setValue(size, forKey: "size")
        newCartItem.setValue(picture, forKey: "picture")
        newCartItem.setValue(quantity, forKey: "quantity")
        newCartItem.setValue(id, forKey: "id")

        do{
            try context.save()
        }catch {
            // error processing here
        }
        
        
    }
    
    
    //FUTURE-Edite cart items
    public func updateCartItem(){
    
    }

    //Clear cart from CoreData if cancel/order submission
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
    var id: String
}
