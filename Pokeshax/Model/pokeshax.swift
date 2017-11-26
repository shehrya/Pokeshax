//
//  pokeshax.swift
//  Pokeshax
//
//  Created by Shehryar Khan on 03.10.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import Foundation
import Alamofire

class pokeshax {
    private var _name: String!
    private var _pokeshaxId: Int!
    private var _description: String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionTxt:String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokeshaxURL:String!
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionTxt == nil {
            
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
  

    
    
    var name: String {
        
        return _name
        
    }
    var pokeshaxId: Int {
        
        return _pokeshaxId
    }
    
    init(name: String, pokeshaxId: Int) {
        self._name = name
        self._pokeshaxId = pokeshaxId
        self._pokeshaxURL = "\(URL_BASE)\(URL_POKESHAX)\(self.pokeshaxId)/"
    }
    func downloadPokeshaxDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokeshaxURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? Int {
                    
                    self._weight = "\(weight)"
                }
                if let height = dict["height"] as? Int {
                    
                    self._height = "\(height)"
                }
                
                if let attack = dict["base_experience"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["is_default"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["forms"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    print(self._type)
                    
                } else {
                    
                    self._type = ""
                }
                if let descArr = dict["forms"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let url = descArr[0]["url"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["is_battle_only"] as? Bool {
                                    
//                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
//
//                                    self._description = description
                                    print(description)
                                }
                            }
                            completed()
                        })
                        
                    }
                    
                }else {
                    
                    self._description = "some"
                }
            }
            completed()
            
            }
    }
    
    
}
