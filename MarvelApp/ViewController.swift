//
//  ViewController.swift
//  MarvelApp
//
//  Created by Shubham Tunwal on 01/12/20.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fab_add: UIButton!
    
    var mList:[MarvelObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mList = []
        
     
        //load data from coredata
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MarvelEntity1", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MarvelEntity1")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                mList?.append(MarvelObject(mImg: UIImage(named:"\(data.value(forKey: "cdImg")!)"), mName: "\(data.value(forKey: "cdName")!)", mDesc: "\(data.value(forKey: "cdDescp")!)"))
            }
            
        } catch {
            
            print("Failed")
        }
        
        mList?.reverse()
        tableView.reloadData()
        
    }
    
    @IBAction func toAddVc(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "NewMarvelITemViewController") as! NewMarvelITemViewController
        next.vc  =  self
        self.present(next, animated: true, completion: nil)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "marvelCell", for: indexPath) as! MarvelListItemTableViewCell
        
        cell.img.image = mList![indexPath.row].mImg
        cell.name.text = mList![indexPath.row].mName
        cell.descp.text =  mList![indexPath.row].mDesc
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        deleteRow(name: mList![indexPath.row].mName!)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            do {
                deleteRow(name: mList![indexPath.row].mName!)
                
                mList?.remove(at: indexPath.row)
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    func deleteRow(name:String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MarvelEntity1")
        fetchRequest.predicate = NSPredicate(format: "cdName = %@", name)
        
        do
               {
                let test = try managedContext.fetch(fetchRequest)
                
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
                
               }
        catch
        {
            print(error)
        }
        
    }
}







