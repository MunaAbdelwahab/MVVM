//
//  PersonListViewController.swift
//  MVVM
//
//  Created by Muna Abdelwahab on 3/24/21.
//

import UIKit

class PersonListViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var personList = [Person]()
    
    var ViewModel : PersonListViewModelProtocol? {
        didSet {
            ViewModel?.listingDidChange = { [self] vm in
                personList = vm.listing!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://learnappmaking.com/ex/users.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            do{
                let decoder = JSONDecoder()
                let personArray = try decoder.decode([Person].self, from: data!)
                ViewModel = personViewModel(person: personArray)
            }catch let error{
                print(error)
            }
        }
        task.resume()
        activityIndicatorView.startAnimating()
    }
    
    @IBAction func ReloadData(_ sender: Any) {
        ViewModel?.showData()
        tableView.reloadData()
        activityIndicatorView.stopAnimating()
    }
    
}

extension PersonListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonListViewController")
        cell?.textLabel?.text = personList[indexPath.row].first_name
        cell?.detailTextLabel?.text = String(personList[indexPath.row].age)
        return cell!
    }

}
