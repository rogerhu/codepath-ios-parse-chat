//
//  ViewController.swift
//  ParseLab
//
//  Created by Roger Hu on 9/25/17.
//  Copyright © 2017 Roger Hu. All rights reserved.
//
import Parse
import ParseLiveQuery
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(_ sender: Any) {
        login()
    }

    @IBAction func onSignup(_ sender: Any) {
        signup()
    }

    func getPFUser() -> PFUser {
        let user = PFUser()
        user.username = emailText.text
        user.password = passwordText.text
        user.email = emailText.text
        return user
    }

    func login() {
        let user = getPFUser()
        PFUser.logInWithUsername(inBackground: user.username!, password: user.password!) { (user: PFUser?, error: Error?) in
            if (error != nil) {
                self.showError(message: "Error logging in")
            } else {
                print("User \(user!)")
                user?.saveEventually()
                self.performSegue(withIdentifier: "firstSegue", sender: nil)
            }
        }
    }

    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)                // Hooray! Let them use the app now.

        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    func signup() {
        let user = getPFUser()

        user.signUpInBackground(block: { (succeeded, error) in
            if (error != nil) {
                self.showError(message: "Error signing up")
            } else {
                print("Succeeded: \(succeeded)")
                user.saveEventually()
                self.performSegue(withIdentifier: "firstSegue", sender: nil)
            }
        })
    }
}

