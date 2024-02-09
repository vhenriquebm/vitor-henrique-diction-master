//
//  CustomTableViewCell.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    private func configureViews() {
        definitionLabel.font = UIFont.sf_pro_rounded_bold(size: 16)
        exampleLabel.font = UIFont.sf_pro_rounded_regular(size: 16)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with response: SearchWordResponse, index: Int) {
        
        let newIndex = index + 1
        
        self.definitionLabel.text = "\(newIndex)) \(response.meanings.first?.definitions.first?.definition ?? "" )"
        
        if let example = response.meanings.first?.definitions.first?.example {
            self.exampleLabel.text = "• \(example)"
        }
    }
}
