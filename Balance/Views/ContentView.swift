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

    @State var events : [Event] = []

    var body: some View {
        List(events) { event in
            EventView(event: event)
        }.onAppear {
            self.events = self.eventCalendarManager.authWithCalendar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
