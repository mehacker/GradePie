//  ViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 10/5/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var rightPickerTableView: UITableView!
    var tableView: UITableView = UITableView()
    
    var items: [String] = [ "Biology" , "Mathematics", "Computer Science", "Accounting", "Computer Information System", "Nursing", "Physics", "Anatomy", "Education" ]
    
//    override func viewWillAppear(animated: Bool) {
//        AnimateTable()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRectMake(200, 50, 120, 300)
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        let rightPickerImageView = UIImageView(frame: CGRectMake(10, 10, 120, 60))
        let rightPicker : UIImage = UIImage(named: "rightarrow")!
        rightPickerImageView.image = rightPicker
        
        cell.backgroundView = rightPickerImageView
        
        //cell.backgroundView = UIView()
        4
        //cell.backgroundView?.addSubview(rightPickerImageView)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }
    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//    let firstRow = NSIndexPath(forRow: 0, inSection: 0)
//  
//        
//        let curvedArrowImageView = UIImageView(frame: CGRectMake(10, 10, 120, 60))
//        let curvedArrow : UIImage = UIImage(named: "curved right arrow")!
//        curvedArrowImageView.image = curvedArrow
//        
//        tableView .cellForRowAtIndexPath(firstRow)?.backgroundView = curvedArrowImageView
//        
//    }
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        // 1
//        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
//            // 2
//            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
//            
//            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            shareMenu.addAction(twitterAction)
//            shareMenu.addAction(cancelAction)
//            
//            
//            self.presentViewController(shareMenu, animated: true, completion: nil)
//        })
//        // 3
//        var rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Rate" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
//            // 4
//            let rateMenu = UIAlertController(title: nil, message: "Rate this App", preferredStyle: .ActionSheet)
//            
//            let appRateAction = UIAlertAction(title: "Rate", style: UIAlertActionStyle.Default, handler: nil)
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            rateMenu.addAction(appRateAction)
//            rateMenu.addAction(cancelAction)
//            
//            
//            self.presentViewController(rateMenu, animated: true, completion: nil)
//        })
//        // 5
//        return [shareAction,rateAction]
//    }
    
//    func AnimateTable() {
//    tableView.reloadData()
//    
//    let cells = tableView.visibleCells
//    let tableHeight: CGFloat = tableView.bounds.size.height
//        
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
//        }
//        
//        var index = 0
//        
//        for a in cells {
//            let cell: UITableViewCell = a as UITableViewCell
//         UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:UIViewAnimationOptions.ShowHideTransitionViews, animations: {
//                cell.transform = CGAffineTransformMakeTranslation(0, 0);
//                }, completion: nil)
//            
//            index += 1
//        }
//        
//    }


}


