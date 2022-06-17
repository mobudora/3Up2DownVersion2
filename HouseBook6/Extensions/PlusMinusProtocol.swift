//
//  PlusMinusProtocol.swift
//  HouseBook6
//
//  Created by Dora on 2022/05/14.
//

import Foundation

protocol PlusMinusProtocol {
    //±ボタンを押したときにセルの数を増やしたり減らしたりする
    //calc: (Int) -> IntでIntを1個受け取って1個Intを返す　返り値はInt1個(cellの数)
    func calcIncomeTableViewCell(calc: (Int) -> Int)
    func calcFixedCostTableViewCell(calc: (Int) -> Int)
}
