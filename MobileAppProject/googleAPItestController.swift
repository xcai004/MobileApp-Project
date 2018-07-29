import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class GoogleAPIViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    //@IBOutlet var signInButton: GIDSignInButton!
    // @IBAction func signInPressed(_ sender: Any) {
    //     GIDSignIn.sharedInstance().signIn()
    // }
    // If modifying these scopes, delete your previously saved credentials by
    
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    
    private let service = GTLRSheetsService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().clientID = "195890102482-ko027i6i30cghhc0ahn1nke51vue59ps.apps.googleusercontent.com"
        //test
        //    self.service.authorizer = GIDSignIn.sharedInstance().currentUser.userID
        GIDSignIn.sharedInstance().signIn()
        
        // Add the sign-in button.
        //view.addSubview(signInButton)
        
        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output);
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            print("Sing in Success!")
            listMajors()
        }
    }
    
    
    func listMajors() {
        output.text = "Getting sheet data..."
        let spreadsheetId = "1jaq8lbnpRzXpoHbpunj3YTwv-qxqBvvLKAVzvob8YZo"
        let range = "A2:E6"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range)
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
        
    }
    
    // Process the response and display output
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
            output.text = "No data found."
            return
        }
        
        let MyModel = ShirtsModel.sharedInstance
        
        for row in rows {
            let name = row[0]
            
            let name = row[0] as! String
            let id = row[1] as! String
            let price = row[2] as! String
            let desc = row[3] as! String
            let picture = row[4] as! String
            
            MyModel.addShirt(price: price, name: name, id: id, picture: picture, desc: desc)
            

        }
        
       output.text = "Done...."
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
