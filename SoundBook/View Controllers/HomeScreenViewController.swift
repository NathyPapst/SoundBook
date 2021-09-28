//
//  ViewController.swift
//  SoundBook
//
//  Created by Nathalia do Valle Papst on 16/09/21.
//

import UIKit

enum ViewControllerType{
    case home
    case edit
}

class HomeScreenViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var buttonEditOK: UIBarButtonItem!
    var buttonAdd: UIBarButtonItem!
    var soundIntensityLabel: UILabel = UILabel()
    var decibelSpace: UIView = UIView()
    var indicatorLabel: UILabel = UILabel()
    var highLabel: UILabel = UILabel()
    var moderateLabel: UILabel = UILabel()
    var lowLabel: UILabel = UILabel()
    var myObjLabel: UILabel = UILabel()
    var searchBar: UISearchBar = UISearchBar()
    var type: ViewControllerType = .home
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    var intenseViews: [UIView] = [UIView]()
    var filtered = SoundRepository.shared.getAllObjects()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        _ = SoundRepository.shared.createObject(nome: "Luca", intensidade: 50, imageName: "", horarioUso: "20h - 7h", classificacao: "Alto")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //cria a segmented
        let items = ["Todos", "Alto", "Médio", "Baixo"]
        let segmentedControlCustom = UISegmentedControl(items: items)
        segmentedControlCustom.selectedSegmentIndex = 0
        
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        
        segmentedControlCustom.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        
        // Make second segment selected
        segmentedControlCustom.selectedSegmentIndex = 0
        
        //Change text color of UISegmentedControl
        segmentedControlCustom.tintColor = UIColor.yellow
        
        //Change UISegmentedControl background colour
        segmentedControlCustom.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.04)
        
        // Add function to handle Value Changed events
        segmentedControlCustom.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = UIColor(named: "orangeColor")
        buttonEditOK = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editList))
        navigationItem.leftBarButtonItem = buttonEditOK!
        
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addObject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
        soundIntensityLabel.text = "Intensidade do Som"
        soundIntensityLabel.textColor = UIColor(named: "textColor")
        soundIntensityLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        
        decibelSpace.backgroundColor = .systemGray3
        decibelSpace.isHidden = true
        
        
        indicatorLabel.text = "120 dB"
        indicatorLabel.textColor = UIColor(named: "textColor")
        indicatorLabel.font = .systemFont(ofSize: (view.frame.height * 0.028), weight: .regular)
        
        highLabel.text = "Alto"
        highLabel.textColor = UIColor(red: 237.0/255.0, green: 85.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        highLabel.font = .systemFont(ofSize: (18), weight: .semibold)
        
        
        moderateLabel.text = "Médio"
        moderateLabel.textColor = UIColor(named: "moderateColor")
        moderateLabel.font = .systemFont(ofSize: (18), weight: .semibold)
        
        lowLabel.text = "Baixo"
        lowLabel.textColor = UIColor(red: 51.0/255.0, green: 219.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        lowLabel.font = .systemFont(ofSize: (18), weight: .semibold)
        
        myObjLabel.text = "Meus Objetos"
        myObjLabel.textColor = UIColor(named: "textColor")
        myObjLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        
        view.addSubview(soundIntensityLabel)
        view.addSubview(decibelSpace)
        view.addSubview(indicatorLabel)
        view.addSubview(highLabel)
        view.addSubview(moderateLabel)
        view.addSubview(lowLabel)
        view.addSubview(myObjLabel)
        view.addSubview(searchBar)
        view.addSubview(segmentedControlCustom)
        view.addSubview(tableView)
        
        for _ in 0...11 {
            let ret = UIView()
            ret.backgroundColor = .gray
            ret.layer.cornerRadius = 10
            intenseViews.append(ret)
            view.addSubview(ret)
        }
        
        organizeIntense()
        addConstraints()
        
        
        //Constraints segmented control
        segmentedControlCustom.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlCustom.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: view.frame.height/70).isActive = true
        segmentedControlCustom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        segmentedControlCustom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func organizeIntense() {
        for i in 0..<intenseViews.count {
            intenseViews[i].translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                intenseViews[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                intenseViews[i].topAnchor.constraint(equalTo: soundIntensityLabel.bottomAnchor, constant: view.frame.height/40).isActive = true
                intenseViews[i].heightAnchor.constraint(equalToConstant: 40).isActive = true
                intenseViews[i].widthAnchor.constraint(equalToConstant: 18).isActive = true
            } else {
                if i == 3 || i == 7 || i == 11 {
                    intenseViews[i].heightAnchor.constraint(equalToConstant: 50).isActive = true
                    intenseViews[i].widthAnchor.constraint(equalToConstant: 18).isActive = true
                } else {
                    intenseViews[i].heightAnchor.constraint(equalToConstant: 40).isActive = true
                    intenseViews[i].widthAnchor.constraint(equalToConstant: 18).isActive = true
                }
                
                intenseViews[i].bottomAnchor.constraint(equalTo: intenseViews[0].bottomAnchor).isActive = true
                intenseViews[i].leadingAnchor.constraint(equalTo: intenseViews[i-1].trailingAnchor, constant: 4).isActive = true
            }
            
            
        }
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        switch sender.selectedSegmentIndex {
        case 0:
            filtered = SoundRepository.shared.getAllObjects()
        case 1:
            filtered = SoundRepository.shared.getAllObjects().filter { $0.classificacao!.contains("Alto") }
        case 2:
            filtered = SoundRepository.shared.getAllObjects().filter { $0.classificacao!.contains("Médio") }
        case 3:
            filtered = SoundRepository.shared.getAllObjects().filter { $0.classificacao!.contains("Baixo") }
        default:
            filtered = SoundRepository.shared.getAllObjects()
            break
        }
        tableView.reloadData()
        searchBar.text = ""
    }
    
    @objc func editList(){
        self.type = .edit
        
        buttonEditOK = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.plain, target: self, action: #selector(okList))
        navigationItem.leftBarButtonItem = buttonEditOK!
        
        tableView.reloadData()
    }
    
    @objc func okList() {
        self.type = .home
        
        buttonEditOK = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editList))
        navigationItem.leftBarButtonItem = buttonEditOK!
        
        tableView.reloadData()
    }
    
    @objc func addObject(){
        let root = AddEditViewController()
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        root.isDismissed = { [weak self] in
            self?.tableView.reloadData()
        }
        present(vc, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if textSearched.isEmpty {
            filtered = SoundRepository.shared.getAllObjects()
        } else {
            filtered = filtered.filter { $0.nome?.lowercased().contains(textSearched.lowercased()) as! Bool }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
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
        lowLabel.centerXAnchor.constraint(equalTo: decibelSpace.centerXAnchor, constant: -95).isActive = true
        
        //constraints moderateLabel
        moderateLabel.translatesAutoresizingMaskIntoConstraints = false
        moderateLabel.topAnchor.constraint(equalTo: decibelSpace.bottomAnchor).isActive = true
        moderateLabel.centerXAnchor.constraint(equalTo: decibelSpace.centerXAnchor).isActive = true
        
        //constraints highLabel
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.topAnchor.constraint(equalTo: decibelSpace.bottomAnchor).isActive = true
        highLabel.centerXAnchor.constraint(equalTo: decibelSpace.centerXAnchor, constant: 90).isActive = true
        
        //constraints myObjLabel
        myObjLabel.translatesAutoresizingMaskIntoConstraints = false
        myObjLabel.topAnchor.constraint(equalTo: moderateLabel.bottomAnchor, constant: view.frame.height/42).isActive = true
        myObjLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        myObjLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34).isActive = true
        
        //constraint searchbar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: myObjLabel.bottomAnchor, constant: view.frame.height/200).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        //constraint tableview
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: view.frame.height/12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objetos = filtered

        let imagePath = getDocumentsDirectory().appendingPathComponent(objetos[indexPath.row].imageName ?? "")
        
        if self.type == .home {
            tableView.register(CellStyle.self, forCellReuseIdentifier: "cell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellStyle else { preconditionFailure() }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.titleLabel.text = objetos[indexPath.row].nome
            cell.imageCell.image = UIImage(contentsOfFile: imagePath.path)
            cell.timeLabel.text = objetos[indexPath.row].horarioUso
            cell.infoSoundLabel.text = "\(objetos[indexPath.row].intensidade) | \(objetos[indexPath.row].classificacao ?? "")"
            return cell
        }
        
        else if self.type == .edit {
            tableView.register(CellStyleEdit.self, forCellReuseIdentifier: "cellEdit")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellEdit", for: indexPath) as? CellStyleEdit else { preconditionFailure() }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.titleLabel.text = objetos[indexPath.row].nome
            cell.imageCell.image = UIImage(contentsOfFile: imagePath.path)
            cell.infoSoundLabel.text = "\(objetos[indexPath.row].intensidade) | \(objetos[indexPath.row].classificacao!)"
            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(editarOBjeto(_:)), for: .touchUpInside)
            cell.eraseButton.tag = indexPath.row
            cell.eraseButton.addTarget(self, action: #selector(deletarObjeto(_:)), for: .touchUpInside)
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func editarOBjeto(_ sender: UIButton) {
        let root = AddEditViewController()
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        
        let objeto = filtered[sender.tag]
        root.objeto = objeto
        root.isDismissed = { [weak self] in
            self?.tableView.reloadData()
        }
        self.present(vc, animated: true)
    }
    
    @objc func deletarObjeto(_ sender: UIButton) {
        let ac = UIAlertController(title: "Tem certeza?", message: "Após deletar não será possível desfazer a alteração.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: {
            action in
            
            SoundRepository.shared.deleteObject(object: self.filtered[sender.tag])
            self.filtered.remove(at: sender.tag)
            self.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            let ac = UIAlertController(title: "Tem certeza?", message: "Após deletar não será possível desfazer a alteração.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: {
                action in
                
                SoundRepository.shared.deleteObject(object: self.filtered[indexPath.row])
                self.filtered.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            
            self.present(ac, animated: true)
            
        })
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            let root = AddEditViewController()
            let vc = UINavigationController(rootViewController: root)
            vc.modalPresentationStyle = .automatic
            
            let objeto = self.filtered[indexPath.row]
            root.objeto = objeto
            root.isDismissed = { [weak self] in
                self?.tableView.reloadData()
            }
            self.present(vc, animated: true)
        })
        editAction.backgroundColor = UIColor(red: 254.0/255.0, green: 150.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
}

