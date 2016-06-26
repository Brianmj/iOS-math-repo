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
        
        let m1 = Matrix4()
        m1.column0 = Vector4(x: 1, y: 2, z: 3, w: 4)
        print(m1.column0)
        m1.column1 = Vector4(x: 11, y: 22, z: 33, w: 44)
        print(m1.column1)
        m1.column2 = Vector4(x: 55, y: 66, z: 77, w: 88)
        print(m1.column2)
        m1.column3 = Vector4(x: 5, y: 6, z: 7, w: 8)
        print(m1.column3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

