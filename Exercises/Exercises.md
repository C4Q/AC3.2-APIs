# Exercise Solutions
---

> These are just one possible solution to answering the exercises.

### Coding the `APIManager`


```swift
class APIManager {
    private static let randomAPIEndpoint: URL = URL(string: "https://randomuser.me/api/")!
    
    static let shared: APIManager = APIManager()
    private init() {}
    
    func getRandomUserData(completion: @escaping ((Data?)->Void)) {
        
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: APIManager.randomAPIEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered in API request: \(String(describing: error?.localizedDescription))")
            }
            
            if data != nil {
                print("Data returned in response")
                completion(data)
            }
            
            }.resume()
    }
}
```

### Parsing out a `User`

> Note: You should be very cautious in force-unwrapping values. It is done here for brevity of code

```swift
APIManager.shared.getRandomUserData { (data: Data?) in
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]

                    if let resultsJSON = json["results"] as? [[String : AnyObject]] {
                        for results in resultsJSON {
                            let name: [String : String] = results["name"] as! [String : String]
                            let first: String = name["first"]!
                            let last: String = name["last"]!
                            
                            let login: [String : String] = results["login"] as! [String : String]
                            let user: String = login["username"]!
                            
                            let pictures: [String : String] = results["picture"] as! [String : String]
                            let thumb: String = pictures["thumbnail"]!
                            
                            let email: String = results["email"] as! String
                            
                            let newUser = User(firstName: first, lastName: last, username: user, emailAddress: email, thumbnailURL: thumb)
                            print(newUser.firstName, newUser.lastName)
                            
                        }
                    }
                }
                catch {
                    print("Error Occurred: \(error.localizedDescription)")
                }
                
            }
        }
```

### Exercises

#### 1. Refactor

```swift
// in User.swift
	init(json: [String : AnyObject]) {
        
        let name: [String : String] = json["name"] as! [String : String]
        let first: String = name["first"]!
        let last: String = name["last"]!

        let login: [String : String] = json["login"] as! [String : String]
        let username: String = login["username"]!
        
        let pictures: [String : String] = json["picture"] as! [String : String]
        let thumbnail: String = pictures["thumbnail"]!
        
        let email: String = json["email"] as! String
        
        self.init(firstName: first, lastName: last, username: username, emailAddress: email, thumbnailURL: thumbnail)
    }


// updated viewDidLoad of UserTableViewController
		APIManager.shared.getRandomUserData { (data: Data?) in
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]

                    if let resultsJSON = json["results"] as? [[String : AnyObject]] {
                        for results in resultsJSON {
                            let newUser = User(json: results)
                            print(newUser.firstName, newUser.lastName)
                        }
                    }
                }
                catch {
                    print("Error Occurred: \(error.localizedDescription)")
                }
                
            }
        }

```

#### 2. Displaying a User

```swift
class UsersTableViewController: UITableViewController {
    private static let UserTableViewCellIdentifier: String = "UserTableViewCellIdentifier"
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.getRandomUserData { (data: Data?) in
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]

                    if let resultsJSON = json["results"] as? [[String : AnyObject]] {
                        for results in resultsJSON {
                            let newUser = User(json: results)
            
                            self.users.append(newUser)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                catch {
                    print("Error Occurred: \(error.localizedDescription)")
                }
                
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewController.UserTableViewCellIdentifier, for: indexPath)

        // this is to make sure that there exists a User to a corresponding row
        // indexPath.row is 0-indexed, so we add one to it 
        guard self.users.count >= indexPath.row + 1 else {
            return cell
        }
        
        let user = self.users[indexPath.row]
        cell.textLabel?.text = "\(user.firstName) \(user.lastName)"
        cell.detailTextLabel?.text = "\(user.username)"
        
        return cell
    }

}

```

#### 3. Pull-to-Refresh

*See `solution` branch if needed. Instructions provided work as described in `README`*

#### 4. Advanced - Failable Init

> Note: This advanced solution makes liberal use of `guard` to break up parsing into chunks. In this manner, we could have more descriptive error messages printed depending on which portion of the parsing failed

```swift
	init?(failableJSON json: [String : AnyObject]) {
        // parse out name
        guard
            let name: [String : String] = json["name"] as? [String : String],
            let first: String = name["first"],
            let last: String = name["last"]
            else {
                return nil
        }
        
        // parse out user name
        guard
            let login: [String : String] = json["login"] as? [String : String],
            let username: String = login["username"]
            else {
                return nil
        }
        
        // parse out image URLs
        guard
            let pictures: [String : String] = json["picture"] as? [String : String],
            let thumbnail: String = pictures["thumbnail"]
            else {
                return nil
        }
        
        // the rest
        guard let email: String = json["email"] as? String else {
            return nil
        }
        
        self = User(firstName: first,
                    lastName: last,
                    username: username,
                    emailAddress: email,
                    thumbnailURL: thumbnail)
        
    }
```
