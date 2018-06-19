//
//  WQCalendarModel.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/14.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class WQCalendarModel: NSObject {
    var day: Int!
    var year: Int!
    var month: Int!
    
    var status: String = "可预约"
    var isCurrentMonth = true //是否是当月日子
}
