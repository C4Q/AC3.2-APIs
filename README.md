# AC3.2-APIs: Intro

---
### Readings

1. [What is an API? - Mulesoft via Youtube](https://www.youtube.com/watch?v=s7wmiS2mSXY) - This is a very quick and helpful video (must watch)
  2. [REST API Concepts - Webconcepts via Youtube](https://www.youtube.com/watch?v=7YcW25PHnAA) - This is a slightly longer, practical look at REST API's (must watch)
  3. [What is an API in English, Please](https://medium.freecodecamp.com/what-is-an-api-in-english-please-b880a3214a82#.jxvvtoarm) - If you understood the two videos above this link, you don't really have to read this article
  4. [Basics of Pull to Refresh - Andrew Bancroft](https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/)

### Resources:

1. [Postman](https://www.getpostman.com/) - Free tool to test API requests
2. [Random User API](https://randomuser.me/) - Simple API useful for simple user creation
3. [Google Geocoding API: Intro](https://developers.google.com/maps/documentation/geocoding/intro)

### Definitions:

1. **API**: Application program interface (API) is a set of routines, protocols, and tools for building software applications. An API specifies how software components should interact. [Webopedia](http://www.webopedia.com/TERM/A/API.html)
2. **RESTful API**: A RESTful API is an application program interface (API) that uses HTTP requests to GET, PUT, POST and DELETE data. [Quora](https://www.quora.com/What-is-a-REST-API/answer/Ruben-Verborgh?srid=dpgi)
3. **HTTP, Request/Response**: Whenever your web browser fetches a file (a page, a picture, etc) from a web server, it does so using HTTP - that's "Hypertext Transfer Protocol".  HTTP is a request/response protocol, which means your computer sends a request for some file (e.g. "Get me the file 'home.html'"), and the web server sends back a response ("Here's the file", followed by the file itself). [RVE](http://rve.org.uk/dumprequest)

---
### 0. Objectives

1. Introduce the concept of web-based APIs along with examples of popular webservices
2. Frame using APIs as being able to develop amazing apps that would not be possible on your own or without large development teams
4. Further dive into JSON by exploring Google Geocode responses
5. Explore API documentation to understand how an API defines its inputs and outputs
6. Introduce Postman as a utility for quickly testing APIs
7. Begin working on iFacesterGram

---
### 1. API's, What Are They? 

**How many weather apps do you think there are in the app store?**

I’d wager there must be *thousands* at the least. Some of those apps have entire teams dedicated to building the app, while some of them are a single person that did it as a weekend project. And despite the great variety of apps made, all of their data is (relatively) consistent.
 
But where are those developer teams, large and small, getting their weather data? Here you have 1000’s of different apps and they all have the same data set. How are they able to all present the same information?
 
The answer: they get their data from an __API__ (Application Programming Interface)

An API is a digital middleman - delivering data from some service as long as you ask for it in the right way. In this case, all of these weather apps are asking a weather-related API for data on the weather. In a broad sense **an API is a standard set of requests and responses that allows software to communicate.** And it is not just iOS apps that use API's: websites use them, Android devices use them, and computers use them. 
 
> Note: When iOS developers talk about API's we usually mean one of two things: 
> 1. Any library used to do a specific function in an app (for example UIKit could be considered a native iOS API for UI elements)
> 2. A REST API that is used to communicate with some service on the web, (like a weather API!)
 
----
#### Why do APIs matter
 
__They allow you to develop software faster!__ The existance of APIs let you perform a variety of tasks that just take way too long to write out yourself. Can you imagine having to write out your own custom `JSONSerialization` function for every app you create?
 
In the context of web-based `REST API`s, they are how your app is going to talk to the world. There are hundreds of services out there that you might want to develop an app around

- A messaging app might use [Firebase](https://firebase.google.com/) for realtime communication
- A social media app that aggregates your top tweets will make use of the Twitter API ([Fabric](https://get.fabric.io/))
- A cloud-based, file storage app may decide to use the [Dropbox API](https://www.dropbox.com/developers) for storing, retrieving and editing files
- Perhaps you have a new take on location-based B2B services, and will make use of the [Foursquare API](https://developer.foursquare.com/) to load local business data
- Have a way to track pokemon in PokemonGo? Seems like a good place to use the [Google Maps API](https://developers.google.com/maps/) to display live GPS data
 
Apps can even use multiple `REST`ful API's to perform complex tasks and create novel experiences for their users. With enough practice and skill, you can even develop your own APIs that other developers will use. 
 
---
#### JSON (A deeper dive)

Since there is a wide possibility of devices that use API's and many differnt APIs providing unique services, there needs to be a standard for how they can all communicate effectively. The most common format in use is `JSON` (Javascript Object Notation). `JSON` defines how the data returned from an API will be formatted, and at its core is really just a dictionary. You may even often hear json referred to as a "json dictionary." Though, the structure and content that json dictionary's key/value pairs is up to the API. This is what we mean when we say that __"an API defines it's data response"__.
 
To get a sense of what JSON looks like, and how its used, let's go ahead and navigate to: http://maps.googleapis.com/maps/api/geocode/json
 
![Response JSON for maps API](./Images/googleMapsAPI.png)

Not an exciting result, but there's way more here than you might initially expect. For one, we see that the page is essentially a dictionary with three keys, `error_message`, `results`, and `status`. But why those three keys, and how can we know to expect them? And moreover, how did we know to go to that URL for this example?
 
----
#### API Documentation

As mentioned before, API's define a standard for how software can communicate. Meaning that they define the kinds of *requests* that can be made to them, along with the *response* they will return. `JSON` defines the structure the request/response, but its up to the API as to what should be included in a request and what could be included in the response. 
 
All APIs will provide documentation on exactly what they expect in a request, and what they will return in a response. For example, take a look at this excerpt from the google geocoding API docs:

**Error Message Documentation**
![Error message documentation](./Images/error_message.png)

**Status Message Documentation**
![Status Codes documentation](./Images/status_codes.png)
  
> If we check out https://developers.google.com/maps/documentation/geocoding/intro we'll be able to see every possible request and response that can be made by the API.

----
#### Trying out an API

Looking at our previous request:

`http://maps.googleapis.com/maps/api/geocode/json`

... we see we're getting back an `error`. And judging by the APIs documentation, this is expected. Fortunately in the event of a bad request to an API, it is possible that the API returns a response with helpful error messages regarding what was bad about the request. In this case, we made an `invalid request` because we didn't include some additional information it was expecting to get along with the request. This additional information passed along with a request are called **parameters**. Parameters specify additional constraints on the requests we make. They may limit the data requested by filtering it by some criteria. 
 
<details>
  <summary> Example 1: Adding An Address to the API call </summary>
<br>
Go back to your prior request and add the "address" key along with a "value" of the address of C4Q
For example: http://maps.googleapis.com/maps/api/geocode/json?address=%2243-06%2045th%20Street%22
<br>
Note: Parameters appear following a single ? and spaces are replaced by %20 for the actual request, but the google api will understand the request the exact same way as if you put in "43-06 45th Street"
<br>
<br>
</details>

<details>
  <summary> Example 2: Compare valid request with invalid one </summary>
  <br>

  <ol> 
    <li>Notice how we get new data passed along with a valid request? 
    <li>Bring up the API documentation page again and compare the keys with what the API states will be returned
    <li>All of these results are listed in the API's documentation for this kind of response, so we will always know what to expect
  </ol>

  <br>
</details>

Plugging away in a web browser is a lightweight way to test out an API, but we can get some real power by using some utilities specifically meant for making API requests.
 
 -----
### 2. Working With Requests

#### [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en)

Try this out: 

1. Open Postman and enter the prior googleAPI request (http://maps.googleapis.com/maps/api/geocode/json)
2. Add in "address" as a parameter along with some value
3. If this worked, try some other addresses

![Google Maps request in Postman](./Images/postman_request_googlempas.png)

```json
{
  "results": [
    {
      "address_components": [
        {
          "long_name": "The Falchi Building",
          "short_name": "The Falchi Building",
          "types": [
            "premise"
          ]
        },
        {
          "long_name": "31-00",
          "short_name": "31-00",
          "types": [
            "street_number"
          ]
        },
        
        // ... much more json...
        
       ]
     }
   ]  
 }
```


---
#### Testing API Requests and [myJson](http://myjson.com/)

Think back to the `URLSession` demo for a moment -- I was calling our hosted `json` an "API endpoint". And in some ways it does meet the requirement: we could send a request to the myjson `URL` and we would receive a formatted `json` response. And at its core, an API is just a way to request and receive info based on a set of parameters. Though, in practice API's are a bit more detailed than simply plugging in a `URL` endpoint and parsing out any data that gets returned.

Making test requests is a big part of development. So much so that a fellow developer created the myjson site after he became annoyed that there were no simple ways of hosting json. They, like the majority of developers, needed an easy way to test network requests and parsing json. Making web requests to service APIs, along with parsing the returned response, are going to be a common task in most apps. Think about all the apps you use that you can log in with Facebook! That Facebook authentication flow is its own API that developers have integrated into their app.

Fortunately, since working with API's is such a ubiquoitous thing for all developers there are quite a few resources and tools available to make development as smooth as possible. Some of the most important tools are those that let us test out API requests to verify that our inputs and outputs are correct and what we expect. 

---
#### The [Random User API](https://randomuser.me/)
One of my favorite APIs to use for quick testing of creating user accounts is the [Random User API](https://randomuser.me/). 
Many of the APIs discussed prior require some sort of authentication method, but fortunately the Random User API doesn't require it making it quite easy to hit the ground rounning with testing with it. 

---
### 3. iFacesterGram: Concept to Demo

Today is the beginning of the rest of everyone's social media account lives: we're going to start creating a brand new social platform called, iFacesterGram. We've lined up some seed money from an anonymous [angel investor](http://www.investopedia.com/terms/a/angelinvestor.asp) who attended our idea pitch event last week. Now it's time to get our little product off the ground. Our PM team wants us first to showcase what a list of users in the app would look like -- a sort of iFacesterGram "friends list." To complete this first assignment, we're going to need to accomplish a few things:

1. Set up a basic UI to display our list of users
2. Design a way to perform network calls to an API backend to get user data. We're going to have to use some mock data for now, but we want robust sets of data
3. Create our `User` model and decide how to parse data
4. Populate our list of users
5. Implement a pull-to-refresh feature

#### Design & Engineering
<details>
  <summary> Q1: What UI element should we use to display the list of users? </summary>
  <br>
  <em>UITableviewController</em>
  <br>
  (Possibly) <em>A custom UITableviewCell</em>
  <br>
</details>
<details>
  <summary> Q2: Based on what we know, what architetural design could we use for a network manager? </summary>
  <br>
  <em>Singleton</em>
  <br>
  <br>
</details>
<details>
  <summary> Q3: What class in the Swift Library can we use to parse raw data from URLRequests?</summary>
  <br>
  <em>JSONSerialization</em>
  <br>
  <br>
</details>
<details>
  <summary> Q4: What will we need to do to ensure that our list of users updates as soon as our network request finishes?</summary>
  <br>
  Wrapping up UI updating in a <code>DispatchQueue.main.async</code> block
  <br>
  <br>
</details>

---
#### Project Orientation

We begin this project with a few things already set up for us (read through and get familiar with the project):

1. Three files already added:
- `User.swift` : `struct` for our model
- `UsersTableViewController`: our primary view controller to display `Users`
- `APIManager` : our singleton to manage network requests
2. Storyboard has the following:
- An instance of `UsersTableViewController` with an embedded `UINavigationController`, set as the initial view controller
- A single prototype `UITableViewCell` with the identifier `UserTableViewCellIdentifier`
 
<details>
 <summary> Q1: What does <code>private static let</code> indicate about our <code>UserTableViewCellIdentifier</code>?</summary>
  <br>
  <ol>
  
   <li>Private indicates that the constant is only available to be used inside of the UsersTableViewController class</li>
   <li>Static indicates that this constant belongs to the UsersTableViewController class and not any 1 instance</li>
   <li>let indicates that the value does not change</li>
  
  </ol>
  <br>
 </details>

```swift
 // Describe what these three keywords indicate about UserTableViewCellIdentifier
    private static let UserTableViewCellIdentifier: String = "UserTableViewCellIdentifier"
```

---
#### Designing the `User` model

Let's take a look at the data that would could potentially be working with. In Postman, set your URL to the random user API endpoint (`https://randomuser.me/api/`) and hit "send" to make a request. Look at the `json` that is returned.. what should we use to populate our user data? 

<details>
<summary> Q: What data should our social media app keep on a user for display?</summary>
 <br>
 There really is no wrong answer to thing, and it all depends on the design we'd like for our app. We're going to start off using:
<ul>
 <li>first 
 <li>last
 <li>username
 <li>email
 <li>thumbnail 
</ul>
<br><br>
</details>

Now, let's fill out the `User` model using these properties

```swift 
internal struct User {
    internal let firstName: String
    internal let lastName: String
    internal let username: String
    internal let emailAddress: String
    internal let thumbnailURL: String
}
```

---
#### Coding the `APIManager`

For right now, our API manager just needs to be able to do a few things: 

1. Send a request to the random user API endpoint
2. Do some basic error checking
3. Use a callback closure to handle the returned `Data`


#### Instructions

Using what you know, and the previous lessons, design the `APIManager` to contain the following:

1. Singleton-based manager class
2. Write the function `getRandomUserData(completion: ((Data?)->Void))`. 
  - Make sure you use the `URL` for the RandomUser API endpoint for this
3. Test this function by calling it inside of `viewDidLoad` of `UsersTableViewController`
  - Make sure you're getting data (don't parse it just yet)
  - Make sure you're handling an error by printing its details out to console.

```swift
// in viewDidLoad
APIManager.manager.getRandomUserData { (data) in
  if data != nil {
    print("Data returned!")
  }
}
```

<details>
<summary> Q1: As written in step 2 of the instructions, the `getRandomUserData` definition is missing one thing, what is it? </summary>
<br>
It needs the <code>@escaping</code> key word for the callback closure
<br>
<br>
</details>

<details>
<summary> Design Hints: Singletons </summary>
<br>
A singleton needs two things: a class-level, unchanging constant named something like <code>shared/manager</code>, and a private default initializer.
<br><br>
Its quite helpful to define unchanging properties (such as the URL for the api) as a <code>static let</code>
<br><br>
</details>

---
#### Parsing `Data` into `User`

<details>
<summary>Q: What is a unique feature of structs in Swift with regards to their initilization?</summary>
<br>
Structs in Swift give you a "free" initializer based on its properties (as long as you don't write your own).
<br>
</details>

Right now we have available the following initializer for our `User`: 

```swift
  // the parameter names are determined by the name of their property
  let newUser = User.init(first: String, last: String, username: String, emailAddress: String, thumbnailURL: String)
```

Let's first try to work with this initializer inside of the completion handler of our `APIManager` request. We know that we need to convert `Data` into a Swift object by way of `JSONSerialization`, the real question is what should we be typecasting the results of `JSONSerialization`? Remember that `JSONSerialization.jsonObject(with:options:)` returns `Any` and from that `Any` we need to convert to a suitable dictionary type. 

<details>
<summary>Q: How could we determine the dictionary type we should cast to? What did we do in the `NSURL` lesson?</summary>
<br><br>
We determined the dictionary type based on the <code>JSON</code> in our project. The <code>instacats.json</code> file was set up as a <code>[[String:String]]</code>. To determine what we should convert to now, we need to take a look at the response <code>JSON</code> from the RandomUserAPI
<br><br>
</details>
<details>
<summary>Q: What should we typecast to?</summary>
<br><br>
Based on the response from RandomUserAPI, we first need to cast the <Any> object returned from <code>JSONSerialization</code> to <code>[String : AnyObject]</code>. This is because the top level response has 
two key values, <code>results, info</code>, and the value for each of those keys varies. 
<br><br>
</details>

> Try to answer the above questions before looking at the code below 💪

Being sure to wrap up our `JSONSerialization` function in a `do-catch`, we can write:

```swift
// in viewDidLoad
APIManager.manager.getRandomUserData { (data) in
  if data != nil {
    print("Data returned!")

    // 1. JSONSerialization can throw, so it needs to be in this do/catch block
    do {

      // 2. We do a force typecast to [String : AnyObject]. We may as well since we're already in do/catch and 
      //    can handle errors gracefully
      let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
      
      // 3. We're interested in the value of the "results" key, which ends up being an array of dictionary objects each representing a user
      //    a User object
      if let resultsJSON = json["results"] as? [[String : AnyObject]] {
         
        for result in resultsJSON {
          // ...do your parsing here...

          let newUser = User(firstName: first, lastName: last, username: user, emailAddress: email, thumbnailURL: thumb)
          print(newUser.firstName, newUser.lastName)
        }
      }     
    }
    catch {
      // 4. The catch block of a do/catch has access to an error: Error object that represents the error thrown in
      //    the "do" portion of the block. You can call it directly in the scope of the catch block. 
      print("Error Occurred: \(error.localizedDescription)")      
    }

  }
}
```

The above code will get you part of the way to a `User`, but now it's up to you to finish the rest of the parsing. Take a look at the response `JSON` sent from the RandomUserAPI to know what keys and object types you're looking for. Reference the `NSURL` lesson if you're having trouble. 

---
### 4. Exercises

❗❗❗ Be sure to uncomment the unit tests for this project ❗❗❗

#### A. *Refactor*
It's kind of a pain to have to parse out `JSON` inside the body of our request's completion handler: it's a lot of lines of code and it's easy to make a small mistake that results in the parsing to fail. It would be a lot better if we moved this parsing into an initializer for `User`. For this first exercise, create a new `init` on `User` and move the appropriate code out of `UsersTableViewController`:

```swift
User.init(json: [String : AnyObject]) 
```

#### B. Displaying a `User` in the `UITableView`
Once you have the `User` object parsed out, have their data be displayed on the table view. Set the cell's `textLabel` to display a user's first and last name, and the `detailLabel` to display their username

<details>
<summary>Implementation Hints</summary>
<br><br>
You'll have to update <code>numberOfRows, numberOfSections, and cellForRow</code><br><br>

You may want to add a variable to the tableview controller <code>internal var users: [User] = []</code><br><br>

Don't forget to update your UI properly! There's a special closure to bring stuff over from the "other" road into the "main" road
<br><br>
</details>

#### C. *Pull-to-Refresh*
Re-running the project to get different data sets is time consuming. It would be much better if we could just do the standard pull-to-refresh action wouldn't it? Heck yea. 

Select the `UserTableViewController` in storyboard and open it's `Attribute Inspector`. Change the `Refreshing` value from `Disabled` to `Enabled`

In `UserTableViewController` create a new function called `func loadUsers()` and add in all of our `APIManager` code to it. Then in `viewDidLoad` add `self.loadUsers()`

Create a new function called `func refreshRequested(_ sender: UIRefreshControl)` and have it call our `loadUsers()` function

Back in `viewDidLoad`, add `self.refreshControl?.addTarget(self, action: #selector(refreshRequested(_:)), for: .valueChanged)`

Lastly, add `self.refreshControl?.endRefreshing()` inside of `DispatchQueue.main.async`, after you call `self.tableView.reloadData()`

Now run the project and try it out. Every time you pull-to-refresh, your table should get populated with an addition `User`:

![Filling out our Users](./Images/refreshing_fills_table.png)

#### D. Advanced

__Resources for Advanced:__ 
- [Failable Initializers - Swift Blog](https://developer.apple.com/swift/blog/?id=17)
- [Initialization - Swift Programming Language](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
- [Failable Initializers with Default Property Values - Louis Tur via Medium](https://medium.com/@louistur/failable-initializers-with-default-property-values-7b223d2f1b3f)

Add a new, *failable* initializer to `User`. Rather than crashing your app when a request isn't properly parsed `nil` will be returned instead. The function will look like:

`init?(failableJSON json: [String : AnyObject])`

![One Does Not Simply JSON...](./Images/mordor.jpg)
