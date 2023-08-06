//
//  ContentView.swift
//  QRCodeScanner
//
//  Created by Suwijak Thanawiboon on 06.08.23.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @State var isPressentingScanner = false
    @State var scannedCode: String = "Scan a QR code to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr,],
            completion: {
                result in if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPressentingScanner = false
                }
                    
            }
        )
    }
    
    var body: some View {
        VStack (spacing: 10){
            Button {
                print("Button pressed")
                self.isPressentingScanner = true
            } label: {
                VStack {
                    Image(systemName: "camera")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Scan now")
                }
            }
            
            Text(scannedCode)
            .sheet(isPresented: $isPressentingScanner) {
                self.scannerSheet
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
