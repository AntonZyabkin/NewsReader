import SwiftUI

struct SellerContactsView: View {
    
    
    
    let contacts: [Contact]
    let sellectionCallBack: (Contact) -> Void
    let closeCallback: () -> Void
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.25)
                .ignoresSafeArea()
            
            
            VStack {
                contactsList

//                Divider()
                
                Button("Закрыть", action: closeCallback)
                    .padding(.bottom, 14)
                    .bold()
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.vertical)
            .padding(.horizontal, 40)

        }
    }
    
    private var contactsList: some View {
            VStack(spacing: 8) {
                ForEach(contacts) { contact in
                    Button {
                        sellectionCallBack(contact)
                    } label: {
                        Text(contact.formattedTitle + ": " + contact.displayValue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(contactCollor(contact.type))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .font(.body.bold())
                    }
                    .buttonStyle(.plain)
                    
                }
            }
            .padding()
        }
    
    
    func contactCollor(_ type: Contact.Kind) -> Color {
        switch type {
        case .telegram:
            return Color.blue
        case .instagram:
            return Color.pink
        case .whatsapp:
            return Color.green
        case .phone:
            return Color.gray
        }
    }
}

struct SellerContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SellerContactsView(contacts: [
            .placeholderPhone,
            .placeholderTelegram,
        ], sellectionCallBack: {_ in }, closeCallback: {})
    }
}
