//
//  LoginHelper.swift
//  Eventi
//
//  Created by iedstudent on 05/06/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import Foundation



//questa classe gestisce l'autentificazione: ci permette do leggere/salvare l'utente connesso sul database all'app
class LoginHelper {
    static var loggedUser: User?
    
    
    //salva l'utente connesso sul database
    static func save() {
        //trasformo l'oggetto "user" in un aray si bytes "data"
        let data = try? JSONEncoder().encode(loggedUser)
        
        //forzo il salvataggio immediato
        UserDefaults.standard.setValue(data, forKey: "LogedUser")
        
        //forzo il salvataggio immediato
        UserDefaults.standard.synchronize()
    }
    
    
    //caric0 l'utente connesso al database
    static func load() {
        //l'avevo salvato come un array di bytes "Data"
       let data = UserDefaults.standard.data(forKey: "LogedUser")
        
        //lo converto nuovamente in un oggetto "User"
        loggedUser = try? JSONDecoder().decode(User.self, from: data ?? Data())
    }
}
