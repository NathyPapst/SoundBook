//
//  AddEditViewController.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 16/09/21.
//

import UIKit
import AVFoundation

class AddEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, AVAudioRecorderDelegate {
    
    // interface
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
    let circle = UIImageView()
    let microfoneButton = UIButton()
    let microfone = UIImageView()
    
    // variaveis de coleta
    var nomeObjeto: String?
    var imageNameObjeto: String?
    var classificacaoObjeto: String?
    var horarioObjeto: String?
    var intensidadeObjeto: Int64?
    
    var objeto: Objeto?
    
    // variaveis para gravar som
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var time = Timer()
    var valores = [Float]()
    
    // var para dar reload na tableView anterior
    var isDismissed: (() -> Void)?
    
    // haptic feedback
    let generatorNotification = UINotificationFeedbackGenerator()
    let generatorFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        //navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(popView))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        title = "Adicionar"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveObject))
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
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
        
        instrucaoLabel.text = "Aperte o botão para medir o volume do som desejado e preencher as informações abaixo automáticamente."
        instrucaoLabel.numberOfLines = 0
        instrucaoLabel.font = UIFont.systemFont(ofSize: 14)
        instrucaoLabel.textColor = .systemGray2
        instrucaoLabel.textAlignment = .center
        view.addSubview(instrucaoLabel)
        
        microfoneButton.layer.cornerRadius = 50
        microfoneButton.addTarget(self, action: #selector(medirDecibel), for: .touchUpInside)
        view.addSubview(microfoneButton)
        
        circle.image = UIImage(systemName: "circle.fill")
        circle.tintColor = UIColor(named: "orangeColor")
        view.addSubview(circle)
        
        
        microfone.image = UIImage(systemName: "mic.slash")
        microfone.tintColor = .systemGray6
        view.addSubview(microfone)
        
        if let objeto = objeto {
            let imagePath = getDocumentsDirectory().appendingPathComponent(objeto.imageName ?? "")
            photoImage.image = UIImage(contentsOfFile: imagePath.path)
            photoImage.contentMode = .scaleAspectFit
            photoImage.leadingAnchor.constraint(equalTo: addImageButton.leadingAnchor).isActive = true
            photoImage.trailingAnchor.constraint(equalTo: addImageButton.trailingAnchor).isActive = true
            photoImage.bottomAnchor.constraint(equalTo: addImageButton.bottomAnchor).isActive = true
            photoImage.topAnchor.constraint(equalTo: addImageButton.topAnchor).isActive = true
            
            
            decibelsCardLabel.text = "\(objeto.intensidade)"
            classificacaoCardLabel.text = objeto.classificacao
            horarioCardLabel.text = objeto.horarioUso
            
            nomeObjeto = objeto.nome
            intensidadeObjeto = objeto.intensidade
            classificacaoObjeto = objeto.classificacao
            horarioObjeto = objeto.horarioUso
            imageNameObjeto = objeto.imageName
        }
        
        addConstraints()
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("allowed")
                    } else {
                        print("Erro ao tentar gravar")
                    }
                }
            }
        } catch {
            print("Erro ao tentar gravar")
        }
    }
    
    @objc func popView() {
        let ac = UIAlertController(title: "Tem certeza?", message: "Após cancelar todas as alterações serão perdidas.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Sim ", style: .destructive, handler: {
            action in
            self.generatorNotification.notificationOccurred(.success)
            self.isDismissed?()
            self.dismiss(animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        
        self.generatorNotification.notificationOccurred(.warning)
        self.present(ac, animated: true)
        
    }
    
    @objc func saveObject() {
        
        if let objeto = objeto {
            objeto.imageName = imageNameObjeto
            objeto.intensidade = intensidadeObjeto!
            objeto.nome = nomeObjeto
            objeto.classificacao = classificacaoObjeto
            objeto.horarioUso = horarioObjeto
            SoundRepository.shared.saveContext()
            generatorNotification.notificationOccurred(.success)
            self.isDismissed?()
            dismiss(animated: true)
        } else {
            if let imageNameObjeto = imageNameObjeto, let intensidadeObjeto = intensidadeObjeto, let classificacaoObjeto = classificacaoObjeto, let horarioObjeto = horarioObjeto, let nomeObjeto = nomeObjeto {
                _ = SoundRepository.shared.createObject(nome: nomeObjeto, intensidade: intensidadeObjeto, imageName: imageNameObjeto, horarioUso: horarioObjeto, classificacao: classificacaoObjeto)
                generatorNotification.notificationOccurred(.success)
                self.isDismissed?()
                dismiss(animated: true)
            } else {
                let ac = UIAlertController(title: "Algum dado está vazio", message: "Verfique se todos os campos foram preenchidos corretamente.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                generatorNotification.notificationOccurred(.warning)
                self.present(ac, animated: true)
            }
        }
    }
    
    // MARK: - Funçoes UIImagePicker
    // Funcao ativida pelo botao de imagem
    @objc func escolherImagem() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        UINavigationBar.appearance().tintColor = .red
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        imageNameObjeto = imageName
        
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        photoImage.image = UIImage(contentsOfFile: imagePath.path)
        photoImage.contentMode = .scaleAspectFit
        photoImage.leadingAnchor.constraint(equalTo: addImageButton.leadingAnchor).isActive = true
        photoImage.trailingAnchor.constraint(equalTo: addImageButton.trailingAnchor).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: addImageButton.bottomAnchor).isActive = true
        photoImage.topAnchor.constraint(equalTo: addImageButton.topAnchor).isActive = true
        
        generatorNotification.notificationOccurred(.success)
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - Funcao botao de microfone
    @objc func medirDecibel() {
        generatorFeedback.impactOccurred()
        if audioRecorder == nil {
            
            microfone.image = UIImage(systemName: "mic")
            startRecording()
        } else {
            
            microfone.image = UIImage(systemName: "mic.slash")
            finishRecording(success: true)
        }
    }
    
    // MARK: - Constraints da interface
    // Funcao para adicionar constraint de TODOS os elementos
    func addConstraints() {
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addImageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        
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
        instrucaoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        instrucaoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.topAnchor.constraint(equalTo: instrucaoLabel.bottomAnchor, constant: view.frame.height*0.03).isActive = true
        circle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        circle.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        microfoneButton.translatesAutoresizingMaskIntoConstraints = false
        microfoneButton.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true
        microfoneButton.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
        microfoneButton.heightAnchor.constraint(equalTo: circle.heightAnchor).isActive = true
        microfoneButton.widthAnchor.constraint(equalTo: circle.widthAnchor).isActive = true
        
        microfone.translatesAutoresizingMaskIntoConstraints = false
        microfone.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true
        microfone.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
        microfone.heightAnchor.constraint(equalTo: circle.heightAnchor, multiplier: 0.45).isActive = true
        microfone.widthAnchor.constraint(equalTo: circle.widthAnchor, multiplier: 0.4).isActive = true
        
    }
    
    // MARK: - Audio recorder
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        valores.removeAll()
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.isMeteringEnabled = true
            audioRecorder.delegate = self
            audioRecorder.record()
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(measureIntensity), userInfo: nil, repeats: true)
            
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        var soma: Float = 0
        
        if valores.count > 0 {
            valores.remove(at: 0)
        }
        
        for i in valores {
            soma += i
        }
        
        print(valores)
        
        if soma/Float(valores.count) > 0 {
            intensidadeObjeto = Int64(soma/Float(valores.count))
            if intensidadeObjeto! >= 65 {
                classificacaoObjeto = "Alto"
                horarioObjeto = "9h - 22h"
            } else if intensidadeObjeto! >= 50 {
                classificacaoObjeto = "Médio"
                horarioObjeto = "9h - 22h"
            } else {
                classificacaoObjeto = "Baixo"
                horarioObjeto = "00h - 24h"
            }
            
            decibelsCardLabel.text = "\(intensidadeObjeto!)"
            classificacaoCardLabel.text = classificacaoObjeto
            horarioCardLabel.text = horarioObjeto
        }
        
        
        
        time.invalidate()
        
        audioRecorder.stop()
        audioRecorder = nil
    }
    
    @objc func measureIntensity() {
        var decibel = audioRecorder.peakPower(forChannel: 0)
        audioRecorder.updateMeters()
        
        let minDb: Float = -80
        
        // 2
        if decibel < minDb {
            decibel = 0.0
        } else if decibel >= 1.0 {
            decibel -= minDb
        } else {
          // 3
            decibel -= minDb
        }
        
        print(decibel)
        valores.append(decibel)
    }
    
    
    // MARK: - Table View functions
    
    // Funcao que escolhe quantidade de celulas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Funçao para construir celular (design)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TextFieldTableViewCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .systemGray6
            cell.placeHolder = "Ex: Liquidificador"
            cell.dataTextField.text = objeto?.nome
            cell.dataTextField.delegate = self
            cell.dataTextField.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(newValue), for: .editingChanged)
    }
    
    @objc func newValue(_ textField: UITextField) {
        nomeObjeto = textField.text ?? ""
    }
    
}
