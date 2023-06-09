import SwiftUI
import NukeUI

struct AdDetailsView: View {
    
    @ObservedObject var viewModel: AdDetailsViewModel
    @State var presentContactsList = false
    
    var body: some View {
        ZStack {
            ScrollView {
                content
                    .navigationTitle("Ad")
                    .toolbar {
                        ToolbarItemGroup {
                            
                            ShareLink(item: viewModel.sharedURL) {
                                Image(systemName: "square.and.arrow.up")

                            }
                        }
                    }
                    .redacted(reason: viewModel.didLoadData ? [] : .placeholder)
                    .allowsHitTesting(viewModel.didLoadData)
            }
            if presentContactsList {
                SellerContactsView(contacts: viewModel.contacts) { contact in
                    presentContactsList.toggle()
                    print(contact)
                } closeCallback: {
                    presentContactsList.toggle()
                }
                .animation(.easeOut, value: UUID())
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom),
                    removal: .move(edge: .top)
                ))
            }
        }
    }
    
    
    private var content: some View {
        VStack {
            images
            titleAnsPrice
            Divider()
            catecoryAndDate
            if let text = viewModel.descriptionText {
                descriptionText(text)
            }
            Button("Связаться") {
                presentContactsList.toggle()
            }
                .buttonStyle(.primaryAction)
                .padding(.horizontal)
        }
    }
    
    private var imagePlaceHolder: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.secondary)
            .font(Font.title.weight(.light))
            .padding(20)
            .unredacted()
    }
    
    private var images: some View {
        TabView {
            if viewModel.didLoadData,
               !viewModel.imageURLs.isEmpty {
                ForEach(viewModel.imageURLs, id: \.self) { url in
                    LazyImage(
                        url: url,
                        content: { state in
                            if let error = state.error {
                                Color.red
                                    .overlay(
                                        Text(error.localizedDescription)
                                    )
                            } else if let image = state.image {
                                image
                            } else {
                                imagePlaceHolder
                                    .overlay {
                                    }
                            }
                        }
                    )
                }
            } else {
                imagePlaceHolder
            }
        }
        .tabViewStyle(.page)
        .frame(height: 250)
        .frame(maxWidth: .infinity)
    }
    
    
    private var titleAnsPrice: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title2)
                
                if let location = viewModel.location {
                    Text(location)
                        .foregroundColor(Color.secondary)
                }
            }
            
            Spacer()
            
            Text(viewModel.price)
                .foregroundColor(Color.white)
                .padding(6)
                .background(Color.blue)
                .clipShape(Capsule())
        }
        .padding()
    }
    
    private var catecoryAndDate: some View {
        HStack() {
            Text(viewModel.category)
                .foregroundColor(.accentColor)
                .font(.subheadline)
            
            Spacer()
            Text(viewModel.date)
                .foregroundColor(.secondary)
                .font(.footnote)
        }
        .padding()
    }
    private func descriptionText(_ text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
}

struct AdDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AdDetailsView(
                viewModel: .placeholder
            )
        }
    }
}
