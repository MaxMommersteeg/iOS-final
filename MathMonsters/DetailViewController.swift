/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var aliasTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var completeAliasPreferenceKey: String = ""
    
    var person: Person? {
        didSet (newPerson) {
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        if let p = person {
            completeAliasPreferenceKey = "\(Config.aliasPreferenceKey)\(p.personId)"
            print(completeAliasPreferenceKey)

            nameLabel?.text = p.getFullName()
            latitudeLabel?.text = "\(p.currentLocation.latitude)"
            longitudeLabel?.text = "\(p.currentLocation.longitude)"
            cityLabel?.text = p.currentLocation.city
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let alias = defaults.stringForKey(completeAliasPreferenceKey) {
                aliasTextField?.text = alias
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed() {
        let alias = aliasTextField.text!
        if alias.isEmpty  {
            print("Failed saving Alias")
            // refreshUI to reset Alias
            refreshUI()
            return
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(alias, forKey: completeAliasPreferenceKey)
        defaults.synchronize()
        print("Saved Alias")
    }
}

extension DetailViewController: PersonSelectionDelegate {
    func personSelected(newPerson: Person) {
        person = newPerson
    }
}
