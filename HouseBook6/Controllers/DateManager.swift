//
//  DateManager.swift
//  TestCalendar
//
//  Created by Ryu on 2022/04/26.
//

import UIKit

class DateManager: NSObject {

    //現在の日8
    var selectDay = Date()
    var biginDay = Date()
    var endDay = Date()

    let calendar = Calendar.current

    //月カレンダーの始点になる日を求める
    func BeginOfMonthCalender() -> Date{

        //日付の要素を1日にする
        var components = calendar.dateComponents([.year,.month,.day], from: selectDay)
        components.day = 1
        //1日から始まるカレンダーをfirstOfMonthで作成する
        let firstOfMonth = Calendar.current.date(from: components)

        //曜日を取得
        let dayOfWeek = calendar.component(.weekday,from:firstOfMonth!)

        //金曜日=6で1日に左上がきているので、金曜日は日曜日(左上)から要素数5ずれた場所→だからvalueで-5して金曜日と1日の位置を合わしたいから1-6(dayOfWeek)=-5
        //時間データに変換
        //特定のコンポーネントの量を特定の日付に追加して計算された日付を表す新しい日付を返す
        //曜日を調べて、その要素数だけ戻ったものがカレンダーの左上(日曜日=1 土曜日=7　なので1足した状態で戻る)
        return calendar.date(byAdding: .day, value: 1-dayOfWeek, to: firstOfMonth!)!
    }

    //月カレンダーの終点になる日を求める
    func EndOfMonthCalendar() -> Date {

        //次の月初めを取得
        let nextmonth = calendar.nextDate(after: selectDay, matching: DateComponents(day:1), matchingPolicy: Calendar.MatchingPolicy.nextTime)

        //曜日を調べて、その要素数だけ進んだものが右下(次の月の初めで計算している事に注意)
        //nextmonthの曜日を取得
        let dayOfWeek = calendar.component(.weekday,from: nextmonth!)

        return calendar.date(byAdding: .day, value: 7-dayOfWeek, to: nextmonth!)!
    }
    //月ごとのセルの数を出すメソッド
    func daysAcquisition() -> Int{

        //始まりの日と終わりの日を取得
        biginDay = BeginOfMonthCalender()
        endDay = EndOfMonthCalendar()

        //始点から終点の日数
        return calendar.dateComponents([.day], from: biginDay ,to: endDay).day! + 1
    }
    //カレンダーの始点から指定した日数を加算した日付を返す
    func conversionDateFormat(index: Int) -> String {
        //indexの数値をカレンダーの日にちに反映
        let currentDay = calendar.date(byAdding: .day, value: index, to: biginDay)
        //月を取得
        let currentMonth = calendar.component(.month, from: currentDay!)
        //曜日を取得
        let currentWeekDay = calendar.component(.weekday, from: currentDay!)
        var currentWeekDayString: String!

        switch currentWeekDay {
            case 1:
                currentWeekDayString = "日"
            case 2:
                currentWeekDayString = "月"
            case 3:
                currentWeekDayString = "火"
            case 4:
                currentWeekDayString = "水"
            case 5:
                currentWeekDayString = "木"
            case 6:
                currentWeekDayString = "金"
            case 7:
                currentWeekDayString = "土"
            default:
                break
        }
        //変数h1Labelにまとめる
        let h1Label = "\(currentMonth)/\(calendar.component(.day, from: currentDay!).description)(\(currentWeekDayString!))"

        return h1Label
    }

    //今セレクトされているselectDayの年月をテキストで出力
    func CalendarHeader() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"

        return formatter.string(from: selectDay)
    }


    /*
     表示月を変える操作
     */

    //SelectDayを一ヶ月戻す
    func preMonthCalendar(preMonthData: Int){
        selectDay = calendar.date(byAdding: .month, value: preMonthData, to: selectDay)!
    }

    func resetMonthCalendar(resetMonthData: Int) {
        selectDay = calendar.date(byAdding: .month, value: -resetMonthData, to: selectDay)!
    }

    //SelectDayを1か月進ませる
    func nextMonthCalendar(nextMonthData: Int){
        selectDay = calendar.date(byAdding: .month, value: nextMonthData, to: selectDay)!
    }

    //コレクションCell用に日にちを取得する関数
    func getCurrentCellDay(index: Int) -> String {
        let currentDay = calendar.date(byAdding: .day, value: index, to: biginDay)
        return "\(calendar.component(.day, from: currentDay!))"
    }
    //コレクションCell用に月を取得する関数
    func getCurrentCellMonth(index: Int) -> String {
        let currentDay = calendar.date(byAdding: .day, value: index, to: biginDay)
        return "\(calendar.component(.month, from: currentDay!))"
    }
}

