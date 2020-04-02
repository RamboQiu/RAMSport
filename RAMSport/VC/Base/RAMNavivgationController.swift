//
//  RAMNavivgationController.swift
//  RAMSport
//
//  Created by rambo on 2020/4/2.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMNavivgationController: UINavigationController {
    
    let transitionDelegate = RAMNavigationTransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = transitionDelegate
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
