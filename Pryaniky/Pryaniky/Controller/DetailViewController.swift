//
//  DetailViewController.swift
//  Pryaniky
//
//  Created by Марк Шнейдерман on 13.02.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var myData : MyData?
    var tableView = UITableView()
    var pictureImageView = UIImageView()
    var ourTextLabel  = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp(name: myData?.name ?? "")
    }
    
    
    ///  логически обрабытывает нажатие на ячейку что именно нужно отобразить
    /// - Parameter name:  принимает название одно из view(hz,selector,picture)
    func setUp(name : String){
        main_SetUp()
        if name == "hz"{
            hz_SetUp()
        }else if name == "picture"{
            picture_SetUp()
        }else {
            selector_SetUp()
        }
    }
    
      //MARK: - Общие настройки нашего DetailViewController
    func main_SetUp(){
        self.view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SelectorTableViewCell.self, forCellReuseIdentifier: "Selector")
        self.pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        self.ourTextLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
      //MARK: - Настройка если выбрана hz
    func hz_SetUp(){
        //добавление обьекта
        self.view.addSubview(ourTextLabel)
        // constraints
        self.ourTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.ourTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        ourTextLabel.text = myData?.data.text
        self.ourTextLabel.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        ourTextLabel.sizeToFit()
    }
    //MARK: - Настройка если выбрана Picture
    func picture_SetUp(){
        //добавление обьектов
        self.view.addSubview(pictureImageView)
        self.view.addSubview(ourTextLabel)
        //Constrains
        self.pictureImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -20).isActive = true
        self.pictureImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.pictureImageView.heightAnchor.constraint(equalToConstant: self.view.frame.width / 2 - 20 ).isActive = true
        self.pictureImageView.contentMode = .scaleAspectFit
        self.ourTextLabel.topAnchor.constraint(equalTo: self.pictureImageView.bottomAnchor, constant: 10).isActive = true
        self.ourTextLabel.centerXAnchor.constraint(equalTo: self.pictureImageView.centerXAnchor, constant: 0).isActive = true
        // we use KingFisher
        pictureImageView.kf.setImage(with: URL(string:myData?.data.url ?? ""))
        ourTextLabel.text = myData?.data.text
        self.ourTextLabel.font = UIFont.systemFont(ofSize: 20,weight: .bold)
    }
    
    //MARK: - Настройка если выбрана selector
    func selector_SetUp(){
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    }

}

  //MARK: - UITableViewDataSource для selector

extension DetailViewController : UITableViewDataSource{
    // метод который возвращает количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.data.variants?.count ?? 0
    }
    // метод который обрабатывает ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Selector",for: indexPath) as! SelectorTableViewCell
        cell.configure(with: (myData?.data.variants?[indexPath.row])!)
        return cell
    }
}
  //MARK: - UITableViewDelegate для selector

extension DetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
