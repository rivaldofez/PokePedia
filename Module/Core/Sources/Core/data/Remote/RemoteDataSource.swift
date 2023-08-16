//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 16/08/23.
//

import Foundation
import RxSwift

public protocol RemoteDataSource {
    associatedtype Request
    associatedtype Response
    associatedtype ResponseSpecies
    
    // Pagination List
    func list(offset: Int, limit: Int) -> Observable<[Response]>
    
    func getSpecies(id: Int) -> Observable<ResponseSpecies?>
    
}
