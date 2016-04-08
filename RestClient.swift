import Foundation

typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONArray = Array<AnyObject>

class RestClient: NSObject, NSURLConnectionDataDelegate {
    
    enum Path {
        case GET_PERSONS
    }
    
    typealias APICallback = ((AnyObject?, NSError?) -> ())
    let responseData = NSMutableData()
    var statusCode:Int = -1
    var callback: APICallback! = nil
    var path: Path! = nil
    
    func getPersons(callback: APICallback) {
        let url = "http://www.maxmommersteeg/users.json"
        makeHTTPGetRequest(Path.GET_PERSONS, callback: callback, url: url)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        let httpResponse = response as! NSHTTPURLResponse
        statusCode = httpResponse.statusCode
        switch (httpResponse.statusCode) {
        case 201, 200, 401:
            self.responseData.length = 0
        default:
            print("Not accepted")
        }
    }
    
    // private
    func makeHTTPGetRequest(path: Path, callback: APICallback, url: NSString) {
        self.path = path
        self.callback = callback
        let request = NSURLRequest(URL: NSURL(string: url as String)!)
        let conn = NSURLConnection(request: request, delegate:self)
        if (conn == nil) {
            callback(nil, nil)
        }
    }
}