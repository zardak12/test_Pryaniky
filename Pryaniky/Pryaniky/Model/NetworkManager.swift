//
//  NetworkManager.swift
//  Pryaniky
//
//  Created by Марк Шнейдерман on 12.02.2021.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getData(completion: @escaping(Model?,AFError?)->Void)
}


class NetworkManager : NetworkManagerProtocol {
    
    let url = "https://pryaniky.com/static/json/sample.json"
    
    //MARK: - Get Data with Alamofire
    func getData(completion: @escaping(Model?,AFError?)->Void){
        
        AF.request(url).responseDecodable(of: Model.self) { response in
            guard let ourData = response.value else { return }
            DispatchQueue.main.async {
                completion(ourData,response.error)
            }
        }
    }
}
