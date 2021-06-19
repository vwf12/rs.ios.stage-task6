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
        let possibleTossCards = self.hand?.filter { $0.value == card.value }
        if let possibleTossCards = possibleTossCards {
            if possibleTossCards.isEmpty {
                return false
            } else {
                return true
            }
        }
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        var possibleTossCards = [Card]()
        if let unwrappedHand = hand {
            for card in table {
                possibleTossCards = unwrappedHand.filter { $0.value == card.key.value || $0.value == card.value.value }
            }
        }
        return !possibleTossCards.isEmpty 

    }
}
