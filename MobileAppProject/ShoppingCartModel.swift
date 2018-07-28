
import Foundation
import CoreData
import UIKit

class ContactsModel {
    
    private var Cart:[CartItem] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?
    static let sharedInstance = ContactsModel()
    // create one instance of this class
    
    private init ()
    {
        fetchCart()
    }
    
    public func fetchCart(){
        
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context?.fetch(request)
            
            if (results?.count)! > 0 {
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
            
        }
        
    }
    
    public func listCount() -> Int {
        return Cart.count
    }
    
    public func addToCart(price: String, name: String, size: String, picture: String, quantity: String){
    
        let newCartItem = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context!)
        
        newCartItem.setValue(price, forKey: "price")
        newCartItem.setValue(name, forKey: "name")
        newCartItem.setValue(size, forKey: "size")
        newCartItem.setValue(picture, forKey: "picture")
        newCartItem.setValue(quantity, forKey: "quantity")

        do{
            try context?.save()
        }catch {
            // error processing here
        }
        
        
    }
    
    
    public func getCart() -> [CartItem] {

        return Cart
    }
    
//    public func removeContact(at: Int){
//        contactsList.remove(at: at)
//    }
//    
//    public func addContact(fName: String, lName: String, emailAddr: String, phoneNumber: String, adrs: String, DOB: String, contactImage: String){
//        
//        let contact = Contact(firstName: fName, lastName: lName, address: adrs, email: emailAddr, phone: phoneNumber, dateOfBirth: DOB, userImage: contactImage)
//        contactsList.append(contact)
//        
//    }
//    
//    public func updateContact(Contact: Contact,fName: String, lName: String, emailAddr: String, phoneNumber: String, adrs: String, DOB: String, contactImage: String){
//        
//        print("UpdateContact")
//        
//        let contactIndex = contactsList.index(where: { $0.lastName == Contact.lastName && $0.email == Contact.email })
//        //let index = contactsList.index(where: (Contact) throws -> Bool)
//        contactsList[contactIndex!].firstName = fName
//        contactsList[contactIndex!].lastName = lName
//        contactsList[contactIndex!].email = emailAddr
//        contactsList[contactIndex!].phone = phoneNumber
//        contactsList[contactIndex!].address = adrs
//        contactsList[contactIndex!].dateOfBirth = DOB
//        contactsList[contactIndex!].userImage = contactImage
//        
//        print(contactsList[contactIndex!])
//        
//        
//    }
    
}

struct CartItem { // struct for contact
    
    var picture: String
    var name: String
    var price: String
    var size: String
    var quantity: String
}
