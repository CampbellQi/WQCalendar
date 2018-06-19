//
//  WQCalendarTimeRangeModel.swift
//  Housekeeping
//
//  Created by CampbellQi on 2018/6/15.
//  Copyright © 2018年 张旭. All rights reserved.
//

import UIKit

class WQCalendarTimeRangeModel: NSObject {
    
    @objc var startDay: Int = 0
    @objc var startMonth: Int = 0
    @objc var startYear: Int = 0
    
    @objc var endDay: Int = 0
    @objc var endMonth: Int = 0
    @objc var endYear: Int = 0
    
    @objc var status: String = ""
    
    @objc convenience init(startDate: Date, endDate: Date) {
        self.init()
        
        self.startDay = Int(WQCalendar.dateToStr(date: startDate, format: "dd"))!
        self.startMonth = Int(WQCalendar.dateToStr(date: startDate, format: "MM"))!
        self.startYear = Int(WQCalendar.dateToStr(date: startDate, format: "yyyy"))!
        
        self.endDay = Int(WQCalendar.dateToStr(date: endDate, format: "dd"))!
        self.endMonth = Int(WQCalendar.dateToStr(date: endDate, format: "MM"))!
        self.endYear = Int(WQCalendar.dateToStr(date: endDate, format: "yyyy"))!
    }
}
