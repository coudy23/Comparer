//
//  ViewController.swift
//  Comparer
//
//  Created by Karol Cápay on 15/11/2018.
//  Copyright © 2018 Karol Cápay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var products: [Products] = []
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "productDetail", sender: nil)
    }
    
    @IBAction func yearSliderChange(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = products[indexPath.row]
            cell.textLabel?.text = task.name
            cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let myProduct = products[indexPath.row]
            context.delete(myProduct)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            getData()
        }
        tableView.reloadData()
    }
    
    func getData() {
        do {
            products = try context.fetch(Products.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail" {
            let controller = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.product = products[indexPath.row]
            } else {
                controller.product = Products(context: context)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "productDetail", sender: nil)
    }
    
    @IBAction func unwindFromProductDetail(_ sender: UIStoryboardSegue) {
        print("jkhjkhk")
        if let senderVC = sender.source as? DetailViewController {
            if let saved = senderVC.saved {
                print ("saved")
                if let detailProduct = senderVC.product {
                    if let selectedIndexPath = tableView.indexPathForSelectedRow {
                        products[selectedIndexPath.row] = detailProduct
                        print(detailProduct)
                    } else {
                        products.append(detailProduct)
                    }
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
        }
        tableView.reloadData()
    }
    
}

