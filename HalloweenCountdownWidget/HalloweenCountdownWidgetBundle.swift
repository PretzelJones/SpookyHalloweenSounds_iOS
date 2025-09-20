//
//  HalloweenCountdownWidgetBundle.swift
//  HalloweenCountdownWidget
//
//  Created by Sean Patterson on 9/16/25.
//

import WidgetKit
import SwiftUI

@main
struct HalloweenCountdownWidgetBundle: WidgetBundle {
    var body: some Widget {
        HalloweenCountdownWidget()
        HalloweenCountdownWidgetControl()
        HalloweenCountdownWidgetLiveActivity()
    }
}
