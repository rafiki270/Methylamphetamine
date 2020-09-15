import SwiftUI


public typealias People = [Person]


public struct Person: Codable, Identifiable, Hashable {

//    public enum Category: String, Codable {
//        case betterCallSaul = "Better Call Saul"
//        case breakingBad = "Breaking Bad"
//        case both = "Breaking Bad, Better Call Saul"
//    }


    public enum Status: String, Codable, CaseIterable {
        case alive = "Alive"
        case deceased = "Deceased"
        case presumedDead = "Presumed dead"
        case unknown
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            guard let raw = Self.allCases.first(where: { $0.rawValue == value })?.rawValue else {
                self.init(rawValue: "unknown")!
                return
            }
            self.init(rawValue: raw)!
        }
        
        public var color: Color {
            switch self {
            case .alive:
                return Color.green
            case .deceased:
                return Color.red
            case .presumedDead:
                return Color.orange
            default:
                return Color.gray
            }
        }
        
    }
    
    public let id: Int?
    public let name: String
    public let birthday: String?
    public let occupation: [String]?
    public let img: String?
    public let status: Status
    public let nickname: String?
    public let appearance: [Int]?
    public let portrayed: String?
    public let category: String?
    public let betterCallSaulAppearance: [Int]?

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name = "name"
        case birthday = "birthday"
        case occupation = "occupation"
        case img = "img"
        case status = "status"
        case nickname = "nickname"
        case appearance = "appearance"
        case portrayed = "portrayed"
        case category = "category"
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }

    public init(id: Int?, name: String, birthday: String?, occupation: [String]?, img: String?, status: Status = .unknown, nickname: String?, appearance: [Int]?, portrayed: String?, category: String?, betterCallSaulAppearance: [Int]?) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.occupation = occupation
        self.img = img
        self.status = status
        self.nickname = nickname
        self.appearance = appearance
        self.portrayed = portrayed
        self.category = category
        self.betterCallSaulAppearance = betterCallSaulAppearance
    }
    
}
