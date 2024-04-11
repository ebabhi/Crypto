//
//  StatisticView.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 02/04/2024.
//

import SwiftUI

struct StatisticView: View {
    
    var stat : StatisticModel
    
    var alignment : HorizontalAlignment
    
    private var hasIncreased : Bool {
        stat.percentageChange! >= 0
    }
    
    
    init(stat: StatisticModel, alignment: HorizontalAlignment = .center) {
        self.stat = stat
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: alignment ){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
            if let percentageChange = stat.percentageChange{
                HStack{
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(Angle(degrees: hasIncreased ? 0 : 180 ))
                    Text((percentageChange/100).format(.percent))
                        .font(.caption)
                }
                .font(.caption2)
                .foregroundStyle(hasIncreased ? Color.theme.green : Color.theme.red)
            }
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.statisticModels.first!)
}
