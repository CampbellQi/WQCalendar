//
//  WQCalendarDayCell.swift
//  WQCalendar
//
//  Created by CampbellQi on 2018/6/14.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class WQCalendarDayCell: UICollectionViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var sourceModel: WQCalendarModel! {
        didSet {
            if let _ = sourceModel {
                //日子
                contentLbl.text = "\(sourceModel.day!)"
                
                //根据状态颜色设置
                var status = "可预约"
                var color = UIColor.init(red: 49/255.0, green: 194/255.0, blue: 124/255.0, alpha: 1)
                switch Int(sourceModel.status) {
                case 2 :
                    status = "不可预约"
                    color = UIColor.init(red: 194/255.0, green: 187/255.0, blue: 194/255.0, alpha: 1)
                    break
                case 1:
                    status = "已预约"
                    color = UIColor.init(red: 255/255.0, green: 156/255.0, blue: 0/255.0, alpha: 1)
                    break
                default:
                    break
                }
                
                descLbl.textColor = color
                descLbl.text = status
                
                //非本月日子设置颜色区分
                var contentColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
                if sourceModel.isCurrentMonth == false {
                    contentColor = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
                }
                self.contentLbl.textColor = contentColor
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
