import SwiftUI

struct Expense:Identifiable, Hashable{
    var id = UUID().uuidString
    var remark:String
    var amount:Double
    var date:Date
    var type:ExpenseType
    var color:String
}

enum ExpenseType:String{
    case income = "예산"
    case expense = "지출"
    case all = "ALL"
}

var sample_expenses: [Expense] = [
    Expense(remark: "항공값", amount: 50700, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Red"),
    Expense(remark: "까망돼지 점심값", amount: 25000, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Purple"),
    Expense(remark: "탐나오 제주 숙소", amount: 80000, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Red"),
    Expense(remark: "티뮤지엄 프리미엄 티 컬렉션 세트", amount: 28000, date: Date(timeIntervalSince1970: 1652296045), type: .expense, color: "Yellow"),
    Expense(remark: "카페", amount: 9000, date: Date(timeIntervalSince1970: 1651864045), type: .expense, color: "Purple"),
    Expense(remark: "테디베어 뮤지엄", amount: 18000, date: Date(timeIntervalSince1970: 1651432045), type: .expense, color: "Purple")
]

