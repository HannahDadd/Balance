//
//  Event.swift
//  Balance
//
//  Created by Hannah Billingsley-Dadd on 10/07/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import Foundation

class Event: Identifiable {
    let id = UUID()
    let eventName : String

    init(eventName: String) {
        self.eventName = eventName
    }
}
