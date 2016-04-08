import UIKit

protocol MonsterSelectionDelegate: class {
  func monsterSelected(newPerson: Person)
}

class MasterViewController: UITableViewController {
  var persons = [Person]()
  weak var delegate: MonsterSelectionDelegate?

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!

    self.persons.append(Person(personId:0, firstName:"Max", middleName:"", lastName:"Mommersteeg",
        birthDate:"1994-02-01", currentLocation: Location(latitude: 51.690686, longitude: 5.178211, city: "Nieuwkuijk")))
    
    self.persons.append(Person(personId:0, firstName:"Anouk", middleName:"", lastName:"Mommersteeg",
        birthDate:"1994-02-01", currentLocation: Location(latitude: 51.690686, longitude: 5.178211, city: "Nieuwkuijk")))
    
    self.persons.append(Person(personId:0, firstName:"Tim", middleName:"", lastName:"Mommersteeg",
        birthDate:"1994-02-01", currentLocation: Location(latitude: 51.690686, longitude: 5.178211, city: "Nieuwkuijk")))
    
    let url = NSBundle.mainBundle().URLForResource("persons", withExtension: "json")
    let data = NSData(contentsOfURL: url!)
    
    do {
        let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        if let dictionary = object as? [String: AnyObject] {
            readJSONObject(dictionary)
        }
    } catch {
        // Handle error
    }
  }
    
    func readJSONObject(object: [String: AnyObject]) {
        guard let retrievedPersons = object["persons"] as? [[String: AnyObject]] else { return }
        var personList: Array<Person> = []
        for person in retrievedPersons {
            var pi: Int
            var fn, mn, ln, bd: String
            var l: Location
            
            pi = person["personId"] as! Int
            fn = person["firstName"]! as! String
            mn = person["middleName"] as! String
            ln = person["lastName"] as! String
            bd = person["birthDate"] as! String
            
            l = person["currentLocation"] as! Location
            
            print(l["latitude"])
            
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return self.persons.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

    let person = self.persons[indexPath.row]
    cell.textLabel?.text = person.getFullName()

    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let selectedPerson = self.persons[indexPath.row]
    self.delegate?.monsterSelected(selectedPerson)

    if let detailViewController = self.delegate as? DetailViewController {
      splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
    }
  }

}
