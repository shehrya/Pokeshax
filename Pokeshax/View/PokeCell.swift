//
//  PokeCell.swift
//  Pokeshax
//
//  Created by Shehryar Khan on 03.10.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var Pokeshax: pokeshax!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokeshax:pokeshax) {
        self.Pokeshax = pokeshax
        nameLbl.text = self.Pokeshax.name.capitalized
        thumbImg.image = UIImage(named: "\(self.Pokeshax.pokeshaxId)")
        
    }
    
}
