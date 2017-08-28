//
//  ParsingManager.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import Foundation

protocol ParsingManagerDelegate {
    
    func parsingManagerDidParseSearchResult(parsingManager: ParsingManager, searchResult: SearchResult)
    func parsingManagerDidFinishParsing(parsingManager: ParsingManager)
    
}


class ParsingManager {
    
    let RESULTS_KEY = "results"
    let KIND_KEY = "kind"
    let ARTWORK_KEY = "artworkUrl60"
    let TRACK_NAME_KEY = "trackName"
    let TRACK_PRICE_KEY = "trackPrice"
    let DESCRIPTION_KEY = "longDescription"
    
    var delegate: ParsingManagerDelegate?
    
    func parseData(data: Data) {
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
            let results = response[RESULTS_KEY] as! Array<Dictionary<String, Any>>
            
            var trackName: String?
            var artworkUrl60: String?
            var kind: String?
            var trackPrice: Double?
            var description: String?
            var searchResult: SearchResult?
            
            for result in results {
                
                trackName = result[TRACK_NAME_KEY] as? String
                artworkUrl60 = result[ARTWORK_KEY] as? String
                kind = result[KIND_KEY] as? String
                trackPrice = result[TRACK_PRICE_KEY] as? Double
                description = result[DESCRIPTION_KEY] as? String
                
                searchResult = SearchResult(trackName: trackName, artworkUrl60: artworkUrl60, kind: kind, trackPrice: trackPrice, description: description)
                
                DispatchQueue.main.sync {
                    delegate?.parsingManagerDidParseSearchResult(parsingManager: self, searchResult: searchResult!)
                    searchResult = nil
                }
            }
            
            DispatchQueue.main.sync {
                delegate?.parsingManagerDidFinishParsing(parsingManager: self)
            }
            
        } catch _ {
            
        }
        
    }
    
    
}
