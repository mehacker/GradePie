//
//  ChartViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 10/24/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet weak var pieView: pie!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layer = CALayer ();
        layer.frame = CGRectMake(50, 50, 50, 50)
        var redColor = UIColor.redColor()
        layer.backgroundColor = redColor.CGColor
        
        self.pieView.backgroundColor = UIColor.redColor()
        
        let context = UIGraphicsGetCurrentContext()
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
