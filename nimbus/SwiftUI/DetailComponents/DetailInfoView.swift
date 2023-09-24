//
//  DetailInfoView.swift
//  nimbus-SwiftUI
//
//  Created by Perikles Maravelakis on 28/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct DetailInfoView: View {
	var cloud: Cloud = Cloud()
	
    var body: some View {
		VStack(alignment: .leading) {
            Text("Information")
                .font(.subheadline)
                .padding(.leading, 10.0)
				.textCase(.uppercase)
				.foregroundColor(.secondary)
			Spacer()
            Text(cloud.detail?.detail ?? "Nimbostratus is a former \"Family C\" low-level stratiform genus that is now classified by the World Meteorological Organization (WMO) as a vertical or multi-level stratus type because it forms in the middle level or étage of the troposphere and usually spreads vertically into the low and high étages. This change in classification would once have made it a \"Family D\" cloud, but this style of nomenclature was discontinued by the WMO in 1956.")
                .font(.body)
                .padding(.horizontal, 10.0)
		}
    }
}

struct DetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfoView()
    }
}
