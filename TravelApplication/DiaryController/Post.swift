import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Post:Identifiable, Codable{
    @DocumentID var id:String?
    var title:String
    var author:String
    var postContent: [PostContent]
    var date: Timestamp
    
    enum Codingkeys:String, CodingKey{
        case id
        case title
        case author
        case postContent
        case date
    }
}

struct PostContent:Identifiable, Codable{
    var id = UUID().uuidString
    var value:String
    var type:PostType
    
    // for height..
    var height: CGFloat = 0
    var showImage: Bool = false
    var showDeleteAlert: Bool = false
    
    enum Codingkeys: String, CodingKey{
        case type = "key"
        case value
    }
}

// Eg Header, Paragraph
enum PostType:String, CaseIterable, Codable{
    case Header = "제목"
    case SubHeading = "부제목"
    case Paragraph = "문단"
    case Image = "이미지"
}
