//
//  RAMStaticTableCellData.swift
//  RAMSport
//
//  Created by rambo on 2020/2/20.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMStaticTableCellData: NSObject {
    var cellIdentifier: String?
    var cellClass: AnyClass?
    var cellCustomSEL: Selector?
    var cellSelectSEL: Selector?
    var cellHeight: CGFloat = 0.0
    var model: Any?
}
