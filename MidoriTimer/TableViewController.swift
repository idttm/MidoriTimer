//
//  TableViewController.swift
//  MidoriTimer
//
//  Created by Andrew Cheberyako on 07.05.2021.
//

import UIKit

class TableViewController: UITableViewController {

    var test = ParseJSON.shared.test

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseJSON.shared.loadJson()

    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return test.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let jsonData = test[indexPath.row]
        
        cell.textLabel?.text = jsonData.title

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "showNote" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let navigaionVC = segue.destination as? NoteViewController
        let object = test[indexPath.row]
//        let object = fetchResultController.object(at: indexPath)
        navigaionVC?.noteArrayDate.append(object)
        print(object)
    }
    

}
