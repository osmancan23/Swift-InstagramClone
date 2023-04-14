//
//  SettingsVc.swift
//  InstagramClone
//
//  Created by Osmancan Akagündüz on 10.04.2023.
//

import UIKit
import Firebase
class SettingsVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func signOut(_ sender: Any) {
        do {
          try  Auth.auth().signOut()
            performSegue(withIdentifier: "toMainVc", sender: nil)
        }catch{
            print("error")
        }
        
        
    }
    

}
