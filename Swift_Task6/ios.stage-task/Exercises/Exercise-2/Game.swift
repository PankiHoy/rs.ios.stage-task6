//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {
    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        if players.count == 0 || !players.allSatisfy( { $0.hand!.count == 7 } ) {
            return nil
        }
        
        var firstPlayer = players.last
        var lowestTrump = players.last?.hand?.last
        
        for player in players {
            for card in player.hand! {
                if card.isTrump && card.value.rawValue < lowestTrump!.value.rawValue {
                    firstPlayer = player
                    lowestTrump = card
                }
            }
        }
        
        return firstPlayer
    }
}
