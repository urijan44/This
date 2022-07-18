//
//  MovieRowView.swift
//  
//
//  Created by hoseung Lee on 2022/07/17.
//

import SwiftUI
import Combine

public protocol MovieRowItem {
  var imageURL: String { get }
  var originalTitle: String { get }
  var localTitle: String { get }
  var voteRate: String { get }
  var overview: String { get }
}

public struct MovieRowView: View {
  @StateObject private var configuration = Configuration()
  private let item: MovieRowItem
  public var body: some View {
    HStack(alignment: .top) {
      VStack {
        Image(uiImage: configuration.image)
          .resizable()
          .aspectRatio(nil, contentMode: .fit)
          .opacity(configuration.imageDownloadState ? 1 : 0)
          .animation(.easeIn(duration: 0.3), value: configuration.imageDownloadState)
        Text(item.originalTitle)
          .minimumScaleFactor(0.3)
          .lineLimit(1)
        Text(item.localTitle)
          .minimumScaleFactor(0.3)
          .lineLimit(1)
        Text("평점: \(item.voteRate)")
      }
      .frame(width: 100)
      Text(item.overview)
        .lineLimit(6)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(6)
    .onAppear {
      configuration.downloadImage(urlString: item.imageURL)
    }
  }

  public init(item: MovieRowItem) {
    self.item = item
  }
}

extension MovieRowView {
  final class Configuration: ObservableObject {
    @Published var image = UIImage()
    @Published var imageDownloadState = false
    private var cancellables = Set<AnyCancellable>()

    func downloadImage(urlString: String) {
      imageDownloadState = false
      fetchImage(urlString: urlString)
    }

    private func fetchImage(urlString: String) {
      guard let url = URL(string: urlString) else { return }
      URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: DispatchQueue.main)
        .compactMap { (data, _) in
          return UIImage(data: data)
        }
        .replaceError(with: UIImage())
        .sink { [weak self] image in
          self?.imageDownloadState = true
          self?.image = image
        }
        .store(in: &cancellables)
    }
  }
}

struct MovieRowView_Previews: PreviewProvider {
  struct DummyItem: MovieRowItem {
    var imageURL: String = "https://image.tmdb.org/t/p/w500//jMLiTgCo0vXJuwMzZGoNOUPfuj7.jpg"
    var originalTitle = "Top Gun: Maverick"
    var localTitle = "탑건: 메버릭"
    var voteRate = "평점: 8.4"
    var overview = "최고의 파일럿이자 전설적인 인물 매버릭은 자신이 졸업한 훈련학교 교관으로 발탁된다. 그의 명성을 모르던 팀원들은 매버릭의 지시를 무시하지만 실전을 방불케 하는 상공 훈련에서 눈으로 봐도 믿기 힘든 전설적인 조종 실력에 모두가 압도된다. 매버릭의 지휘 아래 견고한 팀워크를 쌓아가던 팀원들에게 국경을 뛰어넘는 위험한 임무가 주어지자 매버릭은 자신이 가르친 동료들과 함께 마지막이 될지 모를 하늘 위 비행에 나서는데…"
  }

  static var previews: some View {
    MovieRowView(item: DummyItem())
  }
}
