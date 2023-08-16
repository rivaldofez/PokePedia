//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 16/08/23.
//

import Foundation
import RxSwift

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
