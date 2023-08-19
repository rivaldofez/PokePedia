//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 17/08/23.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Response) -> Entity
    func transformResponseToDomain(response: Response) -> Domain
    func transformEntityToDomain(entity: Entity) -> Domain
    func transformDomainToEntity(domain: Domain) -> Entity
}
