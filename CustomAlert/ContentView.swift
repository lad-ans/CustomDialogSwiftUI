//
//  ContentView.swift
//  CustomAlert
//
//  Created by ladans on 04/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showCustomAlert: Bool = false
    @State private var showAlert: Bool = false
    @State private var showPopover: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        showCustomAlert.toggle()
                    }
                } label: {
                    Label {
                        Text("Show Custom Alert")
                    } icon: {
                        Image(systemName: "play.circle.fill")
                    }
                }
                
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        showAlert.toggle()
                    }
                } label: {
                    Label {
                        Text("Show Alert")
                    } icon: {
                        Image(systemName: "play.circle.fill")
                    }
                }
                
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        showPopover.toggle()
                    }
                } label: {
                    Label {
                        Text("Show Confirmation Dialog")
                    } icon: {
                        Image(systemName: "play.circle.fill")
                    }
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Hey dude!"),
                message: Text("Widh to cancel this operation?"),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .destructive(Text("Continue"))
            )
        }
        .confirmationDialog(
            "Hey there 👋",
            isPresented: $showPopover,
        ) {
            Button("Cancel") {
                
            }
            
            Button("Continue") {
                
            }
        } message: {
            Text("That the message!")
        }
        .customAlert(
            showAlert: $showCustomAlert,
            title: "Hey there!",
            message: "A custom alert here! How are you doing?",
            onPrimaryAction: {
                withAnimation(.spring(duration: 0.3)) {
                    showCustomAlert.toggle()
                }
            },
            onSecondaryAction: {
                withAnimation(.spring(duration: 0.3)) {
                    showCustomAlert.toggle()
                }
            }
        )
    }
}

extension View {
    func customAlert(
        showAlert: Binding<Bool>,
        title: String,
        message: String,
        onPrimaryAction: @escaping () -> Void,
        onSecondaryAction: @escaping () -> Void
    ) -> some View {
        modifier(
            CustomAlert(
                showAlert: showAlert,
                title: title,
                message: message,
                onPrimaryAction: onPrimaryAction,
                onSecondaryAction: onSecondaryAction
            )
        )
    }
}

struct CustomAlert: ViewModifier {
    var showAlert: Binding<Bool>
    let title: String
    let message: String
    let onPrimaryAction: () -> Void
    let onSecondaryAction: () -> Void
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            let offset = showAlert.wrappedValue
            ? 0
            : proxy.frame(in: .global).height + proxy.safeAreaInsets.bottom
            
            content
                .overlay {
                    VStack(spacing: 20) {
                        Text(title)
                            .font(.title.bold())
                        
                        Text(message)
                            .font(.body)
                        
                        HStack {
                            Button(action: onPrimaryAction) {
                                Text("Cancel")
                                    .padding()
                                    .controlSize(.regular)
                                    .buttonSizing(.fitted)
                                    .frame(width: 140)
                                    .background(.blue.gradient)
                                    .clipShape(Capsule())
                            }
                            
                            Button(action: onSecondaryAction) {
                                Text("Continue")
                                    .padding()
                                    .controlSize(.regular)
                                    .buttonSizing(.fitted)
                                    .frame(width: 140)
                                    .background(.red.gradient)
                                    .clipShape(Capsule())
                            }
                        }
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    }
                    .padding(20)
                    .frame(width: 340)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 44.4)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center)
                    .offset(y: offset)
                }
        }
    }
}

#Preview {
    ContentView()
}
