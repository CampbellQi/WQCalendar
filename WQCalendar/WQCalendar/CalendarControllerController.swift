//
//  CalendarControllerController.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/15.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class CalendarControllerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainSize = UIScreen.main.bounds.size
        let view  = WQCalendarView.init(frame: CGRect.init(x: 0, y: 0, width: mainSize.width - 22 * 2, height: 366))
        view.layer.cornerRadius = 5.0
        view.selectedBlock = {date in
            print("date = \(date)")
            self.dismiss(animated: false, completion: nil)
        }
        self.view.addSubview(view)
        view.center = CGPoint.init(x: mainSize.width/2, y: mainSize.height/2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
