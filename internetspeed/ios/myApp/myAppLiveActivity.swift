//
//  myAppLiveActivity.swift
//  myApp
//
//  Created by Rakesh kundan on 11/30/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct myAppAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct myAppLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: myAppAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension myAppAttributes {
    fileprivate static var preview: myAppAttributes {
        myAppAttributes(name: "World")
    }
}

extension myAppAttributes.ContentState {
    fileprivate static var smiley: myAppAttributes.ContentState {
        myAppAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: myAppAttributes.ContentState {
         myAppAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: myAppAttributes.preview) {
   myAppLiveActivity()
} contentStates: {
    myAppAttributes.ContentState.smiley
    myAppAttributes.ContentState.starEyes
}
