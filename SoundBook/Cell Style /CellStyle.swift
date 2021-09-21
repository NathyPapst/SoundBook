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
        return image
    }()
    var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(named: "textColor")
        title.font = .systemFont(ofSize: (18), weight: .semibold)
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
        self.addSubview(imageCell)
        self.addSubview(titleLabel)
        self.addSubview(infoLabel)
        self.addSubview(imageSymbol)
        self.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


