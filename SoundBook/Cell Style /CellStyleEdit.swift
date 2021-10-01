//
//  CellStyleEdit.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 27/09/21.
//

import Foundation
import UIKit

class CellStyleEdit: UITableViewCell {
    var imageCell: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(named: "textColor")
        title.font = .systemFont(ofSize: (18), weight: .semibold)
        title.text = "Liquidificador"
        return title
    }()
    var infoSoundLabel: UILabel = {
        let info = UILabel()
        info.textColor = UIColor(named: "textColor")
        info.font = .systemFont(ofSize: (18), weight: .regular)
        info.text = "120 dB | Médio"
        return info
    }()
    var editButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .large)
        let largeBoldDoc = UIImage(systemName: "square.and.pencil", withConfiguration: largeConfig)
        
        let button = UIButton()
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = UIColor(named: "orangeColor")
        return button
    }()
    
    var eraseButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .large)
        let largeBoldDoc = UIImage(systemName: "trash", withConfiguration: largeConfig)
        
        let button = UIButton()
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageCell.layer.cornerRadius = (self.frame.height/3.5)
        self.contentView.addSubview(imageCell)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(infoSoundLabel)
        self.contentView.addSubview(editButton)
        self.contentView.addSubview(eraseButton)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints(){
        
        //constraints imagem do objeto
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        imageCell.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height/5).isActive = true
        imageCell.heightAnchor.constraint(equalToConstant: 65).isActive = true
        imageCell.widthAnchor.constraint(equalToConstant: 65).isActive = true
        imageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        //constraints titulo do objeto
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.width/5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true

        //constraint infoSoundLabel
        infoSoundLabel.translatesAutoresizingMaskIntoConstraints = false
        infoSoundLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 10).isActive = true
        infoSoundLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.height/7).isActive = true
        infoSoundLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: self.frame.height/20).isActive = true
        infoSoundLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.width/2).isActive = true
        
        //constraint editButton
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        editButton.leadingAnchor.constraint(equalTo: infoSoundLabel.trailingAnchor, constant: 40).isActive = true

        
        //constraint eraseButton
        eraseButton.translatesAutoresizingMaskIntoConstraints = false
        eraseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        eraseButton.leadingAnchor.constraint(equalTo: infoSoundLabel.trailingAnchor, constant: 100).isActive = true
        
    }
}
