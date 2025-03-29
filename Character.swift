//
//  Character.swift
//  BreakingBad
//
//  Created by stefan on 29.03.2025.
//

import Foundation

class Character {
    var name, alias, role, actor, quote, image, url: String;
    
    init(name: String, alias: String, role: String, actor: String, quote: String, image: String, url: String){
        self.name = name
        self.alias = alias
        self.role = role
        self.actor = actor
        self.quote = quote
        self.image = image
        self.url = url
    }
}
