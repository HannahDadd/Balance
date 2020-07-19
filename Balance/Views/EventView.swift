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
    let formatter = DateFormatter()

    init(event: Event) {
        self.event = event
        formatter.dateFormat = "hh:mm"
    }

    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            VStack {
                Text(formatter.string(from: event.startDate)).font(.caption)
                Text(formatter.string(from: event.endDate)).font(.caption)
            }
            Spacer().frame(width: 30)
            Divider()
            Text(event.eventName)
        }
    }
}
