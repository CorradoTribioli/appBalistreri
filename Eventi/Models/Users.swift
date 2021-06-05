//
//  users.swift
//  Eventi
//
//  Created by iedstudent on 22/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.

import Foundation

//utilizziamo il protovollo 'Cordable' per convertire automaticamenteun Dictionary in uno User, e viceversa
class User : Codable{
        var id_utente: Int?
        var auth_token: String?
        var email: String?
        var nome: String?
        var cognome: String?
        var avatar_url: String?
        var data_nascita: String?
        var citta: String?
        var credito: Int?
        var timestamp: String?
}
