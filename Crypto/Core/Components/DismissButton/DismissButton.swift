//
//  DismissView.swift
//  Crypto
//
//  Created by ebpearls on 4/4/2024.
//

import SwiftUI

struct DismissButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .onTapGesture {
                dismiss()
            }
    }
}

#Preview {
    DismissButton()
}
