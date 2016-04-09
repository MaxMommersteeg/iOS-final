import UIKit

protocol PersonSelectionDelegate: class {
    func personSelected(newPerson: Person)
}

class MasterViewController: UITableViewController {
    var persons = [Person]()
    var delegate: PersonSelectionDelegate?
    
    @IBOutlet weak var personTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL: NSURL = NSURL(string: "http://www.maxmommersteeg.nl/users.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            // Only check
            if (statusCode == 200) {
                do {
                    let data = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    for person in data as! [Dictionary<String, AnyObject>] {
                        let p = Person(jsonData: person)
                        self.persons.append(p)
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        print("Update Person Table")
                        self.personTableView.reloadData()
                    })
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        task.resume()
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
        self.delegate?.personSelected(selectedPerson)
        
        if let detailViewController = self.delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
    }
    
}
