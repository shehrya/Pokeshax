//
//  PokeshaxDetailVC.swift
//  Pokeshax
//
//  Created by Shehryar Khan on 08.10.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import UIKit

class PokeshaxDetailVC: UIViewController {
    
    var pokeshax: pokeshax!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var attackLbl: UILabel!
    
    @IBOutlet var pekeshaxLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var currentEvoImg: UIImageView!
    @IBOutlet var nextEvoImg: UIImageView!
    @IBOutlet var evoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokeshax.name.capitalized
        let img = UIImage(named: "\(pokeshax.pokeshaxId)")
        mainImg.image = img
        currentEvoImg.image = img
        pekeshaxLbl.text = "\(pokeshax.pokeshaxId)"
        pokeshax.downloadPokeshaxDetail {
            print("we are here")
            // Whatever we write will only be called after the network call is compelte!
            self.updateUI()
        }
    }

    func updateUI() {
        
        attackLbl.text = pokeshax.attack
        defenseLbl.text = pokeshax.defense
        heightLbl.text = pokeshax.height
        weightLbl.text = pokeshax.weight
        typeLbl.text = pokeshax.type
        descriptionLbl.text = pokeshax.description
        
//        if pokeshax.nextEvolutionId == "" {
//            
//            evoLbl.text = "No Evolutions"
//            nextEvoImg.isHidden = true
//            
//        } else {
//            
//            nextEvoImg.isHidden = false
//            nextEvoImg.image = UIImage(named: pokeshax.nextEvolutionId)
//            let str = "Next Evolution: \(pokeshax.nextEvolutionName) - LVL \(pokeshax.nextEvolutionLevel)"
//            evoLbl.text = str
//        }
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
}
