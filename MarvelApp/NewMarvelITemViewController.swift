//
//  NewMarvelITemViewController.swift
//  MarvelApp
//
//  Created by Shubham Tunwal on 02/12/20.
//

import UIKit
import CoreData
class NewMarvelITemViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var descp: UITextView!
    
    var vc:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.layer.borderWidth = 0.5
        name.layer.borderColor = UIColor.gray.cgColor
        name.layer.cornerRadius = 10
        
        descp.layer.borderWidth = 0.5
        descp.layer.borderColor = UIColor.gray.cgColor
        descp.layer.cornerRadius = 10
        

    }
    
    @IBAction func addData(_ sender: Any) {
        
        if ( name.text != "" || descp.text != "")
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "MarvelEntity1", in: context)
            
            let newObj = NSManagedObject(entity: entity!, insertInto: context)
            
            newObj.setValue(name.text, forKey: "cdName")
            newObj.setValue(descp.text, forKey: "cdDescp")

            //imgs
            var imgs:[String] = ["deadpool","deadpool","hulk","thanos"]
            
            var rnd:Int = Int(arc4random_uniform(3) + 0)
            
            newObj.setValue(imgs[rnd], forKey: "cdImg")

            do {
               try context.save()
              } catch {
               print("Failed saving")
            }
            
            vc?.viewDidLoad()
            self.dismiss(animated: true, completion: nil)
            
        }else
        {
            
            var alert = UIAlertController(title: "Invalid data", message: "Name and Description cannot be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        
        

        
        
    }
    

}
