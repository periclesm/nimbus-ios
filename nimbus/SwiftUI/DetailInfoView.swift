//
//  DetailInfoView.swift
//  nimbus-SwiftUI
//
//  Created by Perikles Maravelakis on 28/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct DetailInfoView_Previews: PreviewProvider {
	static var previews: some View {
		DetailInfoView()
			.preferredColorScheme(.dark)
	}
}

struct DetailInfoView: View {
	var cloud: Cloud = Cloud()
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Information")
				.textCase(.uppercase)
				.foregroundColor(.secondary)
			Spacer()
			Text(cloud.detail!.detail)
		}
    }
}


