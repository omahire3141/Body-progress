//
//  ContentView.swift
//  BodyProgress
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        TabView(selection: $appSettings.selectedTab) {
            WorkoutFilterView().environmentObject(self.appSettings).tabItem {
                Image(systemName: "flame")
                    .imageScale(.large)
                Text("Workout")
            }.tag(0)
            
            WokroutHistoryTabView().environmentObject(self.appSettings).tabItem {
                Image(systemName: "clock")
                    .imageScale(.large)
                Text("History")
            }.tag(1)
            
            SettingsView().environmentObject(self.appSettings).tabItem {
                Image(systemName: "gear")
                    .imageScale(.large)
                Text("Settings")
            }.tag(2)
            
            AIAnalyzeView().environmentObject(self.appSettings).tabItem {
                Image(systemName: "brain")
                    .imageScale(.large)
                Text("AI Analyze")
            }.tag(3)
        }
        .onAppear(perform: {
            kAppDelegate.configureAppearances(color: AppThemeColours.allCases[self.appSettings.themeColorIndex].uiColor())
        })
        .accentColor(appSettings.themeColorView())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppSettings())
    }
}
