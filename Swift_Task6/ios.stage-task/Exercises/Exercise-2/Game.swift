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
        var minTrumpValueOfPlayers = [Int]()
        for player in players {
            let minTrumpCardInHand = player.hand?.filter { $0.isTrump == true }.min { $0.value.rawValue < $1.value.rawValue }
            minTrumpValueOfPlayers.append(minTrumpCardInHand?.value.rawValue ?? 20)
        }
        guard minTrumpValueOfPlayers.min() != 20 else {
            return nil
        }
        if let minTrumpValue = minTrumpValueOfPlayers.min(), let indexOfPlayer = minTrumpValueOfPlayers.firstIndex(of: minTrumpValue) {
        return players[indexOfPlayer]
             } else {
            return nil
        }
    }
}
