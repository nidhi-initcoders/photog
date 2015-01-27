//
//  TabBarController.swift
//  Photog
//
//  Created by Dhiraj Laddha on 19/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController , UITabBarControllerDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        var feedViewController = FeedViewController(nibName:"FeedViewController" ,bundle:nil)
            
        var profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        profileViewController.user = PFUser.currentUser()
        profileViewController.view.backgroundColor = UIColor.blueColor()
        
        var searchViewController = SearchViewController(nibName: "SearchViewController" , bundle: nil)
        searchViewController.view.backgroundColor = UIColor.greenColor()
        
        var cameraViewController = UIViewController()
        cameraViewController.view.backgroundColor = UIColor.yellowColor()
        
        var viewControllers = [feedViewController,profileViewController,searchViewController,cameraViewController]
        self.setViewControllers(viewControllers, animated: true)
        
        let tabItems = tabBar.items as [UITabBarItem]
        
        var imagesArr = ["FeedIcon", "ProfileIcon" ,"SearchIcon" ,"CameraIcon"]
        
        for (index, value) in enumerate(tabItems)
        {
            var image = imagesArr[index]
            value.image = UIImage(named: image)
            value.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        
        }

       
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Sign Out" , style: .Done, target: self, action: "didTapSignOut:")
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "Photog"
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        var cameraViewController = self.viewControllers![3] as UIViewController
        if viewController == cameraViewController
        {
            self.showCamera()
            return false
        }
        
        return true
    }
    
    func showCamera()
    {
        //if !UIImagePickerController.isSourceTypeAvailable(.Camera)
        if !UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum)
            
        {
            println("Camera is not available")
      //      self.showAlert("", message:"Camera is not available" )
            return
        }
        
        var viewController = UIImagePickerController()
        //  viewController.sourceType = .Camera
        viewController.sourceType = .SavedPhotosAlbum
        viewController.delegate = self
        
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image: UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        println(image)
        
        var targetWidth = UIScreen.mainScreen().scale * UIScreen.mainScreen().bounds.size.width
        var resizedImage = image.resize(targetWidth)
        
        println(resizedImage)

        picker.dismissViewControllerAnimated(true, completion:{() -> Void in
        
        })
        
        NetworkManager.sharedInstance.postImage(image, completionHandler:{
            (error) -> () in
            
            if let constError = error
            {
                println(constError.localizedDescription)
            }
        }
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapSignOut(sender : AnyObject)
    {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
  
   }
