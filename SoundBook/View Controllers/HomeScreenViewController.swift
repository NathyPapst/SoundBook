//
//  ViewController.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 16/09/21.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var buttonEdit: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = UIColor(named: "orangeColor")
        buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editList))
        navigationItem.leftBarButtonItem = buttonEdit!
        
        
        // Do any additional setup after loading the view.
    }

    @objc func editList(){
        
    }

}

