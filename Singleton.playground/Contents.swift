import UIKit


class Car {
    var color = "Red"
    
    static let shared = Car()
}


let myCar = Car.shared
myCar.color = "Blue"

//싱글톤 객체에 접근 안한 경우
let yourCar1 = Car()
print(yourCar1.color)

//싱글톤 객체에 접근한 경우
let yourCar2 = Car.shared
print(yourCar2.color)
