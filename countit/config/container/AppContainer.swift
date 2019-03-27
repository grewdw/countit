//
//  AppContainer.swift
//  countit
//
//  Created by David Grew on 02/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class AppContainer {
    
    private let controllerResolver: ControllerResolver
    private let serviceResolver: ServiceResolver
    private let respositoryResolver: RepositoryResolver
    
    private let clock = Clock()
    private let calendar = Calendar.autoupdatingCurrent
    private let context: NSManagedObjectContext
    private let properties: Properties
    private let messageBroker: MessageBroker
    
    init(test: Bool) {
        context = CoreDataConfig.getCoreDataContext(test: test)
        properties = test ? TestProperties() : UserDefaultsImpl()
        messageBroker = MessageBrokerNcImpl()
        
        respositoryResolver = RepositoryResolver(context: context)
        serviceResolver = ServiceResolver(repositoryResolver: respositoryResolver, clock: clock, calendar: calendar, properties: properties, messageBroker: messageBroker)
        controllerResolver = ControllerResolver(serviceResolver: serviceResolver, properties: properties, messageBroker: messageBroker)
    }
    
    func getControllerResolver() -> ControllerResolver {
        return controllerResolver
    }
    
    func getServiceResolver() -> ServiceResolver {
        return serviceResolver
    }
}
