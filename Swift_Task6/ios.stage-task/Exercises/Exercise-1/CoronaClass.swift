import Foundation

class CoronaClass {
 
     var seats = [Int]()
     var emptySeats = Set<Int>()
     var takenSeats = Set<Int>()
     var seatsStatus: [Seat] = []
    
    struct Seat {
        let index: Int
        var taken: Bool
        var distanceToClosestTakenFromLeft: Int = 0
        var distanceToClosestTakenFromRight: Int = 0
        var minDistance: Int {
            min(distanceToClosestTakenFromRight, distanceToClosestTakenFromLeft)
        }
    }
    
    func calcDistanceToClosesTakenFromLeft(seat index: Int) -> Int {
        guard index != 0 else {
            return 99
        }
        var distance = index
        for i in (0...index-1).reversed() {
            guard seatsStatus[i].taken != true else {
                distance = index - i
                break
            }
        }
        return distance
    }

    func calcDistanceToClosesTakenFromRight(seat index: Int) -> Int {
        guard index != seatsStatus.count - 1 else {
            return 99
        }
        var distance = seatsStatus.count - 1 - index
        for i in (index + 1...seatsStatus.count - 1) {
            guard seatsStatus[i].taken != true else {
                distance = i - index
                break
            }
        }
        return distance
    }

     init(n: Int) {
        let emptyRange = 0...n-1
        emptySeats = Set(emptyRange)
        for i in 0...n-1 {
            seatsStatus.append(Seat(index: i, taken: false))
        }
     }
    
    func updateSeats() {
        print(seatsStatus)
        seats = seatsStatus.filter { $0.taken == true}.map { $0.index }.sorted { $0 < $1 }
    }
     
     func seat() -> Int {
        var indexesOfSeatsWithMaxDistance = [Int]()
        
        guard !takenSeats.isEmpty else {
            takenSeats.insert(0)
            emptySeats.remove(0)
            seatsStatus[0].taken = true
            updateSeats()
            return 0
        }
        guard !(takenSeats.contains(0) && takenSeats.count == 1) else {
            takenSeats.insert(seatsStatus.count - 1)
            emptySeats.remove(seatsStatus.count - 1)
            seatsStatus[seatsStatus.count - 1].taken = true
            updateSeats()
            return seatsStatus.count - 1
        }
        for i in 0...seatsStatus.count - 1 {
            seatsStatus[i].distanceToClosestTakenFromLeft = calcDistanceToClosesTakenFromLeft(seat: i)
            seatsStatus[i].distanceToClosestTakenFromRight = calcDistanceToClosesTakenFromRight(seat: i)
        }
        
        let maxDistanceOverall = seatsStatus.filter { $0.taken == false }.map { $0.minDistance }.max()
        for i in emptySeats.sorted(by: { $0 < $1 })  {
            if seatsStatus[i].minDistance == maxDistanceOverall {
                indexesOfSeatsWithMaxDistance.append(i)
            }
        }

        if let indexOfSeatToTake = indexesOfSeatsWithMaxDistance.first {
            seatsStatus[indexOfSeatToTake].taken = true
            takenSeats.insert(indexOfSeatToTake)
            emptySeats.remove(indexOfSeatToTake)
            updateSeats()
            return indexOfSeatToTake
        }
        return -1
        
     }
     
     func leave(_ p: Int) {
        guard p < seatsStatus.count else {
            return
        }
        takenSeats.remove(p)
        emptySeats.insert(p)
        seatsStatus[p].taken = false
        updateSeats()
     }
}
