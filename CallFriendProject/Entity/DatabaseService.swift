//
//  DatabaseService.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 06.05.2023.
//

import Foundation
import FirebaseFirestore
import Firebase

class DatabaseService{
    
    /* User object struct :
         username: String
         isActive: Bool
     */
    
    static let db = Firestore.firestore()
    
    static let collectionName = "users"
    static let usernameField = "username"
    static let isActiveField = "isActive"
    
    
    static func addUser(username: String, uid: String){
        do {
            print("uid \(uid)")
            try DatabaseService.db.collection(DatabaseService.collectionName).document(uid).setData([
                DatabaseService.usernameField: username,
                DatabaseService.isActiveField: true
            ])
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    static func setCurrentUserToActive(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = DatabaseService.db.collection(DatabaseService.collectionName).document(uid)
        docRef.updateData([
            DatabaseService.isActiveField: true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
    }
    
    static func setCurrentUserToInActive(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = DatabaseService.db.collection(DatabaseService.collectionName).document(uid)
        docRef.updateData([
            DatabaseService.isActiveField: false
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
    }
    
    static func getCurrentUserName(resCompletion: @escaping (String) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = DatabaseService.db.collection(DatabaseService.collectionName).document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let res = document.data()?[DatabaseService.usernameField] as? String else {
                    
                    return
                }
                resCompletion(res)
            } else {
                print("User don't exist")
                return
            }
        }
    }
    
    static func getActiveUsers(completion: @escaping ([String]) -> ()){
        DatabaseService.db.collection(DatabaseService.collectionName).whereField(DatabaseService.isActiveField, isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let users = querySnapshot!.documents.map{ $0.data()[DatabaseService.usernameField] as! String }
                    if let myUsername = UserDefaults.standard.string(forKey: UserSettingKey.name){
                        let filteredUsers = users.filter{$0 != myUsername}
                        completion(filteredUsers)
                    }
                }
        }
    }
}
