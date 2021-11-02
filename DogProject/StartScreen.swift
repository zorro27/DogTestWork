//
//  StartScreen.swift
//  DogProject
//
//  Created by Роман Зобнин on 30.10.2021.
//

import UIKit

class StartScreen: UIViewController {

    var breedArray:[Breed] = []
    let urlString = "https://dog.ceo/api/breeds/list/all"
    
    @IBOutlet weak var TableBreed: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Doggies"
        self.TableBreed.dataSource = self
        self.TableBreed.delegate = self
        breedArray.append(Breed(name: "A"))
        breedArray.append(Breed(name: "B"))
        breedArray.append(Breed(name: "C"))
        self.navigationItem.largeTitleDisplayMode = .always
    }
}

extension StartScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.breedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableBreed.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let exmp = breedArray[indexPath.row]
        cell.textLabel?.text = exmp.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nameCellRow = breedArray[indexPath.row]
        performSegue(withIdentifier: "goTo", sender: nameCellRow)
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        guard let vc = storyboard.instantiateViewController(identifier: "CollectionImageViewController") as? CollectionImageViewController else {return}
//        vc.name = nameCellRow
//        let backItem = UIBarButtonItem()
//            backItem.title = ""
//            navigationItem.backBarButtonItem = backItem
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTo", let name = sender as? Breed {
            let dest = segue.destination as! CollectionImageViewController
            dest.name = name.name
            let backItem = UIBarButtonItem()
                        backItem.title = ""
                        navigationItem.backBarButtonItem = backItem
        }
    }
}
