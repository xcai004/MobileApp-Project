import GoogleAPIClientForREST
import GoogleSignIn
import GTMOAuth2
import UIKit

class GoogleAPIViewController: UIViewController{
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    
    //Scope is how to access the Sheet, read only, write
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    
    //Service is which google service to access.
    private let service = GTLRSheetsService()
    
    //Outlet Display progress of retriving new inventory.
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.startAnimating() //Start progress Activity
        getSheetData()            //Retrieve items from GSheets
    
        
    }
    //
    func getSheetData() {
        //API Key neeeded by request to access GSheets without user login. Sheet must be shared via link
        self.service.apiKey = "AIzaSyBhuRrWGpxGUy-2Clkqqz0yA9wgz5jXw3Y"
        
        //ID can be retrived from the URL of the GSheet
        let spreadsheetId = "1jaq8lbnpRzXpoHbpunj3YTwv-qxqBvvLKAVzvob8YZo"
        
        //Cells to retrive. Set to a large enough scope to accomodate future additions
        let range = "A2:E11"
        
        //Build the Query
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range)
        
        //Execute the query
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
        
    }
    
    // Process the response From Query and add items
    func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject result : GTLRSheets_ValueRange,
                                 error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        //var majorsString = ""
        let rows = result.values!
        
        if rows.isEmpty {
            return
        }
        // REFRESH DATA FROM SHEETS ; clear current data and add all the data from the sheets
        let MyModel = ShirtsModel.sharedInstance
        MyModel.clearData()
        let MyCartModel = CartModel.sharedInstance
        MyCartModel.clearCart()
        
        for row in rows {
            let name = row[0] as! String
            let id = row[1] as! String
            let price = row[2] as! String
            let desc = row[3] as! String
            let picture = row[4] as! String
            
            MyModel.addShirt(price: price, name: name, id: id, picture: picture, desc: desc)
            
            
        }
        
        self.performSegue(withIdentifier: "shirtsSegue", sender: self)
    }
    
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
