//
//  AppEnums.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 14.12.2023.
//

import UIKit

public enum ColorNames {
    
    case Gray200
    
    var color: UIColor {
        switch self {
        case .Gray200:
            return UIColor(named: "Gray-200") ?? .white
        }
    }
}
        
public enum PeriodTypes : String {
    case tenMinutes = "за 10 минут"
    case hour = "за час"
    case day = "за сутки"
    case week = "за неделю"
}

public enum SourceTypes : String {
    case sources = "источники"
    case twentyFourSmi = "24СМИ"
    case androidApp = "AndroidApp"
    case facebook = "Facebook"
    case googleSuggest = "Google Suggest"
    case liveJournal = "LiveJournal"
    case mediaMetrics = "MediaMetrics"
    case newsGoogle = "News-Google"
    case twitter = "Twitter"
    case vk = "ВКонтакте"
    case odnoklassniki = "Одноклассники"
    case googleSearch = "Поиск Google"
    case yandexSearch = "Поиск Яндекс"
    case habrahabr = "Хабрахабр"
    case yandexDzen = "Яндекс-Дзен"
}

public enum CountryTypes : String {
    case countries = "страны"
    case azerbaijan = "Азербайджан"
    case armenia = "Армения"
    case belarus = "Беларусь"
    case georgia = "Грузия"
    case israel = "Израиль"
    case kazakhstan = "Казахстан"
    case kyrgyzstan = "Киргизия"
    case latvia = "Латвия"
    case moldavia = "Молдавия"
    case russia = "Россия"
    case tajikistan = "Таджикистан"
    case uzbekistan = "Узбекистан"
    case ukraine = "Украина"
    case czech = "Чехия"
}

public enum RegionTypes : String {
    case regions = "регионы"
    case fixIt = "!!!!! FIX IT !!!!!"
    case mediaMetrics = "MediaMetrics.KZ"
    case yandex = "Поиск Яндекс"
}
