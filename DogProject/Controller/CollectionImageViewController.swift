//
//  CollectionImageViewController.swift
//  DogProject
//
//  Created by Роман Зобнин on 30.10.2021.
//

import UIKit


class CollectionImageViewController: UICollectionViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var name: String = ""
    var breedsArrayImages: [String] = []
    var loading = breedLoaderImage()
    let back = backButton()
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = name
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        loading.delegate = self
        loading.request(name: name)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        collectionView.refreshControl = myRefreshControl
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedsArrayImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        if let url = URL(string: self.breedsArrayImages[indexPath.item]){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    cell.dogImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
}

extension CollectionImageViewController: UICollectionViewDelegateFlowLayout, breedImageDelegate{
  
    func saveBreedsImage(string: [String]) {
        self.breedsArrayImages = string
        spinner.stopAnimating()
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "imageController") as! ImageController
        vc.image = breedsArrayImages[indexPath.item]
        let backItemVC = back.backItemTitle()
        navigationItem.backBarButtonItem = backItemVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = sectionInserts.left * (itemsPerRow+1)
        let availableWidth = collectionView.frame.width - padding
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        loading.request(name: name)
        collectionView.reloadData()
        sender.endRefreshing()
    }
}

