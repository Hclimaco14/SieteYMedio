//
//  CartaCellCollectionViewCell.swift
//  SieteYMedio
//
//  Created by Hector Climaco on 12/09/22.
//

import UIKit

class CartaCell: UICollectionViewCell {
    
    public static let  identifier = "CartaCell"
    
    @IBOutlet weak var valueUp: UILabel!
    @IBOutlet weak var valueDown: UILabel!
    @IBOutlet weak var iconType: UIImageView!
    
    var carta: Carta! {
        didSet {
            self.updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func updateView() {
        DispatchQueue.main.async {
            self.contentView.clipsToBounds = true
            self.contentView.layer.cornerRadius = 10
            self.contentView.layer.borderWidth = 1
            
            self.valueUp.text = String(self.carta.valor)
            self.valueDown.text = String(self.carta.valor)
            self.iconType.image = UIImage(named: self.carta.type.rawValue)
        }
    }

}
