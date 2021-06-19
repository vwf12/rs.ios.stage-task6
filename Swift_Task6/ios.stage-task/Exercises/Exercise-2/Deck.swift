import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        switch type {
        case .deck36:
            self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
        }
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var deck = [Card]()
        for suit in Suit.allCases {
            for value in Value.allCases {
                deck.append(Card(suit: suit, value: value))
            }
        }
        return deck
    }

    public mutating func shuffle() {
        self.cards.shuffle()
    }

    public mutating func defineTrump() {
        if let lastCard = self.cards.last {
            self.trump = lastCard.suit
            for i in 0...self.cards.count-1 {
                if cards[i].suit == self.trump {
                    cards[i].isTrump = true
                }
            }
        }
       
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        let playersCount = players.count
//        for i in 0...playersCount - 1 {
//            var cards = [Card]()
//            for j in stride(from: i, through: self.cards.count - 1, by: playersCount) {
//                cards.append(self.cards[j])
//            }
//            players[i].hand = cards
//        }
        for i in 0...playersCount - 1 {
            players[i].hand = Array(self.cards.prefix(6))
            self.cards.removeFirst(6)
        }
    }

    public func setTrumpCards(for suit:Suit) {

    }
}

