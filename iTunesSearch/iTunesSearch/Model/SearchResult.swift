//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import Foundation

class SearchResult {
    
    var trackName: String?
    var artworkUrl60: String?
    var kind: String?
    var trackPrice: Double?
    var description: String?
    
    required init() {
        
    }
    
    init(trackName: String?, artworkUrl60: String?, kind: String?, trackPrice: Double?, description: String?) {
        
        self.trackName = trackName
        self.artworkUrl60 = artworkUrl60
        self.kind = kind
        self.trackPrice = trackPrice
        self.description = description
    }

}
