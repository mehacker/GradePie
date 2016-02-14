//
//  Graph.swift
//  GradePie
//
//  Created by Nathan Nguyen on 12/15/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit

@IBDesignable

class Graph: UIViewController {

    @IBOutlet weak var circleGraph: CircleGraphView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var slider2: UISlider!
    
    var aCourse = course ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(aCourse.name)
        
        circleGraph.endArc = 0.5
        circleGraph.endArc2 = 0.5
        circleGraph.arcWidth = 100.0
    }

    @IBAction func slider(sender: UISlider) {
        circleGraph.endArc = CGFloat(sender.value)
      
    }
    
    @IBAction func slider2(sender: UISlider) {
        circleGraph.endArc2 = CGFloat(sender.value)
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
