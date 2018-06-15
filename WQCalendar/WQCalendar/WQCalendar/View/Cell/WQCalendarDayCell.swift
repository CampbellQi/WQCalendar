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
                contentLbl.text = "\(sourceModel.day!)"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
