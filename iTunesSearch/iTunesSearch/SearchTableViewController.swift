//
//  SearchTableViewController.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate, NetworkingManagerDelegate {

    var searchResults = Array<SearchResult>()
    let networkingManager = NetworkingManager()
    
    var searchString = ""
    var entity: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkingManager.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(entitySelected(notification:)), name: NSNotification.Name(rawValue: "EntitySelectedNotification"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        
        let popover = storyboard?.instantiateViewController(withIdentifier: "EntityNavController")
        
        popover?.modalPresentationStyle = .popover
        
        if let presentation = popover?.popoverPresentationController {
            presentation.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(popover!, animated: true, completion: nil)
        
    }
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell

        let searchResult = searchResults[indexPath.row]
        
        cell.lblTitle.text = searchResult.trackName ?? "NA"
        cell.lblTrackKind.text = searchResult.kind ?? "NA"
        cell.lblTrackPrice.text = "\(searchResult.trackPrice ?? 0)"

        let url = URL(string: searchResult.artworkUrl60 ?? "")
        
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                
                if data != nil {
                    let artwork = UIImage(data: data!)
                    
                    DispatchQueue.main.async {
                        cell.artWork.image = artwork
                    }
                }
                
            }).resume()
        }
        
        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let indexPath = self.tableView.indexPathForSelectedRow
        if indexPath != nil {
            let searchDetailViewController = segue.destination as! SearchDetailViewController
            let searchResult = searchResults[indexPath!.row]
            
            searchDetailViewController.trackNameString = searchResult.trackName ?? "NA"
            searchDetailViewController.descriptionString = searchResult.description ?? "NA"
            
            
            searchDetailViewController.artWorkUrl = searchResult.artworkUrl60 ?? ""
        }
    }
 
    
    
    //MARK: - SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil {
            searchString = searchBar.text!
            searchResults.removeAll()
            networkingManager.search(searchTerm: searchString, searchEntity: entity)
        }
    }
    
    //MARK:- Networking Manager Delegate
    func networkingManagerDidGetSearchResult(networkingManager: NetworkingManager, searchResult: SearchResult) {
        self.searchResults.append(searchResult)
        self.tableView.reloadData()
    }
    
    func networkingManagerDidFinishSearching(networkingManager: NetworkingManager) {
        self.tableView.reloadData()
    }
    
    @objc func entitySelected(notification: NSNotification) {
        
        if let selectedEntity = notification.object{
            entity = selectedEntity as! String
            searchResults.removeAll()
            networkingManager.search(searchTerm: searchString, searchEntity: entity)
        }
    }

}
