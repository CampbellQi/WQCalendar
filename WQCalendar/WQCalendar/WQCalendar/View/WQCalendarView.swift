//
//  WQCalendarView.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/14.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class WQCalendarView: UIView {
    private let cellId = "WQCalendarCell"
    
    //数据源
    private var sourceData: [[WQCalendarModel]] = []
    //日期区间数据
    @objc var timeRangeData: [WQCalendarTimeRangeModel]?
    //当前所用日历
    private var currentCalendar: WQCalendar!
    
    //选择日期回调
    @objc var selectedBlock: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentDateLbl: UILabel!
    
    @IBAction func nextMonthAction(_ sender: Any) {
        self.collectionView.scrollToItem(at: IndexPath.init(row: self.sourceData.count-1, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            self.currentCalendar = WQCalendar.init(currentDate: self.currentCalendar.nextMonth)
            self.setUpData()
        }
        
        
    }
    @IBAction func lastMonthAction(_ sender: Any) {
        if self.sourceData.count > 2 {
            self.collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
                self.currentCalendar = WQCalendar.init(currentDate: self.currentCalendar.lastMonth)
                self.setUpData()
            }
        }
    }
    //定义flowlayout
    private var layout: UICollectionViewFlowLayout! {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize.init(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        return layout
    }
    
    @objc override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let topView = Bundle.main.loadNibNamed("WQCalendarView", owner: self, options: nil)![0] as! UIView
        topView.frame = self.bounds
        self.addSubview(topView)
        //注册cell
        let nib = UINib.init(nibName: cellId, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        
        self.layoutIfNeeded()
        self.collectionView.setCollectionViewLayout(self.layout, animated: false)
        
        self.currentCalendar = WQCalendar.init(currentDate: Date())
    }
    
    @objc func setUpData() {
        self.currentDateLbl.text = "\(self.currentCalendar.year!)年\(self.currentCalendar.month!)月"
        
        let currentMonthData = self.getMonthData(calendar: self.currentCalendar)
        let nextMonthData = self.getMonthData(calendar: WQCalendar.init(currentDate: self.currentCalendar.nextMonth))
        
        let nowCalendar = WQCalendar.init(currentDate: Date())
        if currentCalendar.year == nowCalendar.year && currentCalendar.month == nowCalendar.month {
            self.sourceData = [currentMonthData, nextMonthData]
            self.collectionView.reloadData()
            
            self.leftBtn.isSelected = true
        }else {
            let lastMonthData = self.getMonthData(calendar: WQCalendar.init(currentDate: self.currentCalendar.lastMonth))
            self.sourceData = [lastMonthData ,currentMonthData, nextMonthData]
            self.collectionView.reloadData()
            
            self.collectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: UICollectionViewScrollPosition.left, animated: false)
            
            self.leftBtn.isSelected = false
        }
    }
    
    //根据月份时间获取数据
    private func getMonthData(calendar: WQCalendar) -> [WQCalendarModel] {
        let weekday = calendar.monthFirstDayWeekday
        let days = calendar.daysOfMonth
        /*准备数据源*/
        var currentMonthData: [WQCalendarModel] =  []
        //当前页显示当前月的数据
        for i in 1 ... days! {
            let model = WQCalendarModel()
            model.day = i
            model.year = calendar.year
            model.month = calendar.month
            self.setModelStatus(model: model)
            currentMonthData.append(model)
        }
        
        //当前页显示上个月的数据
        let lastCalendar = WQCalendar.init(currentDate: calendar.lastMonth)
        let lastDays = lastCalendar.daysOfMonth
        var lastMonthData: [WQCalendarModel] = []
        for i in lastDays! - (weekday! - 1) ..< lastDays! {
            let model = WQCalendarModel()
            model.day = i
            model.year = lastCalendar.year
            model.month = lastCalendar.month
            model.isCurrentMonth = false
            
            self.setModelStatus(model: model)
            lastMonthData.append(model)
        }
        
        //当前页显示下个月的数据
        var nextMonthData: [WQCalendarModel] = []
        let nextCalendar = WQCalendar.init(currentDate: calendar.nextMonth)
        
        let wdays = days! + (weekday!-1)
        if wdays%WQCALENDAR_RANK != 0 {
            let leftDays = (Int(wdays/WQCALENDAR_RANK) + 1) * WQCALENDAR_RANK - wdays
            for i in 0 ..< leftDays {
                let model = WQCalendarModel()
                model.day = i + 1
                model.month = nextCalendar.month
                model.year = nextCalendar.year
                model.isCurrentMonth = false
                
                self.setModelStatus(model: model)
                nextMonthData.append(model)
            }
        }
        
        return lastMonthData + currentMonthData + nextMonthData
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.layoutIfNeeded()
        
    }

    func setModelStatus(model cm: WQCalendarModel) {
        if let _ = timeRangeData {
            let date = WQCalendar.dateFromStr(date: "\(cm.year!)-\(cm.month!)-\(cm.day!) 12:00:00", format: WQCalendar.TIME).timeIntervalSince1970
            for trm in timeRangeData! {
                let startDate = WQCalendar.dateFromStr(date: "\(trm.startYear)-\(trm.startMonth)-\(trm.startDay) 12:00:00", format: WQCalendar.TIME).timeIntervalSince1970
                let endDate = WQCalendar.dateFromStr(date: "\(trm.endYear)-\(trm.endMonth)-\(trm.endDay) 12:00:00", format: WQCalendar.TIME).timeIntervalSince1970
                if (date >= startDate && date <= endDate)  {
                    cm.status = trm.status
                    break
                }
            }
        }
    }
    

}

extension WQCalendarView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WQCalendarCell
        cell.calendarMonthView.sourceData = self.sourceData[indexPath.row]
        cell.calendarMonthView.selectedBlock = self.selectedBlock
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sourceData.count
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.isUserInteractionEnabled = false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = true
        
        let index = scrollView.contentOffset.x / scrollView.frame.width
        
        if index == 2 {
            self.currentCalendar = WQCalendar.init(currentDate: self.currentCalendar.nextMonth)
        }else if index == 0{
            if self.sourceData.count > 2 {
                self.currentCalendar = WQCalendar.init(currentDate: self.currentCalendar.lastMonth)
            }
        }else if index == 1 {
            if self.sourceData.count < 3 {
                self.currentCalendar = WQCalendar.init(currentDate: self.currentCalendar.nextMonth)
            }
        }
        
        self.setUpData()
        
    }
}
