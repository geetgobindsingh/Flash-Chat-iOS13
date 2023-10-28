//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Geet Gobind Singh on 21/10/2019.
//  Copyright © 2019 Geet Gobind Singh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var chatManager : ChatManager?
    
    override func viewWillAppear(_ animated: Bool) {
        title = K.appName
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        chatManager = ChatManager()
        chatManager?.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
 
    
    func loadMessages() {
        chatManager?.loadMessage()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            chatManager?.sendMessage(sender: messageSender, body: messageBody)
            messageTextfield.text = ""
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatManager?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCellTableViewCell
        
        let message = chatManager?.messages[indexPath.row]
        let email = message?.sender
        let body = message?.body
        
        cell.messageLabel?.text = body
        
        // Message from current logged in user
        if message?.sender == Auth.auth().currentUser?.email {
            cell.otherPersonAvatarImageView.isHidden = true
            cell.avatarImageView.isHidden = false
            cell.speechBubbleBackgroundView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.otherPersonAvatarImageView.isHidden = false
            cell.avatarImageView.isHidden = true
            cell.speechBubbleBackgroundView.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor.white
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
//     
}

//MARK: - ChatManagerDelegate
extension ChatViewController: ChatManagerDelegate {
    func reloadData(_ chatManager: ChatManager) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            var index = 0
            if (chatManager.messages.count > 0) {
                index = chatManager.messages.count - 1
            }
           
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
        }
    }
}
