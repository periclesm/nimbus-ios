//
//  Detail.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI



struct DetailView: View {
	var cloud: Cloud = Cloud()
	
	var body: some View {
        ScrollView {
            DetailImageView(imageURL: cloud.detail?.image)
            DetailHeaderView(cloud: cloud)
            DetailInfoView(cloud: cloud)
        }
        .navigationTitle(cloud.name)
	}
	
	func getImage(imageURL: String?) -> UIImage {
		return UIImage(named: "")!
	}
}

struct Detail_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			DetailView(/*cloud: cloud*/)
		}
	}
}








