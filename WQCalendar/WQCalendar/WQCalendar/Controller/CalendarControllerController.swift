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

        //模拟数据
        let dict = [["start": "2018-6-1", "end": "2018-6-27", "status": "1"],
                    ["start": "2018-7-5", "end": "2018-7-20", "status": "0"],
                    ["start": "2018-5-2", "end": "2018-5-29", "status": "1"]]
        
        
        var timeRange: [WQCalendarTimeRangeModel] = []
        for item in dict {
            let trm = WQCalendarTimeRangeModel()
            let startDate = WQCalendar.dateFromStr(date: "\(item["start"]!) 12:00:00", format: WQCalendar.TIME)
            trm.startDay = Int(WQCalendar.dateToStr(date: startDate, format: "dd"))!
            trm.startMonth = Int(WQCalendar.dateToStr(date: startDate, format: "MM"))!
            trm.startYear = Int(WQCalendar.dateToStr(date: startDate, format: "yyyy"))!
            
            let endDate = WQCalendar.dateFromStr(date: "\(item["end"]!) 12:00:00", format: WQCalendar.TIME)
            trm.endDay = Int(WQCalendar.dateToStr(date: endDate, format: "dd"))!
            trm.endMonth = Int(WQCalendar.dateToStr(date: endDate, format: "MM"))!
            trm.endYear = Int(WQCalendar.dateToStr(date: endDate, format: "yyyy"))!
            
            trm.status = item["status"]!
            
            timeRange.append(trm)
        }
        
        
        let mainSize = UIScreen.main.bounds.size
        let view  = WQCalendarView.init(frame: CGRect.init(x: 0, y: 0, width: mainSize.width - 22 * 2, height: 325))
        view.timeRangeData = timeRange
        
        view.selectedBlock = {date in
            print("date = \(date)")
            self.dismiss(animated: false, completion: nil)
        }
        self.view.addSubview(view)
        view.center = CGPoint.init(x: mainSize.width/2, y: mainSize.height/2)
        
        view.setUpData()
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
