import Foundation

class Person {
    
    var personId: Int
    var firstName: String
    var middleName: String
    var lastName: String
    var birthDate: String
    var currentLocation: Location
    
    init(jsonData: AnyObject) {
        let json = JSON(jsonData)
        
        self.personId = json["personId"].int!
        self.firstName = json["firstName"].string!
        self.middleName = json["middleName"].string!
        self.lastName = json["lastName"].string!
        self.birthDate = json["birthDate"].string!
        print(json["currentLocation"])
        
        let lat = json["currentLocation"]["latitude"].double!
        let lon = json["currentLocation"]["longitude"].double!
        let city = json["currentLocation"]["city"].string!
        
        self.currentLocation = Location(latitude: lat, longitude: lon, city: city)
    }
    
    func getFullName() -> String! {
        if((self.middleName ?? "").isEmpty) {
            return "\(self.firstName) \(self.lastName)"
        }
        return "\(self.firstName) \(self.middleName) \(self.lastName)"
    }
}
