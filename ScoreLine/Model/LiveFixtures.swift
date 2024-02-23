// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let liveFixtures = try? JSONDecoder().decode(LiveFixtures.self, from: jsonData)

import Foundation

// MARK: - LiveFixtures
class LiveFixtures: Codable {
    var liveFixturesGet: String?
    var parameters: Parameters?
    var errors: [JSONAny]?
    var results: Int?
    var paging: Paging?
    var response: [Response]?

    enum CodingKeys: String, CodingKey {
        case liveFixturesGet
        case parameters, errors, results, paging, response
    }

    init(liveFixturesGet: String?, parameters: Parameters?, errors: [JSONAny]?, results: Int?, paging: Paging?, response: [Response]?) {
        self.liveFixturesGet = liveFixturesGet
        self.parameters = parameters
        self.errors = errors
        self.results = results
        self.paging = paging
        self.response = response
    }
}

// MARK: - Paging
class Paging: Codable {
    var current, total: Int?

    init(current: Int?, total: Int?) {
        self.current = current
        self.total = total
    }
}

// MARK: - Parameters
class Parameters: Codable {
    var live: String?

    init(live: String?) {
        self.live = live
    }
}

// MARK: - Response
class Response: Codable {
    var fixture: Fixture?
    var league: League?
    var teams, goals: Goals?
    var score: Score?
    var events: [Event]?

    init(fixture: Fixture?, league: League?, teams: Goals?, goals: Goals?, score: Score?, events: [Event]?) {
        self.fixture = fixture
        self.league = league
        self.teams = teams
        self.goals = goals
        self.score = score
        self.events = events
    }
}

// MARK: - Event
class Event: Codable {
    var time: Time?
    var team: Team?
    var player, assist: Assist?
    var type: TypeEnum?
    var detail: Detail?
    var comments: String?

    init(time: Time?, team: Team?, player: Assist?, assist: Assist?, type: TypeEnum?, detail: Detail?, comments: String?) {
        self.time = time
        self.team = team
        self.player = player
        self.assist = assist
        self.type = type
        self.detail = detail
        self.comments = comments
    }
}

// MARK: - Assist
class Assist: Codable {
    var id: Int?
    var name: String?

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

enum Detail: String, Codable {
    case normalGoal = "Normal Goal"
    case penalty = "Penalty"
    case redCard = "Red Card"
    case substitution1 = "Substitution 1"
    case substitution2 = "Substitution 2"
    case yellowCard = "Yellow Card"
}

// MARK: - Team
class Team: Codable {
    var id: Int?
    var name: String?
    var logo: String?
    var winner: Bool?

    init(id: Int?, name: String?, logo: String?, winner: Bool?) {
        self.id = id
        self.name = name
        self.logo = logo
        self.winner = winner
    }
}

// MARK: - Time
class Time: Codable {
    var elapsed: Int?
    var extra: Int?

    init(elapsed: Int?, extra: Int?) {
        self.elapsed = elapsed
        self.extra = extra
    }
}

enum TypeEnum: String, Codable {
    case card = "Card"
    case goal = "Goal"
    case subst = "subst"
}

// MARK: - Fixture
class Fixture: Codable {
    var id: Int?
    var referee: String?
    var timezone: Timezone?
    var date: Date?
    var timestamp: Int?
    var periods: Periods?
    var venue: Venue?
    var status: Status?

    init(id: Int?, referee: String?, timezone: Timezone?, date: Date?, timestamp: Int?, periods: Periods?, venue: Venue?, status: Status?) {
        self.id = id
        self.referee = referee
        self.timezone = timezone
        self.date = date
        self.timestamp = timestamp
        self.periods = periods
        self.venue = venue
        self.status = status
    }
}

// MARK: - Periods
class Periods: Codable {
    var first: Int?
    var second: Int?

    init(first: Int?, second: Int?) {
        self.first = first
        self.second = second
    }
}

// MARK: - Status
class Status: Codable {
    var long: Long?
    var short: Short?
    var elapsed: Int?

    init(long: Long?, short: Short?, elapsed: Int?) {
        self.long = long
        self.short = short
        self.elapsed = elapsed
    }
}

enum Long: String, Codable {
    case firstHalf = "First Half"
    case halftime = "Halftime"
    case secondHalf = "Second Half"
}

enum Short: String, Codable {
    case ht = "HT"
    case the1H = "1H"
    case the2H = "2H"
}

enum Timezone: String, Codable {
    case utc = "UTC"
}

// MARK: - Venue
class Venue: Codable {
    var id: Int?
    var name, city: String?

    init(id: Int?, name: String?, city: String?) {
        self.id = id
        self.name = name
        self.city = city
    }
}

// MARK: - Goals
class Goals: Codable {
    var home, away: Team?

    init(home: Team?, away: Team?) {
        self.home = home
        self.away = away
    }
}

enum Away: Codable {
    case integer(Int)
    case team(Team)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Team.self) {
            self = .team(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Away.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Away"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .team(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - League
class League: Codable {
    var id: Int?
    var name, country: String?
    var logo: String?
    var flag: String?
    var season: Int?
    var round: String?

    init(id: Int?, name: String?, country: String?, logo: String?, flag: String?, season: Int?, round: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.logo = logo
        self.flag = flag
        self.season = season
        self.round = round
    }
}

// MARK: - Score
class Score: Codable {
    var halftime, fulltime, extratime, penalty: Goals?

    init(halftime: Goals?, fulltime: Goals?, extratime: Goals?, penalty: Goals?) {
        self.halftime = halftime
        self.fulltime = fulltime
        self.extratime = extratime
        self.penalty = penalty
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
