//
//  ViewController.swift
//  Project7
//
//  Created by Ishaq Amin on 04/03/2020.
//  Copyright © 2020 Ishaq Amin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Creat the url variable and assign the URL to it.
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0{
            
            let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        //        if let will check if the URL is valid as opposed to force unwrapping it.
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                //        Contents of creates a new Data object which returns content from the URL. Using try? will stop any       faults if the internet connection is down, or slow.
                parse(json: data)
            }
        }
        
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
            //  Creates an instance of JSONDecoder  which is dedicated to converting between JSON and and codable objects
            //
            //  It then calls the decode() method on that decoder, asking it to convert our json data into a Petitions object. This is a throwing call, so we use try? to check whether it worked.
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


