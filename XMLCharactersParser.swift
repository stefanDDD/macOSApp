//
//  XMLCharactersParser.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation

class XMLCharactersParser: NSObject, XMLParserDelegate{
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    var cName, cAlias, cRole, cActor, cQuote, cImage, cUrl: String!
    
    var elementID = -1
    var passData = false
    var charactersData = [Character]()
    var characterData: Character!
    
    var parser: XMLParser!
    let tags = ["name", "alias", "role", "actor", "quote", "image", "url"]
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if tags.contains(elementName){
            passData = true
            elementID = tags.firstIndex(of: elementName)!
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch elementID{
        case 0: cName = string
        case 1: cAlias = string
        case 2: cRole = string
        case 3: cActor = string
        case 4: cQuote = string
        case 5: cImage = string
        case 6: cUrl = string
        default: break
        
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        passData = false
        elementID = -1
        if elementName == "character"{
            characterData = Character(name: cName, alias: cAlias, role: cRole, actor: cActor, quote: cQuote, image: cImage, url: cUrl)
            charactersData.append(characterData)
        }
        
    }
    
    func parsing(){
        let bundleUrl = Bundle.main.bundleURL
        let fileUrl = URL(string: self.name, relativeTo: bundleUrl)
        parser = XMLParser(contentsOf: fileUrl!)
        
        parser.delegate = self
        parser.parse()
        
    }

}
