//
//  LoginViewController.swift
//  RecipeApp
//
//  Created by Anuar Nordin on 01/03/2021.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInBtn.rounded(radius: 5, borderWidth: 2, borderColor: .systemBlue)
    }
    
    // MARK:- Button pressed
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        checkReq()
    }
    
    // MARK:- When pressed, follow all the requirements to pass
    func checkReq(){
        SVProgressHUD.show()
        if usernameTextField.text!.count != 0{
            if usernameTextField.text!.isValidEmail(){
                if passwordTextField.text!.count != 0{
                    if passwordTextField.text!.count >= 6{
                        if passwordTextField.text! == "123456" {
                            if usernameTextField.text! == "anuar@gmail.com" {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.nextView()
                                }
                            }else{
                                self.displayAlertMessage(messageToDisplay: "Username does not match!")
                                return
                            }
                        }else{
                            self.displayAlertMessage(messageToDisplay: "Password does not match!")
                            return
                        }
                    }else{
                        self.displayAlertMessage(messageToDisplay: "Password must 6 characters and above!")
                        return
                    }
                }else{
                    self.displayAlertMessage(messageToDisplay: "Please fill password!")
                    return
                }
            }else{
                self.displayAlertMessage(messageToDisplay: "Invalid email format!")
                return
            }
        }else{
            self.displayAlertMessage(messageToDisplay: "Please fill username/email!")
            return
        }
    }
    
    func nextView(){
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        SVProgressHUD.dismiss()
    }
    
    func displayAlertMessage(messageToDisplay: String) {
        SVProgressHUD.dismiss()
        let alertController = UIAlertController(title: "Info", message: messageToDisplay, preferredStyle: .alert)
        alertController.view.tintColor = UIColor(red: 22/255, green: 16/255, blue: 21/255, alpha: 1.0)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("Ok button tapped")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
