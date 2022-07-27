import SwiftUI

// Task Model
struct Task:Identifiable{
    var id = UUID().uuidString
    var title:String
    var time:Date = Date()
}

struct TaskMetaData:Identifiable{
    var id = UUID().uuidString
    var task:[Task]
    var taskDate:Date
}

func getSampleDate(offset:Int)->Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var tasks: [TaskMetaData] = [
 TaskMetaData(task: [
    Task(title: "제주도 맛집 찾기"),
    Task(title: "제주도 관광지 찾기"),
    Task(title: "제주도 갈 여행 티켓 예매하기!!")
 ], taskDate: getSampleDate(offset: 1)),
 
 TaskMetaData(task: [
    Task(title: "제주도 여행 티켓 잘했는지 확인")
 ], taskDate: getSampleDate(offset: -3)),
 
 TaskMetaData(task: [
    Task(title: "짐 싸기!")
 ], taskDate: getSampleDate(offset: -8)),
 
 TaskMetaData(task: [
    Task(title: "ㅁㅁㅁ 에게 연락하기")
 ], taskDate: getSampleDate(offset: 10)),
 
 TaskMetaData(task: [
    Task(title: "몇 시간 도착하는지 확인")
 ], taskDate: getSampleDate(offset: -22)),

 TaskMetaData(task: [
    Task(title: "비행기 늦지 않도록 출발하기")
 ], taskDate: getSampleDate(offset: 15)),
 
 TaskMetaData(task: [
    Task(title: "보험들기")
 ], taskDate: getSampleDate(offset: -20)),
]
