//
//  ChatViewController.swift
//  ParseLab
//
//  Created by Roger Hu on 9/26/17.
//  Copyright © 2017 Roger Hu. All rights reserved.
//

import Parse
import ParseLiveQuery
import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    var messages : [Message]!
    var client : ParseLiveQuery.Client!
    var subscription : Subscription<Message>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let messagesQuery = Message.query()!
                .whereKeyExists("text")
                .order(byAscending: "createdAt") as! PFQuery<Message>

        messagesQuery.findObjectsInBackground { ( results: [Message]?, error: Error?) in
            if let results = results {
                for result in results {
                    self.messages.insert(result, at: 0)
                }
                self.reloadTableData()

            }
        }

        client = ParseLiveQuery.Client()
        subscription = client
            .subscribe(messagesQuery)
            .handle(Event.created) { _, message in

                DispatchQueue.main.async {
                    self.messages.insert(message, at: 0)
                    self.reloadTableData()
                }
        }

        messages = []
        tableView.delegate = self
        tableView.dataSource = self
        self.reloadTableData()

    }

    func reloadTableData() {
        self.tableView.reloadData()
    }

    @IBAction func onSend(_ sender: Any) {
        let msgText = msgTextField.text!

        if (msgText.characters.count >= 0) {
            let message = Message()
            message.text = msgTextField.text
            message.saveInBackground(block: { (success: Bool, error) in
                if (error != nil) {
                    print("Error: \(error!)")
                } else {
                    print("Success: \(success)")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITableViewDelegate {

}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = messages[indexPath.row].text
        return cell
    }
}
