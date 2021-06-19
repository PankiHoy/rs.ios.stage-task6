//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        if let hand = hand {
            for currentCard in hand {
                return currentCard.value == card.value
            }
        }
        
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        for (top, _) in table {
            for card in hand! {
                if card.value == top.value {
                    return true
                }
            }
        }
        
        return false
    }
}
