//
//  MoviesViewController.swift
//  Unit 1 Flixter Part I
//
//  Created by Adriana Meza on 4/13/20.
//  Copyright © 2020 Adriana Meza. All rights reserved.
//

import UIKit
import AlamofireImage
/*
 Recipe to work with a TableView
 
 STEP 1: we added this interfaces to our ViewController UITableViewDataSource, UITableViewDelegate
 to work with a TableView
 
 SETP 2: after adding the to interfaces, the xcode let us know we need to implement to functions.
 Let xcode help you to fix this issue by pressing 'fix'
 
 STEP 3: Assign datasource and delegate
 */
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{  //STEP 1
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]()//this is a propertie and is available during the lifetime of this screen.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //STEP 3
        tableView.dataSource = self
        tableView.delegate = self
        
        print("viewDidLoad")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              
              // TODO: Get the array of movies
              self.movies = dataDictionary["results"] as! [[String:Any]]
              self.tableView.reloadData() //We need this to reload the data after the dictionary is retrieved
              print(dataDictionary)
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    //STEP 2
    
    //This function returns the number of rows to show in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //This function returns a cell for a particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*Instead of creation a UITableViewCell, we are going to reuse the class MovieCell that we created. This class contains all the outlets requiered for a movieCell*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies [indexPath.row]
        let title = movie["title"] as! String// "title" is the key in the JSON
        let synopsis = movie["overview"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w185/"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        /*iOS does not have a default way to load an image. Thus we will use a third party library. We need to install CocoaPods (a pod is a third party library) to add a third party library called AlamofireImage*/
        cell.posterView.af_setImage(withURL: posterUrl)
        
        /*
        //Code to return a simple cell with text only
        let cell = UITableViewCell()
        
        let movie = movies [indexPath.row]
        let title = movie["title"] // "title" is the key in the JSON
        cell.textLabel!.text = title as! String
        */
        
        //Code for learning purposes
        //cell.textLabel!.text = "row: \(indexPath.row)"
        //string syntax to define a place holder. we can put a variable inside the parenthesis
        //why he ! mark this comes for an concept call Swift optionals.
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
