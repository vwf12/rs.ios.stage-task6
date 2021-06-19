import Foundation

protocol CardBaseCompatible: Hashable, Codable {
    var suit: Suit {get}
    var value: Value {get}
    var isTrump: Bool {get}

    func hash(into hasher: inout Hasher)
}

enum Suit: Int, CaseIterable, Codable {
    case clubs = 1
    case spades = 2
    case hearts = 3
    case diamonds = 4
}

enum Value: Int, Codable, CaseIterable {
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 14
}

struct Card: CardBaseCompatible {
    let suit: Suit
    let value: Value
    var isTrump: Bool = false

    func hash(into hasher: inout Hasher) {

    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.suit == rhs.suit && lhs.value == rhs.value)
    }
}

extension Card {

    func checkIfCanBeat(card: Card) -> Bool {
        if self.isTrump == true && card.isTrump == false {
            return true
        }
        if self.isTrump == false && card.isTrump == true {
            return false
        }
        if self.isTrump == true && card.isTrump == true {
            if self.value.rawValue > card.value.rawValue {
                return true
            } else {
                return false
            }
        }
        if self.isTrump == false && card.isTrump == false {
            if self.value.rawValue > card.value.rawValue {
                return true
            } else {
                return false
            }
        }
        return false
    }

    func checkValue(card: Card) -> Bool {
        return false
    }
}
