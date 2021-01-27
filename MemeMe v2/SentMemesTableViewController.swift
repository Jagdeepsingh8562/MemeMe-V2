//
//  SentMemesTableViewController.swift
//  MemeMe v2
//
//  Created by Jagdeep Singh on 24/01/21.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    @IBOutlet weak var memesTableView: UITableView!
    
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        memesTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memes.remove(at: indexPath.row)
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeVC = storyboard?.instantiateViewController(identifier: "MemeViewController") as! MemeDetailViewController
        memeVC.selectedImage = memes[indexPath.row].memedImage
        navigationController?.pushViewController(memeVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        let meme = memes[indexPath.row]
        cell.tableImageView?.image = meme.memedImage
        cell.tableTextLabel?.text = "\(meme.topText)...\(meme.bottomText)"
        return cell
    }
    
}
