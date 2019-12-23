//
//  ContentView.swift
//  ObservableObject
//
//  Created by Christina S on 11/17/19.
//  Copyright © 2019 Schelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var product = Product.default
    @State private var showAlert = false
    @State private var showSheet = false
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text(product.name)
                    .font(.title)
                CardImageView(name: "shoes")
                    .padding(.bottom, 20)
                HStack(spacing: 60) {
                    Text("$"+String(product.currentPrice.rounded(2)))
                        .fontWeight(.bold)
                        .font(.headline)
                    VStack {
                        CurrentReviewsView(product: product)
                        LeaveReviewButtonView(showSheet: $showSheet, product: product)
                    }
                    .font(.caption)
                }
                .padding()
                AddToCartButtonView(showAlert: $showAlert)
                    .padding(.top, 20)
                Spacer()
            }
            .navigationBarTitle("Shoe Store", displayMode: .inline)
                .padding(.top, 50)
        }
    }
}

struct LeaveReviewButtonView: View {
    @Binding var showSheet: Bool
    @ObservedObject var product: Product
    var body: some View {
        Button(action: {
            withAnimation { self.showSheet.toggle() }
        }) {
            Text("Leave Review")
        }.sheet(isPresented: $showSheet, onDismiss: {
            // ...
        }) {
            VStack {
                Text("How would you rate this product?")
                RatingButtonView(product: self.product)
            }
        }
    }
}

struct CurrentReviewsView: View {
    @ObservedObject var product: Product
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                StarReviewsView(product: self.product, rating: index)
            }
        }
    }
}

struct RatingButtonView: View {
    @ObservedObject var product: Product
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                StarButtonView(product: self.product, rating: index)
            }
        }
    }
}


struct StarReviewsView: View {
    @ObservedObject var product: Product
    var rating: Int
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        image(for: product.rating)
            .foregroundColor(rating > self.product.rating ? self.offColor : self.onColor)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct StarButtonView: View {
    @ObservedObject var product: Product
    var rating: Int
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    var body: some View {
        image(for: rating)
            .foregroundColor(rating > self.product.rating ? self.offColor : self.onColor)
            .onTapGesture {
                self.product.rating = self.rating
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct AddToCartButtonView: View {
    @Binding var showAlert: Bool
    var body: some View {
        Button(action: {
           self.showAlert.toggle()
        }) {
            Text("Add to Cart")
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Added to Cart!"), message: nil, dismissButton: .default(Text("Got it!")))
        }.frame(width: 200.0)
        .padding()
        .background(Color.salmon)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.gray, lineWidth: 1.5)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Double {
    func rounded(_ digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

extension Color {
    static let salmon = Color("salmon")
}
