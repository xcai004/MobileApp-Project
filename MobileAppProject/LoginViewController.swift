
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var GuestButton: UIButton!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        LoginButton.backgroundColor = UIColor(red:0.00, green:0.60, blue:1.00, alpha:1.0)
//        LoginButton.setTitleColor(UIColor.white, for: .normal)
//        
//        SignupButton.backgroundColor = UIColor(red:0.00, green:0.60, blue:1.00, alpha:1.0)
//        SignupButton.setTitleColor(UIColor.white, for: .normal)
//        
//        GuestButton.backgroundColor = UIColor(red:0.00, green:0.60, blue:1.00, alpha:1.0)
//        GuestButton.setTitleColor(UIColor.white, for: .normal)
//        
        
    }
    
   
    
    @IBAction func LoginPressed(_ sender: Any) {
        //
        print("Tapped")
        
    }
    @IBAction func SignupPressed(_ sender: Any) {
        //
        print("Tapped")
    }
    @IBAction func GuestPressed(_ sender: Any) {
        print("Tapped")
    }
    
    
   
    
    
}
