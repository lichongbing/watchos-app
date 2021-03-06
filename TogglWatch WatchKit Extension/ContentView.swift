//
//  ContentView.swift
//  TogglWatch WatchKit Extension
//
//  Created by Ricardo Sánchez Sotres on 15/10/2019.
//  Copyright © 2019 Toggl. All rights reserved.
//

import SwiftUI
import Combine
import TogglTrack

var combinedReducer: Reducer<AppState, AppAction, AppEnvironment, AppAction> = combine(
    appReducer,
    pullback(timelineReducer,
             state: \AppState.timeEntriesState,
             action: \AppAction.timeline,
             environment: \AppEnvironment.timeEntriesEnvironment),
    pullback(createEntityReducer(),
             state: \.timeline.workspaces,
             action: \.workspaces,
             environment: \.api),
    pullback(createEntityReducer(),
             state: \.timeline.clients,
             action: \.clients,
             environment: \.api),
    pullback(createEntityReducer(),
             state: \.timeline.projects,
             action: \.projects,
             environment: \.api),
    pullback(createEntityReducer(),
             state: \.timeline.tasks,
             action: \.tasks,
             environment: \.api),
    pullback(createEntityReducer(),
             state: \.timeline.tags,
             action: \.tags,
             environment: \.api),
    pullback(loginReducer,
             state: \.user,
             action: \.user,
             environment: \.loginEnvironment
    )
)

struct ContentView: View
{
    @ObservedObject var store: Store<AppState, AppAction, AppEnvironment>
        
    init(store: Store<AppState, AppAction, AppEnvironment>)
    {
        self.store = store
        self.store.send(.user(.loadAPITokenAndUser))
    }
    
    var body: some View {
        ZStack {
            if(self.store.state.user == nil) {
                OnboardingView()
                    .environmentObject(store)
            } else {
                TimelineView()
                    .environmentObject(store)
                    .contextMenu(menuItems: {
                        Button(
                            action: { self.store.send(.loadAll(force: true)) },
                            label: {
                                VStack {
                                    Image(systemName: "arrow.counterclockwise")
                                    Text("Refresh")
                                }
                        })
                        Button(
                            action: { self.store.send(.user(.logout)) },
                            label: {
                                VStack {
                                    Image("logout")
                                    Text("Sign out")
                                }
                        })
                    })
            }
            if self.store.state.loading {
                if self.store.state.user == nil {
                    VStack {
                        ZStack {
                            Rectangle().foregroundColor(Color.black)
                            Text("Signing in...")
                                .font(.footnote)
                        }
                    }
                } else {
                    VStack {
                        ZStack {
                            Rectangle().foregroundColor(Color.togglBlue)
                            Text("Syncing...")
                                .font(.footnote)
                        }
                        .frame(height: 15)
                        Spacer()
                    }
                }
            }
        }
    }
}

