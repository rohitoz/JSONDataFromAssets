//
//  ViewController.swift
//  Round3_JsonParse_RohitNikam
//
//  Created by Geekyworks on 03/09/20.
//  Copyright © 2020 Rohit Nikam. All rights reserved.
//

import UIKit

struct Countries: Codable {
    var data:[Country]
}
    
struct Country: Codable{
    var country_id : String
    var country_code: String
    var country_name: String
    var status: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [Country]()
    var searchCountry = [Country]()
    
    var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        loadData()
        
    }
    
    func loadData() {
        
        if let fileLocation = Bundle.main.url(forResource: "countryList", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(Countries.self, from: data)
                let finalData = dataFromJson.data
                

                for data in finalData {
                    countries.append(data)
                    print(data.country_code)
                }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchCountry.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! JsonDataTableViewCell
        
        if searching {
            cell.countryIdLabel.text = "Country Id: " + String(searchCountry[indexPath.row].country_id)
            cell.countryCodeLabel.text = "Country Code: " + String(searchCountry[indexPath.row].country_code)
            cell.countryNameLabel.text = "Country Name: " + String(searchCountry[indexPath.row].country_name)
            cell.countryStatusLabel.text = "Country Status: " + String(searchCountry[indexPath.row].status)
        } else {
            cell.countryIdLabel.text = "Country Id: " + String(countries[indexPath.row].country_id)
            cell.countryCodeLabel.text = "Country Code: " + String(countries[indexPath.row].country_code)
            cell.countryNameLabel.text = "Country Name: " + String(countries[indexPath.row].country_name)
            cell.countryStatusLabel.text = "Country Status: " + String(countries[indexPath.row].status)
        }
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCountry = countries.filter({$0.country_name.lowercased().prefix(searchText.count) == searchText.lowercased() })
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

