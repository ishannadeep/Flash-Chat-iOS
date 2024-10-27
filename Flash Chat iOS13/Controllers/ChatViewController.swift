//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    var messages : [Message] = [
        Message(sender: "ishantest@gmail.com", body: "hey!"),
        Message(sender: "devantest@gmail.com", body: "haii!"),
        Message(sender: "ishantest@gmail.com", body: "fuck off!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.title
        navigationItem.hidesBackButton = true
        tableView.dataSource = self;
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            // Add a new document with a generated ID
                db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField:message
                ]) { (Error) in
                    if let e = Error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else{
                        print("Successfully saved data")
                    }
                }

        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            as! MessageCell
        cell.label?.text = messages[indexPath.row].body
        return cell
    }
    
    
}
