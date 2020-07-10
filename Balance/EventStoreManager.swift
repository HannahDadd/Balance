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
    
    func authWithCalendar() -> [Event] {
        let authStatus = getAuthorizationStatus()
        switch authStatus {
        case .authorized:
            print("yay I'm in")
            return getTodaysEvents()
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
        return []
    }
    
    private func getTodaysEvents() -> [Event] {
        let calendars = eventStore.calendars(for: .event)
        for calendar in calendars {
            let start = Calendar.current.date(byAdding: DateComponents(day: 0), to: NSDate() as Date)!
            let end = Calendar.current.date(byAdding: DateComponents(day: 1), to: start)!
            let predicate = eventStore.predicateForEvents(
                withStart: start,
                end: end,
                calendars: [calendar])
            return eventStore.events(matching: predicate).map { Event(eventName: $0.title) }
        }
        return []
    }
    
}

// EKEventEditViewDelegate
extension EventsCalendarManager: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
