//
//  ETTransactionCategory.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import Foundation

enum ETTransactionCategory: String, CaseIterable, Codable, Identifiable {
    var id: Self {
        return self
    }
    
    case mortgage = "Mortgage"
    case houseRent = "House rent"
    case houseMaintenance = "House maintenance"
    case householdRepairs = "Household repairs"
    case householdExpenses = "Household expenses"
    
    case electricity = "Electricity"
    case cookingGas = "Cooking gas"
    case phoneAirtel = "Airtel phone"
    case phoneJio = "Jio phone"
    case phoneVodafone = "Vodafone phone"
    case phoneBsnl = "BSNL phone"
    case phoneBill = "Phone bill"
    case broadbandJio = "Jio broadband"
    case broadbandAirtel = "Airtel broadband"
    case broadbandTataplay = "Tataplay broadband"
    case broadbandACT = "ACT broadband"
    case broadbandRailwire = "Railwire broadband"
    case broadbandBill = "Broadband bill"
    
    case milk = "Milk"
    case snacksBeverages = "Snacks and Beverages"
    case groceries = "Groceries"
    case vegetables = "Vegetables"
    case restaurant = "Restaurants"
    case meat = "Meat"
    
    case clothingAdult = "Adult clothings"
    case clothingKid = "Kids clothings"
    
    case books = "Books"
    case kidsEducationFee = "Kids education fee"
    case adultEducationFee = "Adult education fee"
    case outdoorSport = "Outdoor sports and training"
    case indoorSport = "Indoor sports and training"
    case adultTraining = "Adult training"
    
    case primaryHealthcare = "Primary health care"
    case termInsurance = "Term insurance"
    case healthInsurance = "Health insurance"
    case specialityCare = "Speciality care"
    case medications = "Medications"
    
    case fuel = "Fuel"
    case tires = "Tires"
    case oilChanges = "Oil changes"
    case vehicleMaintenance = "Vehicle maintenances"
    case toll = "Vehicle toll"
    case fares = "Fares"
    case spares = "Spare parts"
    case autoInsurance = "Automobile insurance"
    case rentalVehicle = "Rental vehicles"
    
    case haircut = "Hair cut"
    case waxing = "Waxing"
    case manicure = "Manicure"
    case pedicure = "Pedicure"
    case cosmetics = "Cosmetics"
    case jewelry = "Jewelry"
    
    case birthdayGift = "Birthday gift"
    case marriageGift = "Marriage gift"
    case specialOccasions = "Special occasions"
    
    case netflix = "Netflix"
    case tentkota = "Tentkota"
    case hotstar  = "Hotstar"
    case amazonprime = "Amazon Prime"
    case youtube = "Youtube Premium"
    case spotify = "Spotify"
    case sonyliv = "SonyLIV"
    case jioCinema = "Jio Cinema"
    case erosNow = "erosNow"
    case zee5 = "Zee5"
    case voot = "Voot"
    case mxplayer = "MX Player"
    case airtelXtream = "Airtel XStream"
    case sunnxt = "Sun NXT"
    case discoryplus = "Discover+"
    case yupptv = "yupp TV"
    case aha = "aha"
    case gaana = "Gaana"
    case jiosaavn = "JioSaavn"
    case wynk = "Wynk Music"
    case appleMusic = "Apple Music"
    case hungama = "Hungama"
    case googleplayMusic = "Google Play Music"
    case youtubeMusic = "Youtube Music"
    case disneyplus = "Disney+"
    case appleTv = "Apple TV+"
    case hbo = "HBO"
    case hboMax = "max"
    case youtubeTv = "Youtube TV"
    case dth = "DTH"
    case movies = "Movies"
    case toys = "Toys"
    
    case flight = "Flight"
    case outing = "Outing"
    
    case salary = "Salary"
    case reimbursement = "Reimbursements"
    case bonus = "Bonus"
    case dividend = "Dividend"
    case interetsEarned = "Interests earned"
    
    case others = "Others"
    
    func group() -> ETTransactionGroup {
        switch(self) {
        case .mortgage, .houseRent, .houseMaintenance,
                .householdRepairs, .householdExpenses:
            return .home
        case .electricity, .cookingGas,
                .phoneAirtel, .phoneJio, .phoneVodafone,
                .phoneBsnl, .phoneBill, .broadbandACT,
                .broadbandJio,.broadbandBill, .broadbandAirtel,
                .broadbandRailwire, .broadbandTataplay:
            return .utilities
        case .milk, .snacksBeverages, .groceries,
                .vegetables, .restaurant, .meat:
            return .provisions
        case .clothingAdult, .clothingKid:
            return .clothings
        case .books, .kidsEducationFee, .adultEducationFee,
                .outdoorSport, .indoorSport, .adultTraining:
            return .education
        case .primaryHealthcare, .termInsurance, .healthInsurance,
                .specialityCare, .medications:
            return .healthcare
        case .fuel, .tires, .oilChanges,
                .vehicleMaintenance, .toll,
                .fares, .spares, .autoInsurance, .rentalVehicle:
            return .transportation
        case .haircut, .waxing, .manicure,
                .pedicure, .cosmetics,.jewelry:
            return .personal
        case .birthdayGift, .marriageGift, .specialOccasions:
            return .gifts
        case .netflix, .tentkota, .hotstar,
                .amazonprime, .youtube, .spotify,
                .sonyliv, .jioCinema, .erosNow,
                .zee5, .voot, .mxplayer, .airtelXtream,
                .sunnxt, .discoryplus, .yupptv, .aha,
                .gaana, .jiosaavn, .wynk, .appleMusic,
                .hungama, .googleplayMusic, .youtubeMusic,
                .disneyplus, .appleTv, .hbo, .hboMax,
                .youtubeTv, .dth, .movies, .toys:
            return .entertainment
        case .flight, .outing:
            return .vacation
        case .salary, .reimbursement, .bonus,
                .dividend, .interetsEarned:
            return .income
        case .others:
            return .miscellaneous
        }
    }
}
