import Foundation

class CoronaClass {
    
    var seats = [Int]() // 0, 10, 14
    var blankSeats = [Int]() // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
    
    init(n: Int) {
        for i in 0..<n {
            blankSeats.append(i)
        }
    }
    
    func seat() -> Int {
        if seats.count < 2 {
            if seats.contains(0) {
                seats.append(blankSeats.last!)
                seats.sort()
                return blankSeats.last!
            } else {
                seats.append(0)
                seats.sort()
                return 0
            }
        }
        
        var tempStack = [Int: Int]()
        var tempArray = [Int]()
        var maxDistance = 0
        var seatNumber = 0
        
        for i in 1..<seats.count {
            if let indexOfLowerBound = blankSeats.firstIndex(of: seats[i-1]) {
                if let indexOfUpperBound = blankSeats.firstIndex(of: seats[i]) {
                    for j in indexOfLowerBound..<indexOfUpperBound {
                        if min((blankSeats[j] - seats[i-1]), seats[i] - blankSeats[j]) > maxDistance && !seats.contains(blankSeats[j]){
                            maxDistance = min((blankSeats[j] - seats[i-1]), seats[i] - blankSeats[j])
                            tempStack[blankSeats[j]] = maxDistance
                        }
                    }
                }
            }
        }
        
        if let last = seats.last {
            for i in blankSeats.firstIndex(of: last)!..<blankSeats.count {
                if min((blankSeats[i] - last), blankSeats.count - blankSeats[i]) > maxDistance && !seats.contains(blankSeats[i]){
                    maxDistance = min((blankSeats[i] - last), seats[seats.count-1] - blankSeats[i])
                    tempStack[blankSeats[i]] = maxDistance
                }
            }
        }
        
        for (key, value) in tempStack {
            if value == maxDistance {
                tempArray.append(key)
            }
        }
        
        if let seat = tempArray.min() {
            seatNumber = seat
        }
        
        seats.append(seatNumber)
        seats.sort()
        
        return seatNumber
    }
    
    func leave(_ p: Int) {
        if let seat = seats.firstIndex(of: p) {
            seats.remove(at: seat)
            seats.sort()
        }
    }
}
