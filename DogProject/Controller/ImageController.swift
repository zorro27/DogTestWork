//
//  ImageController.swift
//  DogProject
//
//  Created by Роман Зобнин on 06.11.2021.
//

import UIKit

class ImageController: UIViewController {
    
    @IBOutlet weak var PhotoDog: UIImageView!
    var image: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentImage(image: image)
        react()
    }
}

extension ImageController {
    func presentImage (image: String){
           let url = URL(string: image)!
           let imageData = try? Data(contentsOf: url)
           PhotoDog.image = UIImage(data: imageData!)
       }
    
    func react () {
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(tappedMe))
        PhotoDog.addGestureRecognizer(tap)
        PhotoDog.isUserInteractionEnabled = true
    }
    
    @objc func tappedMe(){
        let shareController = UIActivityViewController(activityItems: [PhotoDog.image!], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
}
