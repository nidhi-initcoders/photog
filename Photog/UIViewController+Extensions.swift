//
//  UIViewController+Extensions.swift
//  Photog
//
//  Created by Dhiraj Laddha on 27/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import Foundation

extension UIViewController
{
    func showAlert(message: String)
    {
       self.showAlert("Uh Oh!", message: message)
    }
    
    func showAlert(title:String, message: String)
    {
        var alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertViewController.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }

}
