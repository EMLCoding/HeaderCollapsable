//
//  Message.swift
//  HeaderCollapsable
//
//  Created by Eduardo Martin Lorenzo on 16/6/22.
//

import SwiftUI

struct Message: Identifiable {
    var id = UUID().uuidString
    var message: String
    var userName: String
    var tintColor: Color
}

var allMessages: [Message] = [
    Message(message: "Podemos tocar la guitarra a lo Elvis", userName: "Lilo", tintColor: .red),
    Message(message: "Ohana significa familia", userName: "Stitch", tintColor: .blue),
    Message(message: "Y familia significa que estaremos siempre juntos", userName: "Lilo", tintColor: .red),
    Message(message: "Podemos tocar la guitarra a lo Elvis", userName: "Lilo", tintColor: .red),
    Message(message: "Ohana significa familia", userName: "Stitch", tintColor: .blue),
    Message(message: "Y familia significa que estaremos siempre juntos", userName: "Lilo", tintColor: .red),
    Message(message: "Podemos tocar la guitarra a lo Elvis", userName: "Lilo", tintColor: .red),
    Message(message: "Ohana significa familia", userName: "Stitch", tintColor: .blue),
    Message(message: "Y familia significa que estaremos siempre juntos", userName: "Lilo", tintColor: .red)
    
]
