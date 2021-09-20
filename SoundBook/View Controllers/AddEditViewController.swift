//
//  AddEditViewController.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 16/09/21.
//

import UIKit

class AddEditViewController: UIViewController {
    let addImageButton = UIButton()
    let photoImage = UIImageView()
    let addPhotoImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        title = "Adicionar"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "orangeColor")
        
        
        // Configs button
        addImageButton.backgroundColor = .systemGray6
        addImageButton.addTarget(self, action: #selector(escolherImagem), for: .touchUpInside)
        view.addSubview(addImageButton)
        
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        addImageButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //addImageButton.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        addImageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true

        
        // configs image
        photoImage.image = UIImage(systemName: "photo.on.rectangle")
        photoImage.tintColor = UIColor(named: "orangeColor")
        view.addSubview(photoImage)
        
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        
        photoImage.centerXAnchor.constraint(equalTo: addImageButton.centerXAnchor).isActive = true
        photoImage.centerYAnchor.constraint(equalTo: addImageButton.centerYAnchor).isActive = true
        
        photoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        photoImage.widthAnchor.constraint(equalToConstant: 102).isActive = true
        
//        photoImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
//        photoImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        
        addPhotoImage.image = UIImage(systemName: "plus.circle")
        addPhotoImage.tintColor = UIColor(named: "orangeColor")
        view.addSubview(addPhotoImage)
        
        addPhotoImage.translatesAutoresizingMaskIntoConstraints = false
        
        addPhotoImage.trailingAnchor.constraint(equalTo: addImageButton.trailingAnchor, constant: -6).isActive = true
        addPhotoImage.bottomAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: -6).isActive = true
        
        addPhotoImage.heightAnchor.constraint(equalToConstant: 27).isActive = true
        addPhotoImage.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func escolherImagem() {
        print("Alo mundo")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
