//
//  MovieSearchView.swift
//  This
//
//  Created by hoseung Lee on 2022/07/05.
//

import SwiftUI
import Combine

struct MovieSearchView: View {
  @ObservedObject var configuration: Configuration
  @State private var viewModel: ViewModel = .init(title: "", releaseDateString: "", genreString: "", castingString: "", bookmarked: false, imageURLString: "")
  @State private var image = Image(systemName: "heart")
  @State private var cancellables = Set<AnyCancellable>()
  @State private var showShareSheet = false
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 0) {
          posterSection
          descriptionSection
        }
      }
      .navigationTitle(viewModel.title)
    }
    .sheet(isPresented: $showShareSheet) {
      ActivityView(image: image, title: viewModel.title, subTitle: viewModel.releaseDateString)
    }
    .searchable(text: $configuration.searchText)
    .onAppear(perform: bind)
  }

  var posterSection: some View {
    AsyncImage(url: URL(string: viewModel.imageURLString)) { phase in
      if let image = phase.image {
        ZStack {
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .animation(.easeIn(duration: 1), value: 0)
            .onAppear {
              self.image = image
            }
          VStack {
            Spacer()
            HStack {
              Spacer()
              bookmarkedButton
            }
          }
        }
      } else {
        ProgressView()
      }
    }
    .padding(8)
  }

  var bookmarkedButton: some View {
    Button(action: {
      viewModel.bookmarked.toggle()
    }, label: {
      Image(systemName: viewModel.bookmarked ? "heart.fill" : "heart")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.red)
        .frame(width: 40, height: 40)
    })
    .padding()
  }

  var descriptionSection: some View {
    HStack(alignment: .top) {
      VStack(spacing: 6) {
        Group {
          Text("제목: \(viewModel.title)")
            .font(.title.weight(.bold))
          Text("개봉일: \(viewModel.releaseDateString)")
            .font(.body)
          Text("장르: \(viewModel.genreString)")
            .font(.body)
          Text("주연배우: \(viewModel.castingString)")
            .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      Button {
        showShareSheet.toggle()
      } label: {
        Image(systemName: "square.and.arrow.up")
          .resizable()
          .aspectRatio(nil, contentMode: .fit)
          .frame(width: 22)
          .foregroundColor(.black)
      }
    }
    .padding(EdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16))
  }

  private func bind() {
    configuration
      .item
      .compactMap { interface in
        interface as? ViewModel
      }
      .sink { viewModel in
        self.viewModel = viewModel
      }
      .store(in: &cancellables)
  }
}

struct MovieSearchView_Previews: PreviewProvider {
  static var previews: some View {
    MovieSearchView(configuration: .init(useCase: MockMovieSearchUseCase()))
  }
}

struct ActivityView: UIViewControllerRepresentable {
  let image: Image
  let title: String
  let subTitle: String
  func makeUIViewController(context: Context) -> UIActivityViewController {
    UIActivityViewController(activityItems: [image, title, subTitle], applicationActivities: [])
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

  }
}
