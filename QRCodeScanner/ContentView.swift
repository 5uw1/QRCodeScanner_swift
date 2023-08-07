//
//  ContentView.swift
//  QRCodeScanner
//
//  Created by Suwijak Thanawiboon on 06.08.23.
//

import SwiftUI
import CodeScanner
import UniformTypeIdentifiers

struct ContentView: View {
    @State var isResultAvailable = false
    @State var isPressentingScanner = false
    @State var scannedCode: String = "Scan a QR code to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr,.dataMatrix,.code39,.code93,.code128],
            completion: {
                result in if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPressentingScanner = false
                    self.isResultAvailable = true
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
            
            if (isResultAvailable) {
                Button {
                    print(scannedCode)
                    UIPasteboard.general.string = scannedCode
                } label: {
                    VStack {
                        Image(systemName: "doc")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Copy to clipboard")
                    }
                }
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
