import UIKit

protocol PersonSelectionDelegate: class {
    func personSelected(newPerson: Person)
}

class MasterViewController: UITableViewController, UIAlertViewDelegate {
    var persons = [Person]()
    var delegate: PersonSelectionDelegate?
    
    @IBOutlet weak var personTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if !Connectivity.isConnectedToNetwork() {
            // Create the alert controller
            let alertController = UIAlertController(title: "No internet connection", message: "Make sure you have working internet connection", preferredStyle: .Alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                self.viewDidAppear(true)
                return
            }
            
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        print("STIL GOT HERE")
        let requestURL: NSURL = NSURL(string: Config.apiBaseUrl)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            // Only check for 200 status
            if (statusCode == 200) {
                do {
                    // Return a JSON object with data
                    let data = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    // Iterate over given data
                    self.persons = []
                    for person in data as! [Dictionary<String, AnyObject>] {
                        // add new person to persons list
                        self.persons.append(Person(jsonData: person))
                    }
                    // Update personTableView async
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
        
        // Get selected person
        let person = self.persons[indexPath.row]
        
        // Set default cell text
        var cellText = person.getFullName()
        // Get NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        // Append alias to cellText if we have an alias for this person
        if let alias = defaults.stringForKey("\(Config.aliasPreferenceKey)\(person.personId)") {
            cellText = "\(cellText) | \(alias)"
        }
        // set LabelText
        cell.textLabel?.text = cellText
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Pass selected person using a delegate to DetailViewController
        let selectedPerson = self.persons[indexPath.row]
        self.delegate?.personSelected(selectedPerson)        
        if let detailViewController = self.delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
    }
    
}
