//
//  EventStoreManager.swift
//  Balance
//
//  Created by Eleanor Keane on 08/07/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import Foundation

import EventKit
import EventKitUI


enum CustomError: Error {
    case calendarAccessDeniedOrRestricted
    case eventNotAddedToCalendar
    case eventAlreadyExistsInCalendar
}


typealias EventsCalendarManagerResponse = (_ result: Result<Bool, CustomError>) -> Void

class EventsCalendarManager: NSObject {
    
    var eventStore: EKEventStore!
    
    override init() {
        eventStore = EKEventStore()
    }
    
    private func requestAccess(completion: @escaping EKEventStoreRequestAccessCompletionHandler) {
        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
            completion(accessGranted, error)
        }
    }
    
    private func getAuthorizationStatus() -> EKAuthorizationStatus {
        return EKEventStore.authorizationStatus(for: EKEntityType.event)
    }
    
    func authWithCalendar() {
        let authStatus = getAuthorizationStatus()
        switch authStatus {
        case .authorized:
            print("yay I'm in")
            getAllEvents()
        case .notDetermined:
            //Auth is not determined
            //We should request access to the calendar
            requestAccess { (accessGranted, error) in
                if accessGranted {
                    print("i feel like something is wrong")
                } else {
                    print("boo it didn't work")
                }
            }
        default:
            print("Complete failure.")
        }
    }
    
    func getAllEvents() {
        let calendars = eventStore.calendars(for: .event)
        for calendar in calendars {
            let start = Calendar.current.date(byAdding: DateComponents(day: -10), to: NSDate() as Date)!
            print("Start: " + start.description)
            let end = Calendar.current.date(byAdding: DateComponents(day: 10), to: start)!
            print("End: " + end.description)
            let predicate = eventStore.predicateForEvents(
                withStart: start,
                end: end,
                calendars: [calendar])
            print("Quantity: " + eventStore.events(matching: predicate).count.description)
            for event in eventStore.events(matching: predicate){
                //eventStore.enumerateEvents(matching: predicate){ (event, stop) in
                print("Event: " + event.title + event.startDate.description)
            }
        }
    }
    
}

// EKEventEditViewDelegate
extension EventsCalendarManager: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
