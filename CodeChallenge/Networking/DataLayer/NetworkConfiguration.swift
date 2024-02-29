//
//  NetworkConfiguration.swift
//  CodeChallenge
//
//  Created by Dev on 1/2/22.
//

final class NetworkConfiguration {

    static let shared = NetworkConfiguration()

    private(set) var apiKey = ""

    var baseAPIURLString: String {
        return "iostestserver-su6iqkb5pq-uc.a.run.app"
    }

    init() {}

    func configure(with apiKey: String) {
        self.apiKey = apiKey
    }

}
