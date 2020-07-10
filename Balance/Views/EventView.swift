//
//  EventView.swift
//  Balance
//
//  Created by Hannah Billingsley-Dadd on 10/07/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import SwiftUI

struct EventView: View {
    private let event : Event

    init(event: Event) {
        self.event = event
    }

    var body: some View {
        Text(event.eventName)
    }
}
