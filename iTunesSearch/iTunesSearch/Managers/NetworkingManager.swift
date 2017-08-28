//
//  NetworkingManager.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import Foundation


protocol NetworkingManagerDelegate {
    
    func networkingManagerDidGetSearchResult(networkingManager: NetworkingManager, searchResult: SearchResult)
    func networkingManagerDidFinishSearching(networkingManager: NetworkingManager)
    
}



class NetworkingManager: ParsingManagerDelegate {
    
    
    let parsingManager = ParsingManager()
    var delegate: NetworkingManagerDelegate?
    
    func constructURLString(searchTerm: String?, searchEntity: String?) -> String {
        
        var apiUrl = "https://itunes.apple.com/search?"
        
        if let term = searchTerm{
            apiUrl += "term=\(term)"
        }
        
        if let entity = searchEntity{
            apiUrl += "&entity=\(entity)"
        }
        
        return apiUrl
    }
    
    func search(searchTerm: String?, searchEntity: String?) {
        
        let urlString = constructURLString(searchTerm: searchTerm, searchEntity: searchEntity)
        let url = URL(string: urlString)
        
        if url != nil {
            
            let request = URLRequest(url: url!)
            
            let session = URLSession.shared
            session.dataTask(with: request, completionHandler:{
                (data, response, error) in
                
                if data != nil {
                    self.parsingManager.delegate = self
                    self.parsingManager.parseData(data: data!)
                } else {
                    print("No Data recieved")
                }
            }).resume()
            
            
        } else {
            print("Could not create URL from \(urlString)")
        }

    }
    
    //MARK:- Parsing Manager Delegate
    func parsingManagerDidParseSearchResult(parsingManager: ParsingManager, searchResult: SearchResult) {
        delegate?.networkingManagerDidGetSearchResult(networkingManager: self, searchResult: searchResult)
    }
    
    func parsingManagerDidFinishParsing(parsingManager: ParsingManager) {
       delegate?.networkingManagerDidFinishSearching(networkingManager: self)
    }
    
}
