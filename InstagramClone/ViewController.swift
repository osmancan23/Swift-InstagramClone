//
//  ViewController.swift
//  InstagramClone
//
//  Created by Osmancan Akagündüz on 9.04.2023.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if error != nil {
                    self.createAlert(title: "Failed", message: error?.localizedDescription)
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }
        else{
          
            createAlert(title: "Failed", message: "You must enter email and password")
            
        }
        
    }
    
    fileprivate func createAlert(title:String? , message: String?) {
        var alert =  UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var alertAction =   UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if error != nil {
                    self.createAlert(title: "Failed", message: error?.localizedDescription)
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }else{
          
            createAlert(title: "Failed", message: "You must enter email and password")
            
        }
        
        
    }
}

