//
//  NoteViewController.swift
//  MidoriTimer
//
//  Created by Andrew Cheberyako on 07.05.2021.
//

import UIKit

class NoteViewController: UIViewController {

    
    var noteArrayDate = [TestElement]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteMessageTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = detectTitle()
        noteMessageTextView.text = detectNote()

       
    }
    
    func detectTitle () -> String {
        
        var title = " "
        for title1 in noteArrayDate {
            title = title1.title
        }
        return title
    }
    func detectNote () -> String {
        var note = " "
        for note1 in noteArrayDate {
            note = note1.note
        }
        return note
    }
    
    

}
