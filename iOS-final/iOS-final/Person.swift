import Foundation

class Person {
        
    var personId: Int
    var firstName: String
    var middleName: String
    var lastName: String
    var birthDate: String
    var currentLocation: AnyObject
    

  // designated initializer for a Monster
    init(personId: Int, firstName: String, middleName: String, lastName: String,
         birthDate: String, currentLocation: Location) {
        
    self.personId = personId
    self.firstName = firstName
    self.middleName = middleName
    self.lastName = lastName
    self.birthDate = birthDate
    self.currentLocation = currentLocation
  }
    
    init(jsonData: AnyObject) {
        let json = JSON(jsonData)
        self.personId = json["personId"].int!
        self.firstName = json["firstName"].string!
        self.middleName = json["middleName"].string!
        self.lastName = json["lastName"].string!
        self.birthDate = json["birthDate"].string!
        self.currentLocation = json["currentLocation"].arrayObject!
    }
    
    func getFullName() -> String! {
        if((self.middleName ?? "").isEmpty) {
            return "\(self.firstName) \(self.lastName)"
        }
        return "\(self.firstName) \(self.middleName) \(self.lastName)"
    }
}
