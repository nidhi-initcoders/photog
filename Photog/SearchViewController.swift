//
//  SearchViewController.swift
//  Photog
//
//  Created by Dhiraj Laddha on 22/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate , UITableViewDataSource
{
    
    
    @IBOutlet var searchBar: UISearchBar?
    @IBOutlet var tableView: UITableView?
    
    
    var searchresult = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var nib = UINib(nibName: "PersonCell" , bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "PersonCellIdentifier")

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCellIdentifier") as PersonCell
        
        //        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("postCell1") as postCell1
        
        var user = self.searchresult[indexPath.row] as PFUser
        
        //cell.textLabel?.text=user.username
        cell.user = user
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchresult.count
    }

    
  
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(true , animated: true)

    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
         searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        
        var searchTerm = searchBar.text
        
        NetworkManager.sharedInstance.findUsers(searchTerm, completionHandler: {
            (objects, error) -> () in
          
   //         println(objects)
   //         println(error)
            
            if let constObjects = objects
            {
                self.searchresult = constObjects
                self.tableView?.reloadData()
            }
            else if let constError = error
            {
  //              self.showAlert("Unable to conduct search")
            }
        })
    }
    


  
}
