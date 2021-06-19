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
        createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public mutating func createDeck(suits:[Suit], values:[Value]) {
        for i in 0..<suits.count {
            for j in 0..<values.count {
                self.cards.append(Card(suit: suits[i], value: values[j], isTrump: false))
            }
        }
    }

    public mutating func shuffle() {
        let temp = cards.shuffled()
        if temp != cards {
            cards = temp
        }
    }

    public mutating func defineTrump() {
        self.trump = cards.last?.suit
        
        for i in 0..<cards.count {
            if cards[i].suit == trump {
                cards[i].isTrump = true
            }
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        if players.count == 0 || players.count > 6 {
            return
        }
        
        for i in 0..<players.count {
            players[i].hand = []
            for _ in 0..<6 {
                if let card = cards.popLast() {
                    players[i].hand?.append(card)
                }
            }
        }
    }

    public func setTrumpCards(for suit:Suit) {
        
    }
}

