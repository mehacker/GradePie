//
//  sliceLayer.swift
//  GradePie
//
//  Created by Nathan Nguyen on 3/26/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class sliceLayer: CAShapeLayer {
    var aSection = section ()
    
    var endArc:CGFloat = 0.0{   // in range of 0.0 to 1.0
        didSet{
            setNeedsDisplay()
        }
    }
}
