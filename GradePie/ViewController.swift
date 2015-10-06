//
//  ViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 10/5/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    
    var items: [String] = [ "Chemistry" , "Mathematics", "Computer Science"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRectMake(50, 50, 120, 300)
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        
   
        
        let rightPickerImageView = UIImageView(frame: CGRectMake(10, 10, 120, 60))
        let rightPicker : UIImage = UIImage(named: "rightarrow")!
        rightPickerImageView.image = rightPicker
        
        
        cell.backgroundView = UIView()
        cell.backgroundView?.addSubview(rightPickerImageView)
        
        //cell.imageView!.image = image
        
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
        
        
                // Do any additional setup after loading the view, typically from a nib.
        


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

  
    


}

