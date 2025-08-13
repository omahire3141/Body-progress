//
//  CustomBarButton.swift
//  BodyProgress
//

import SwiftUI

struct CustomBarButton: View {
    
    var title: String
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        Text(title)
            .bold()
            .foregroundColor(.white)
            .padding(10)
            .background(appSettings.themeColorView())
            .frame(height: 30)
            .cornerRadius(15)
    }
}

struct CustomBarButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBarButton(title: "Save")
    }
}
