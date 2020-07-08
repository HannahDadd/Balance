//
//  ContentView.swift
//  Balance
//
//  Created by Hannah Billingsley-Dadd on 06/07/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private var eventCalendarManager: EventsCalendarManager = EventsCalendarManager()
    var body: some View {
        HStack {
            Button(action: {
                self.eventCalendarManager.authWithCalendar()
            }) {
                Text("Hit me")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
