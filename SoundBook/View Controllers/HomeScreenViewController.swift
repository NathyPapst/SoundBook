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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = UIColor(named: "orangeColor")
        buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editList))
        navigationItem.leftBarButtonItem = buttonEdit!
        
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addObject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
        // Do any additional setup after loading the view.
    }

    @objc func editList(){
        
    }
    
    @objc func addObject(){
        
    }

}

