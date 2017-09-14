//
//  CategoryEnum.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

enum CategoryEnum:UInt32 {
    case noCategory = 0
    case laserHubCategory = 1
    case laserBeamCategory = 2
    case projectileCategory = 4
    case heroCategory = 8
    
    init?(rawValue: UInt32) {
        switch rawValue {
        case 0:
            self = .noCategory
            break
        case 1:
            self = .laserHubCategory
            break
        case 2:
            self = .laserBeamCategory
        case 4:
            self = .projectileCategory
        case 8:
            self = .heroCategory
        default:
            return nil
        }
    }
}
