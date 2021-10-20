//
//  LinksModelController.swift
//  TouchAnAim
//
//  Created by Petro on 20.10.2021.
//

import Foundation

protocol LinksModelControllerDelegate : AnyObject {
    func updateLinksResault(_ linksModel: LinksModel)
}

class LinksModelController {
    var links = LinksClient()
    let link = "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod"
    
    weak var delegate: LinksModelControllerDelegate?
    
    func getLinks() {
        links.getLinks(requestBaseURL: link){(result) in
            DispatchQueue.main.async {
                do {
                    let response = try result.get()
                    let winnerLink = response.winner
                    let loserLink = response.loser
                    let linksModel = LinksModel(winerLink: winnerLink, louserLink: loserLink)
                    
                    self.delegate?.updateLinksResault(linksModel)
                }
                catch {}
            }
        }
    }
}
