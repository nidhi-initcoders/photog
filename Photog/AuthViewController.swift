//
//  AuthViewController.swift
//  Photog
//
//  Created by Dhiraj Laddha on 17/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController ,UITextFieldDelegate {
    
    
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    
    enum AuthMode
    {
        case SignIn
        case SignUp
    
    }
 
    var authMode: AuthMode=AuthMode.SignUp
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.edgesForExtendedLayout=UIRectEdge.None
        var EmailImageView=UIImageView(frame: CGRectMake(0,0,50,self.emailTextField!.frame.size.height))
        EmailImageView.image=UIImage(named: "EmailIcon")
    
        EmailImageView.contentMode = .Center
        emailTextField!.leftView = EmailImageView
        emailTextField!.leftViewMode = .Always
        
        var passwordImageView = UIImageView(frame: CGRectMake(0, 0, 50, passwordTextField!.frame.size.height))
        passwordImageView.image = UIImage(named: "PasswordIcon")
        passwordImageView.contentMode = .Center
        
        passwordTextField!.leftView = passwordImageView
        passwordTextField!.leftViewMode = .Always
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.emailTextField?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField==self.emailTextField)
        {
            emailTextField?.resignFirstResponder()
            passwordTextField?.becomeFirstResponder()
        }
        else if(textField==self.passwordTextField)
        {
            passwordTextField?.resignFirstResponder()
            self.authenticate()
        }
    return true
    }
    
    func authenticate()
    {
        var email = emailTextField?.text
        var password = passwordTextField?.text
        if(email?.isEmpty == true || password?.isEmpty == true || email?.isEmailAddress() == false){
        
            println("no Good")
            return
        }
        
        if(authMode == .SignIn)
        {
            self.SignIn(email!,password :password!)
        }
        else
        {
            self.signUp(email!,password :password!)
        }
    
    }
    
 
    func signUp(email: String, password: String)
    {
        var user = PFUser()
        user.username = email
        user.email = email
        user.password = password
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
          
            
            if error == nil
            {
                
                NetworkManager.sharedInstance.follow(user, completionHandler:{ (error: NSError?) -> () in
                if(error == nil)
                {
                     var TabBar=TabBarController()
                     self.navigationController?.pushViewController(TabBar, animated: true)

                    
                    }
                    else
                    {
                     println("Unable for user to follow him/herself")
                    }
                })
                
            }
            else
            {
                println("sign up failure!) (alert the user)")
            }
            
        }
    }
    
    func SignIn(email: String, password:String)
    {
        
        
        
        
        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if(user != nil)
            {
                println("login success")
                println("In")
                var TabBar=TabBarController()
                self.navigationController?.pushViewController(TabBar, animated: true)

            }
            else
            {
                println("Failure")
              //  self.showAlert("", message:"Login In error" )
                
            }
        }

        
        
    }
    
    
    
      
   
}
