//
//  EntityTableViewController.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class EntityTableViewController: UITableViewController {

    
    let entities = [ "all", "movieArtist", "movie", "podcastAuthor", "podcast", "musicArtist", "musicTrack", "album", "musicVideo", "mix", "musicArtist", "musicVideo", "audiobookAuthor", "audiobook", "shortFilmArtist", "shortFilm", "tvEpisode", "tvSeason", "software", "iPadSoftware", "macSoftware", "ebook", "movie", "album", "allArtist", "podcast", "musicVideo", "mix", "audiobook", "tvSeason", "allTrack"]
    
    var selectedEntity = "all"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EntityTableViewCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntityTableViewCell", for: indexPath)

        cell.textLabel?.text = entities[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = entities[indexPath.row]
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "EntitySelectedNotification"), object: item, userInfo: nil))
        dismiss(animated: true, completion: nil)
    }

}
