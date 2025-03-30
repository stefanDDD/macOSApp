//
//  Characters.swift
//  BreakingBad
//
//  Created by stefan on 29.03.2025.
//

import Foundation

class Characters{
    var charactersData: [Character]!
    
    init(name: String){
        let xmlParser = XMLCharactersParser(name: name)
        xmlParser.parsing()
        self.charactersData = xmlParser.charactersData
        
    }
    
    func getCharacter(index:Int)->Character{
        return self.charactersData[index]
    }
    
    func getCount()->Int{
        return self.charactersData.count
    }
}
