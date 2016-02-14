//
//  CAShapeTestViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 2/3/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class CAShapeTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 64, y: 64, width: 160, height: 160), cornerRadius: 50).CGPath
        layer.fillColor = UIColor.redColor().CGColor
        view.layer.addSublayer(layer)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
