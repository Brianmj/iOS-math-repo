//
//  ViewController.swift
//  ios_math
//
//  Created by Brian Jones on 6/15/16.
//  Copyright © 2016 Brian Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let m1 = Matrix4.x_rotation(angle: 90.degreesToRadians)
        let v1 = Vector4(x: 0.0, y: 1.0, z: 0.0, w: 0.0)
        print(m1 * v1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

