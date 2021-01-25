//
//  TabbarController.swift
//  MemeMe v2
//
//  Created by Jagdeep Singh on 25/01/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var addMemeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func addMemeAction(_ sender: Any) {
        let memeVC = storyboard?.instantiateViewController(identifier: "MemeEditViewController") as! MemeEditViewController
//               present(memeVC, animated: true, completion: nil)
        present(memeVC, animated: true) 
            
        
        
    }
    
    
}
