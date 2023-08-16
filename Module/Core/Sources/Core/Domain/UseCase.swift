//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 16/08/23.
//

import Foundation
import RxSwift

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    associatedtype ResponseSpecies
    
    func execute(request: Request?) -> Observable<Response>
    func execute(request: Request?) -> Observable<ResponseSpecies>
}
