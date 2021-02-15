//
//  ViewController.swift
//  Pryaniky
//
//  Created by Марк Шнейдерман on 12.02.2021.
//

import UIKit
import FittedSheets

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let networkManager = NetworkManager()
    var dataSource = [MyData]()
    var viewModel = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure_tableView()
        setData()
    }

    func setData(){
        //MARK: - Network Block
        self.networkManager.getData { [weak self] (model, error) in
                if error != nil {
                    print("Error:\(error?.localizedDescription)")
                }
                guard let model = model else {return}
                DispatchQueue.main.async {
                self?.dataSource = model.data
                self?.viewModel = model.view
                self?.tableView.reloadData()
                }
        }
    }
    
    //MARK: - Configure TableView
    func configure_tableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }

}


  //MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let str = viewModel[indexPath.row]
        cell.textLabel?.text = str
        return cell
    }
}


  //MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //we use  Fitted Sheets
        let controller = DetailViewController()
        switch self.viewModel[indexPath.row] {
        case "hz":
            controller.myData = dataSource[0]
        case "picture":
            controller.myData = dataSource[1]
        case "selector":
            controller.myData = dataSource[2]
        default:
            print("Error")
        }
        let sheet = SheetViewController(controller: controller, sizes: [.percent(0.5)])
        present(sheet, animated: false)
    }
}
