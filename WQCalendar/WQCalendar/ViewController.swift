//
//  ViewController.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/14.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func show(_ sender: Any) {
        let vc = CalendarControllerController()
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

