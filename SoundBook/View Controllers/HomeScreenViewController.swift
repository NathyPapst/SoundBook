//
//  ViewController.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 16/09/21.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var buttonEdit: UIBarButtonItem!
    var buttonAdd: UIBarButtonItem!
    var soundIntensityLabel: UILabel = UILabel()
    var decibelSpace: UIView = UIView()
    var indicatorLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = UIColor(named: "orangeColor")
        buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editList))
        navigationItem.leftBarButtonItem = buttonEdit!
        
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addObject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
        soundIntensityLabel.text = "Intensidade do Som"
        soundIntensityLabel.textColor = UIColor(named: "textColor")
        soundIntensityLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        
        decibelSpace.backgroundColor = .systemGray3
        
        indicatorLabel.text = "120 dB"
        indicatorLabel.textColor = UIColor(named: "textColor")
        indicatorLabel.font = .systemFont(ofSize: (view.frame.height * 0.028), weight: .regular)
        
        view.addSubview(soundIntensityLabel)
        view.addSubview(decibelSpace)
        view.addSubview(indicatorLabel)
        
        addConstraints()
        
        // Do any additional setup after loading the view.
    }

    @objc func editList(){
        
    }
    
    @objc func addObject(){
        
    }
    
    func addConstraints(){
        
        //constraints do sound intensity
        soundIntensityLabel.translatesAutoresizingMaskIntoConstraints = false
        soundIntensityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/7).isActive = true
        soundIntensityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        soundIntensityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34).isActive = true
        
        //constraints decibelSpace
        decibelSpace.translatesAutoresizingMaskIntoConstraints = false
        decibelSpace.topAnchor.constraint(equalTo: soundIntensityLabel.bottomAnchor, constant: view.frame.height/50).isActive = true
        decibelSpace.heightAnchor.constraint(equalToConstant: 50).isActive = true
        decibelSpace.widthAnchor.constraint(equalToConstant: 260).isActive = true
        decibelSpace.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        //constraints indicatorLabel
        indicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorLabel.leadingAnchor.constraint(equalTo: decibelSpace.trailingAnchor, constant: 10).isActive = true
        indicatorLabel.topAnchor.constraint(equalTo: soundIntensityLabel.bottomAnchor, constant: view.frame.height/30).isActive = true
        indicatorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

}

