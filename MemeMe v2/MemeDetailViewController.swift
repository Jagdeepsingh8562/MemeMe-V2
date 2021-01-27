//
//  MemeDetailViewController.swift
//  MemeMe v2
//
//  Created by Jagdeep Singh on 27/01/21.
//

import UIKit

class MemeDetailViewController: UIViewController {
    var selectedImage:UIImage = UIImage()
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = selectedImage
        
    }
    
}
