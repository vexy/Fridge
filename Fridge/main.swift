//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation

print("WELCOME TO ❄️FRIDGE❄️")

//santa's little helper ;)
let appTimeout : TimeInterval = TimeInterval(30) //seconds
//let mainSemaphore : DispatchSemaphore = DispatchSemaphore(value: 0)

// Execute all examples
ExamplesFactory.downloadOneItem()
ExamplesFactory.downloadTenFiles()
ExamplesFactory.downloadBigFiles()

//hard stop this app timeout period
RunLoop.main.run(until: Date(timeIntervalSinceNow: appTimeout))
