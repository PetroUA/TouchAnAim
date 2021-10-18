//
//  Aims.swift
//  TouchAnAim
//
//  Created by Petro on 18.10.2021.
//

import UIKit

protocol AimsDelegate: AnyObject {
    func aimsDelegate()
    
}

class Aims {
    var aimsNumber = 10
    weak var delegate : AimsDelegate?
    
    func getRamdomAim (aims: [UIButton]) -> [UIButton] {
        let ramdomNumber = Int.random(in: 0..<aims.count - 1)
        aims [ramdomNumber].setImage(UIImage(named: "spider"), for: .normal)
        aimsNumber -= 1
        if aimsNumber == 0 {
            self.delegate?.aimsDelegate()
            aims [ramdomNumber].setImage(nil, for: .normal)
        }
        return aims
    }
}
