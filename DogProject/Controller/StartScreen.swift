//
//  StartScreen.swift
//  DogProject
//
//  Created by Роман Зобнин on 30.10.2021.
//

import UIKit

class StartScreen: UIViewController {

    var breedArrayString:[String] = []
    let loading = breedLoader()
    let back = backButton()
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak var TableBreed: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Doggies"
        self.navigationItem.largeTitleDisplayMode = .always
        self.TableBreed.dataSource = self
        self.TableBreed.delegate = self
        loading.delegate = self
        loading.request()
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        TableBreed.refreshControl = myRefreshControl
    }
}

extension StartScreen: UITableViewDataSource, UITableViewDelegate, breedDelegate {
    func saveBreeds(nameBreed: [String]) {
        self.breedArrayString = nameBreed
        spinner.stopAnimating()
        TableBreed.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.breedArrayString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableBreed.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let exmp = breedArrayString[indexPath.row]
        cell.textLabel?.text = exmp
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let breedName = breedArrayString[indexPath.row]
       performSegue(withIdentifier: "goTo", sender: breedName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTo", let name = sender as? String {
            let dest = segue.destination as! CollectionImageViewController
            dest.name = name
            let backItemNC = back.backItemTitle()
            navigationItem.backBarButtonItem = backItemNC
        }
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        loading.request()
        TableBreed.reloadData()
        sender.endRefreshing()
    }
}

