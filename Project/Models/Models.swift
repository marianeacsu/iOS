struct Repository {
    var name: String
    let fullName: String
    let description: String?
    let htmlUrl: String
    let forks: Int
    let watchers: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case forks
        case watchers
    }
}

struct Repositories: Decodable {
    let items: [Repository]
}

struct Readme {
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content
    }
}

struct AppUser: Codable {
    var id: String
    var email: String
    var name: String
    var password: String
}

// MARK: - Decodable

extension Repository: Decodable, Hashable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        fullName = try container.decode(String.self, forKey: .fullName)
        description = try? container.decode(String.self, forKey: .description)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        forks = try container.decode(Int.self, forKey: .forks)
        watchers = try container.decode(Int.self, forKey: .watchers)
    }
}

extension Readme: Decodable, Hashable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decode(String.self, forKey: .content)
    }
}
