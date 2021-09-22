//
//  CellStyle.swift
//  SoundBook
//
//  Created by Francielly Cristina Ortiz Candido on 21/09/21.
//

import Foundation
import UIKit

class CellStyle: UITableViewCell{
    var imageCell: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        return image
    }()
    var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(named: "textColor")
        title.font = .systemFont(ofSize: (18), weight: .semibold)
        title.backgroundColor = .black
        return title
    }()
    var infoLabel: UILabel = {
        let info = UILabel()
        info.textColor = UIColor(named: "textColor")
        info.font = .systemFont(ofSize: (18), weight: .regular)
        return info
    }()
    var imageSymbol: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "deskclock")
        image.tintColor = UIColor(named: "textColor")
        return image
    }()
    var timeLabel: UILabel = {
        let time = UILabel()
        time.textColor = UIColor(named: "textColor")
        time.font = .systemFont(ofSize: (18), weight: .regular)
        return time
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageCell.layer.cornerRadius = (self.frame.height/3.5)
        self.addSubview(imageCell)
        self.addSubview(titleLabel)
        self.addSubview(infoLabel)
        self.addSubview(imageSymbol)
        self.addSubview(timeLabel)
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
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.width/2).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
}


