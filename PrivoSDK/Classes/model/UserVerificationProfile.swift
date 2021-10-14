//
//  File.swift
//  
//
//  Created by alex slobodeniuk on 14.06.2021.
//
import Foundation

public struct UserVerificationProfile: Encodable {
    public var firstName: String?
    public var lastName: String?
    public var birthDate: Date?
    public var email: String?
    public var postalCode: String?
    public var phone: String?
    public var partnerDefinedUniqueID: String?
    public init(firstName: String? = nil, lastName: String? = nil, birthDate: Date? = nil, email: String? = nil, postalCode: String? = nil, phone: String? = nil, partnerDefinedUniqueID: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.email = email
        self.postalCode = postalCode
        self.phone = phone
        self.partnerDefinedUniqueID = partnerDefinedUniqueID
    }
}
