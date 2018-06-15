//
//  WQCalendarUtil.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/14.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class WQCalendar: NSObject {
    //日期时间转换格式
    static let YTD = "yyyy-MM-dd"
    static let TIME = "yyyy-MM-dd HH:mm:ss"
    
    //日期时间转换器
    static let dateFormater = DateFormatter()  //类变量，耗内存
    //日历
    static let calendar = Calendar.current //类变量，耗内存
    
    var year: Int!  //年
    var month: Int! //月
    
    var currentDate: Date!  //当前时间，初始化时确定
    
    //初始化
    init(currentDate: Date) {
        self.currentDate = currentDate
        
        self.year = WQCalendar.calendar.component(Calendar.Component.year, from: self.currentDate)
        self.month = WQCalendar.calendar.component(Calendar.Component.month, from: self.currentDate)
        super.init()
    }

    //获取月份的天数
    lazy var daysOfMonth: Int! = {
        let monthNum = WQCalendar.calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self.currentDate)
        return monthNum!.count
    }()
    
    //获取指定月份第一天是星期几
    lazy var monthFirstDayWeekday: Int! = {
        var weekday = WQCalendar.calendar.component(Calendar.Component.weekday, from: self.monthFirstDay)
        //1周日2周一...7周六
        return weekday
    }()
    
    //上个月的时间
    lazy var lastMonth: Date! = {
        let componentsSet = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var components = WQCalendar.calendar.dateComponents(componentsSet, from: self.currentDate)
        components.month = components.month! - 1
        return WQCalendar.calendar.date(from: components)!
    }()
    
    //下个月的时间
    lazy var nextMonth: Date! = {
        let componentsSet = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var components = WQCalendar.calendar.dateComponents(componentsSet, from: self.currentDate)
        components.month = components.month! + 1
        return WQCalendar.calendar.date(from: components)!
    }()
    
    //获取指定月第一天
    private lazy var monthFirstDay: Date! = {
        let componentsSet = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var components = WQCalendar.calendar.dateComponents(componentsSet, from: self.currentDate)
        components.day = 1
        return WQCalendar.calendar.date(from: components)!
    }()
    
    
}

extension WQCalendar {
    //时间转字符串
    class func dateToStr(date: Date, format: String) -> String {
        WQCalendar.dateFormater.dateFormat = format
        return WQCalendar.dateFormater.string(from: date)
    }
    //字符串转时间转时间
    class func dateFromStr(date: String, format: String) -> Date {
        WQCalendar.dateFormater.dateFormat = format
        return WQCalendar.dateFormater.date(from: date)!
    }
}

