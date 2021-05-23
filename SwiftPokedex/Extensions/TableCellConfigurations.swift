//
//  TableCellConfiguration.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

typealias RegularCellConfig = TableCellConfiguration<RegularCell, ItemData>
typealias DetailCellConfig = TableCellConfiguration<DetailCell, DetailItem>
typealias StatCellConfig = TableCellConfiguration<StatCell, StatItem>
typealias ItemCellConfig = TableCellConfiguration<ItemCell, ItemDetails>

extension TableCellConfiguration {
    
    static func itemCell(data: ItemDetails) -> ItemCellConfig {
        ItemCellConfig(data: data, rowHeight: UITableView.automaticDimension)
    }
    
    static func regularCell(title: String, items: [ItemDetails]) -> RegularCellConfig {
        RegularCellConfig(data: ItemData(title: title, items: items), rowHeight: 70.0)
    }
    
    static func weightCell(value: Int) -> DetailCellConfig {
        DetailCellConfig(data: DetailItem(title: "Weight", value: value.kilo), rowHeight: 50.0)
    }
    
    static func heightCell(value: Int) -> DetailCellConfig {
        DetailCellConfig(data: DetailItem(title: "Height", value: value.meter), rowHeight: 50.0)
    }
    
    static func statCell(title: String, value: Int) -> StatCellConfig {
        switch title {
        case "Hp": return StatCellConfig(data: StatItem(title: "HP", value: value, color: .pokedexRed))
        case "Attack": return StatCellConfig(data: StatItem(title: "ATK", value: value, color: .orange))
        case "Defense": return StatCellConfig(data: StatItem(title: "DEF", value: value, color: .blue))
        case "Speed": return StatCellConfig(data: StatItem(title: "SPD", value: value, color: .green))
        default: return StatCellConfig(data: StatItem(title: "", value: 0, color: .clear))
        }
    }
    
    static func abilitiesCell(values: [Ability]) -> DetailCellConfig {
        let abilities = values.map { $0.ability.name.cleaned }.joined(separator: "\n\n")
        return DetailCellConfig(data: DetailItem(title: "Abilities", value: abilities), rowHeight: UITableView.automaticDimension)
    }
    
    static func typesCell(values: [Type]) -> DetailCellConfig {
        let types = values.map { $0.type.name.cleaned }.joined(separator: "\n\n")
        return DetailCellConfig(data: DetailItem(title: "Type", value: types), rowHeight: UITableView.automaticDimension)
    }
    
    static func movesCell(values: [Move]) -> DetailCellConfig {
        let limit = 10
        let tooMany = values.count > limit
        
        var values = tooMany ? Array(values[0 ..< limit]) : values
        
        if tooMany {
            values.append(Move(move: APIItem(name: "...", url: "")))
        }
        
        let moves = values.map { $0.move.name.cleaned }.joined(separator: "\n\n")
        return DetailCellConfig(data: DetailItem(title: "Moves", value: moves), rowHeight: UITableView.automaticDimension)
    }
}
