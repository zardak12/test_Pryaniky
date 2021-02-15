//
//  SelectorTableViewCell.swift
//  Pryaniky
//
//  Created by Марк Шнейдерман on 13.02.2021.
//

import UIKit
class SelectorTableViewCell: UITableViewCell {
    
    var myIdLabel = UILabel()
    var myTextLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      //MARK: - Constrains
    func setUp(){
        myIdLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(myIdLabel)
        self.addSubview(myTextLabel)
        self.myIdLabel.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        self.myTextLabel.font = UIFont.systemFont(ofSize: 15,weight: .semibold)
        self.myIdLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 1).isActive = true
        self.myIdLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        self.myTextLabel.topAnchor.constraint(equalTo: myIdLabel.topAnchor,constant: 20).isActive = true
        self.myTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        
    }
    
      //MARK: - Configure with Data
    func configure(with selector: Variant){
        myIdLabel.text = String(describing: selector.id)
        myTextLabel.text = selector.text
        myIdLabel.sizeToFit()
        myTextLabel.sizeToFit()
    }
    
}
