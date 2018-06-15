//
//  WQCalendarInnerView.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/14.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

let WQCALENDAR_RANK = 7 //日历显示7列

class WQCalendarMonthView: UIView {
    let cellId = "WQCalendarDayCell"
    let interitemSpacing: CGFloat = 0,  lineSpacing: CGFloat = 0//两个day的左右间距,上下距离
    
    //选择日期回调
    var selectedBlock: ((_ date: Date) -> Void)?
    //行数默认5
    var rows = 5
    var sourceData: [WQCalendarModel] = [] {
        didSet{
            //重新计算行高
            rows = sourceData.count / WQCALENDAR_RANK
            self.collectionView.setCollectionViewLayout(self.layout, animated: false)
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //定义flowlayout
    var layout: UICollectionViewFlowLayout! {
        let layout = UICollectionViewFlowLayout.init()
        let sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.sectionInset = sectionInset
        let width = (self.collectionView.frame.width - (CGFloat(WQCALENDAR_RANK)-1) * interitemSpacing) / CGFloat(WQCALENDAR_RANK)
        let height = (self.collectionView.frame.height - (CGFloat(rows)-1) * lineSpacing) / CGFloat(rows)
        layout.itemSize = CGSize.init(width: Int(width), height: Int(height))
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let topView = Bundle.main.loadNibNamed("WQCalendarMonthView", owner: self, options: nil)![0] as! UIView
        topView.frame = self.bounds
        self.addSubview(topView)
        //注册cell
        let nib = UINib.init(nibName: cellId, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
       self.collectionView.setCollectionViewLayout(self.layout, animated: false)
    }
}

extension WQCalendarMonthView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WQCalendarDayCell
        cell.sourceModel = self.sourceData[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sourceData.count   //月有多少天
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WQCalendarDayCell
        let model = cell.sourceModel
        let date = WQCalendar.dateFromStr(date: "\(model!.year!)-\(model!.month!)-\(model!.day!) 12:00:00", format: WQCalendar.TIME)
        self.selectedBlock?(date)
    }
}

