//
//  SearchDetailViewController.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    
    
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    
    var artWorkUrl = String()
    var trackNameString = String()
    var descriptionString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trackName.text = trackNameString
        txtDescription.text = descriptionString
        
        
        let url = URL(string: artWorkUrl)
        
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                
                if data != nil {
                    let artwork = UIImage(data: data!)
                    
                    DispatchQueue.main.async {
                        self.artWork.image = artwork
                    }
                }
                
            }).resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
