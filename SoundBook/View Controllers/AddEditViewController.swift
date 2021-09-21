//
//  AddEditViewController.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 16/09/21.
//

import UIKit

class AddEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    let addImageButton = UIButton()
    let photoImage = UIImageView()
    let addPhotoImage = UIImageView()
    let nomeLabel = UILabel()
    let intensidadeLabel = UILabel()
    
    let decibelsLabel = UILabel()
    let classificacaoLabel = UILabel()
    let horarioLabel = UILabel()
    
    let decibelsCardLabel = UILabel()
    let classificacaoCardLabel = UILabel()
    let horarioCardLabel = UILabel()
    
    let instrucaoLabel = UILabel()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    let microfoneButton = UIButton()
    
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
        
        
        
        
        // configs image
        photoImage.image = UIImage(systemName: "photo.on.rectangle")
        photoImage.tintColor = UIColor(named: "orangeColor")
        view.addSubview(photoImage)
        
        
        addPhotoImage.image = UIImage(systemName: "plus.circle")
        addPhotoImage.tintColor = UIColor(named: "orangeColor")
        view.addSubview(addPhotoImage)
        
        
        
        // Configs nome label
        
        nomeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nomeLabel.text = "Nome do objeto"
        view.addSubview(nomeLabel)
        
        
        
        // Configs tableView
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
        // configs label intensidade
        
        intensidadeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        intensidadeLabel.text = "Medir intensidade"
        view.addSubview(intensidadeLabel)
        
        //decibelsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        decibelsCardLabel.text = "00"
        decibelsCardLabel.textColor = .systemGray
        decibelsCardLabel.backgroundColor = .systemGray5
        decibelsCardLabel.layer.masksToBounds = true
        decibelsCardLabel.layer.cornerRadius = 10
        decibelsCardLabel.textAlignment = .center
        view.addSubview(decibelsCardLabel)
        
        //classificacaoLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        classificacaoCardLabel.text = "----"
        classificacaoCardLabel.textColor = .systemGray
        classificacaoCardLabel.backgroundColor = .systemGray5
        classificacaoCardLabel.layer.masksToBounds = true
        classificacaoCardLabel.layer.cornerRadius = 10
        classificacaoCardLabel.textAlignment = .center
        view.addSubview(classificacaoCardLabel)
        
        //horarioLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        horarioCardLabel.text = "00h - 00h"
        horarioCardLabel.textColor = .systemGray
        horarioCardLabel.backgroundColor = .systemGray5
        horarioCardLabel.layer.masksToBounds = true
        horarioCardLabel.layer.cornerRadius = 10
        horarioCardLabel.textAlignment = .center

        view.addSubview(horarioCardLabel)
        
        decibelsLabel.text = "Decibéis"
        view.addSubview(decibelsLabel)
        
        classificacaoLabel.text = "Classificação"
        view.addSubview(classificacaoLabel)
        
        horarioLabel.text = "Horário de uso"
        view.addSubview(horarioLabel)
        
        instrucaoLabel.text = "Aperte o botao para medir o volume do som desejado e preencher as informaçoes abaixo automáticamente."
        instrucaoLabel.numberOfLines = 0
        instrucaoLabel.font = UIFont.systemFont(ofSize: 14)
        instrucaoLabel.textColor = .systemGray2
        instrucaoLabel.textAlignment = .center
        view.addSubview(instrucaoLabel)
        
        microfoneButton.backgroundColor = UIColor(named: "orangeColor")
        microfoneButton.setImage(UIImage(systemName: "mic"), for: .normal)
        microfoneButton.layer.cornerRadius = 55
        view.addSubview(microfoneButton)
        
        addConstraints()
    }
    
    // Funcao ativida pelo botao de imagem
    @objc func escolherImagem() {
        print("Alo mundo")
    }
    
    // Funcao para adicionar constraint de TODOS os elementos
    func addConstraints() {
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addImageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.centerXAnchor.constraint(equalTo: addImageButton.centerXAnchor).isActive = true
        photoImage.centerYAnchor.constraint(equalTo: addImageButton.centerYAnchor).isActive = true
        photoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        photoImage.widthAnchor.constraint(equalToConstant: 102).isActive = true
        
        
        addPhotoImage.translatesAutoresizingMaskIntoConstraints = false
        addPhotoImage.trailingAnchor.constraint(equalTo: addImageButton.trailingAnchor, constant: -6).isActive = true
        addPhotoImage.bottomAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: -6).isActive = true
        addPhotoImage.heightAnchor.constraint(equalToConstant: 27).isActive = true
        addPhotoImage.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        
        nomeLabel.translatesAutoresizingMaskIntoConstraints = false
        nomeLabel.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 8).isActive = true
        nomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        nomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: nomeLabel.bottomAnchor, constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        intensidadeLabel.translatesAutoresizingMaskIntoConstraints = false
        intensidadeLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        intensidadeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        intensidadeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        classificacaoCardLabel.translatesAutoresizingMaskIntoConstraints = false
        classificacaoCardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        classificacaoCardLabel.topAnchor.constraint(equalTo: intensidadeLabel.bottomAnchor, constant: 40).isActive = true
        classificacaoCardLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        classificacaoCardLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        decibelsCardLabel.translatesAutoresizingMaskIntoConstraints = false
        decibelsCardLabel.trailingAnchor.constraint(equalTo: classificacaoCardLabel.leadingAnchor, constant: -10).isActive = true
        decibelsCardLabel.centerYAnchor.constraint(equalTo: classificacaoCardLabel.centerYAnchor).isActive = true
        decibelsCardLabel.heightAnchor.constraint(equalTo: classificacaoCardLabel.heightAnchor).isActive = true
        decibelsCardLabel.widthAnchor.constraint(equalTo: classificacaoCardLabel.widthAnchor).isActive = true
        
        horarioCardLabel.translatesAutoresizingMaskIntoConstraints = false
        horarioCardLabel.leadingAnchor.constraint(equalTo: classificacaoCardLabel.trailingAnchor, constant: 10).isActive = true
        horarioCardLabel.centerYAnchor.constraint(equalTo: classificacaoCardLabel.centerYAnchor).isActive = true
        horarioCardLabel.heightAnchor.constraint(equalTo: classificacaoCardLabel.heightAnchor).isActive = true
        horarioCardLabel.widthAnchor.constraint(equalTo: classificacaoCardLabel.widthAnchor).isActive = true
        
        decibelsLabel.translatesAutoresizingMaskIntoConstraints = false
        decibelsLabel.bottomAnchor.constraint(equalTo: decibelsCardLabel.topAnchor, constant: -4).isActive = true
        decibelsLabel.centerXAnchor.constraint(equalTo: decibelsCardLabel.centerXAnchor).isActive = true
        
        horarioLabel.translatesAutoresizingMaskIntoConstraints = false
        horarioLabel.bottomAnchor.constraint(equalTo: horarioCardLabel.topAnchor, constant: -4).isActive = true
        horarioLabel.centerXAnchor.constraint(equalTo: horarioCardLabel.centerXAnchor).isActive = true
        
        classificacaoLabel.translatesAutoresizingMaskIntoConstraints = false
        classificacaoLabel.bottomAnchor.constraint(equalTo: classificacaoCardLabel.topAnchor, constant: -4).isActive = true
        classificacaoLabel.centerXAnchor.constraint(equalTo: classificacaoCardLabel.centerXAnchor).isActive = true
        
        
        instrucaoLabel.translatesAutoresizingMaskIntoConstraints = false
        instrucaoLabel.topAnchor.constraint(equalTo: classificacaoCardLabel.bottomAnchor, constant: 24).isActive = true
        instrucaoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        instrucaoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        microfoneButton.translatesAutoresizingMaskIntoConstraints = false
        microfoneButton.topAnchor.constraint(equalTo: instrucaoLabel.bottomAnchor, constant: 36).isActive = true
        microfoneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        microfoneButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    // Funcao que escolhe quantidade de celulas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Funçao para construir celular (design)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TextFieldTableViewCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .systemGray6
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemGray4.cgColor
            cell.placeHolder = "Ex: Liquidificador"
            cell.dataTextField.delegate = self
            cell.dataTextField.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
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
