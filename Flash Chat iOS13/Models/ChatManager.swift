//
//  ChatManager.swift
//  Flash Chat iOS13
//
//  Created by Geet Gobind Singh on 20/04/23.
//  Copyright © 2023 Geet Gobind Singh. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol ChatManagerDelegate {
    func reloadData(_ chatManager: ChatManager)
}

class ChatManager {
    
    let fireStoreDb = Firestore.firestore()
    
    var delegate: ChatManagerDelegate?
    
    var messages :[Message] = []
    
    func loadMessage() {
        fireStoreDb.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            if let e = error {
                print("There was issue loading data from firestore: \(e)")
            } else {
                if let querySnapshotDocuments = querySnapshot?.documents {
                    
                    self.messages = []
                    
                    for doc in querySnapshotDocuments {
                        let data = doc.data()
                        
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let message = Message(sender: messageSender, body: messageBody)
                            self.messages.append(message)
                        }
                    }
                    
                    self.delegate?.reloadData(self)
                }
            }
        }
    }
    
    func sendMessage(sender: String, body: String) {
        fireStoreDb.collection(K.FStore.collectionName)
            .addDocument(data: [K.FStore.senderField: sender,
                                K.FStore.bodyField: body,
                                K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was issue saving data in firestore: \(e)")
                } else {
                    print("Message Sent.")
                }
        }
    }
}
