//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jesutofunmi Adewole on 24/07/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNP5IMH0Y3Vr9zSnrN6rZiT2wvG2fNI5FlYQ&s")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button ("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you for ordering!", isPresented: $showingConfirmation) { } message: {
            Text(confirmationMessage)
        }
        .alert("Unable to process your order", isPresented: $showingError) { } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        do {
            let(data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        } catch {
            
            errorMessage = "We can't process your order right now, please try again later"
            showingError = true
            print("Check out failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
