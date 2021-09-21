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
    var highLabel: UILabel = UILabel()
    var moderateLabel: UILabel = UILabel()
    var lowLabel: UILabel = UILabel()
    
    
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
        
        highLabel.text = "Alto"
        highLabel.textColor = UIColor(red: 237.0/255.0, green: 85.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        highLabel.font = .systemFont(ofSize: (18), weight: .semibold)
        
        
        moderateLabel.text = "Médio"
        moderateLabel.textColor = UIColor(red: 244.0/255.0, green: 210.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        moderateLabel.font = .systemFont(ofSize: (18), weight: .semibold)
        
        lowLabel.text = "Baixo"
        lowLabel.textColor = UIColor(red: 51.0/255.0, green: 219.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        lowLabel.font = .systemFont(ofSize: (18), weight: .semibold)
        
        view.addSubview(soundIntensityLabel)
        view.addSubview(decibelSpace)
        view.addSubview(indicatorLabel)
        view.addSubview(highLabel)
        view.addSubview(moderateLabel)
        view.addSubview(lowLabel)
        
        
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
        
        //constraints lowLabel
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.topAnchor.constraint(equalTo: decibelSpace.bottomAnchor).isActive = true
        lowLabel.centerXAnchor.constraint(equalTo: decibelSpace.centerXAnchor, constant: -80).isActive = true
        
        //constraints moderateLabel
        moderateLabel.translatesAutoresizingMaskIntoConstraints = false
        moderateLabel.topAnchor.constraint(equalTo: decibelSpace.bottomAnchor).isActive = true
        moderateLabel.centerXAnchor.constraint(equalTo: decibelSpace.centerXAnchor).isActive = true
        
        //constraints highLabel
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.topAnchor.constraint(equalTo: decibelSpace.bottomAnchor).isActive = true
        highLabel.centerXAnchor.constraint(equalTo: decibelSpace.centerXAnchor, constant: 80).isActive = true
    }

}

