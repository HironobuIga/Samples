//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


struct Item {
    let name: String
    let price: Int
    
    static let items = [
        Item(name: "ひのきの棒", price: 5),
        Item(name: "はやぶさの剣", price: 25000),
        Item(name: "こん棒", price: 30),
        Item(name: "毒針", price: 10),
        Item(name: "銅の剣", price: 100),
        Item(name: "聖なるナイフ", price: 200),
        Item(name: "魔道士の杖", price: 1500),
        Item(name: "刺の鞭", price: 320),
        Item(name: "くさり鎌", price: 550),
        Item(name: "鉄の槍", price: 750),
        Item(name: "鉄の爪", price: 770),
        Item(name: "鋼鉄の剣", price: 1500),
        Item(name: "裁きの杖", price: 2700),
        Item(name: "鉄の斧", price: 2500),
        Item(name: "大鋏", price: 3700),
        Item(name: "理力の杖", price: 2500),
        Item(name: "大金槌", price: 6500),
        Item(name: "ゾンビキラー", price: 9800),
        Item(name: "ドラゴンキラー", price: 15000),
        Item(name: "破壊の剣", price: 45000),
        Item(name: "王者の剣", price: 35000),
        Item(name: "アブない水着", price: 78000),
        Item(name: "布の服", price: 10),
        Item(name: "旅人の服", price: 70),
        Item(name: "稽古着", price: 80),
        Item(name: "皮の鎧", price: 150),
        Item(name: "甲羅の鎧", price: 300),
        Item(name: "身かわしの服", price: 2900),
        Item(name: "くさりかたびら", price: 480),
        Item(name: "鉄のまえかけ", price: 700),
        Item(name: "武闘着", price: 800),
        Item(name: "鉄の鎧", price: 1100),
        Item(name: "ハデな服", price: 1300),
        Item(name: "魔法の法衣", price: 4400),
        Item(name: "鋼鉄の鎧", price: 2400),
        Item(name: "天使のローブ", price: 3000),
        Item(name: "魔法の鎧", price: 5800),
        Item(name: "水の羽衣", price: 12500),
        Item(name: "ドラゴンメイル", price: 9800),
        Item(name: "皮の盾", price: 90),
        Item(name: "青銅の盾", price: 180),
        Item(name: "鉄の盾", price: 700),
        Item(name: "水鏡の盾", price: 8800),
        Item(name: "力の盾", price: 15000),
        Item(name: "皮の帽子", price: 80),
        Item(name: "ターバン", price: 160),
        Item(name: "鉄兜", price: 2000),
        Item(name: "鉄仮面", price: 3500),
        Item(name: "薬草", price: 8),
        Item(name: "毒消し草", price: 10),
        Item(name: "キメラの翼", price: 25),
        Item(name: "聖水", price: 20),
        Item(name: "満月草", price: 30),
        Item(name: "まだらクモ糸", price: 35),
        Item(name: "毒蛾の粉", price: 500),
        Item(name: "消え去り草", price: 300),
        Item(name: "祈りの指輪", price: 2500),
        Item(name: "水鉄砲", price: 15),
        Item(name: "世界樹の葉", price: 3),
        Item(name: "幸せの靴", price: 75),
        Item(name: "銀の竪琴", price: 7),
        Item(name: "命の木の実", price: 150),
        Item(name: "力の種", price: 180),
        Item(name: "すばやさの種", price: 60),
        Item(name: "スタミナの種", price: 90),
        Item(name: "賢さの種", price: 120),
        Item(name: "ラックの種", price: 45),
    ]
}


class viewController: UITableViewController {
    var items = [Int: [Item]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    
    private func prepareData() {
        items = Dictionary(grouping: Item.items) { item -> Int in
            switch item.price {
            case 0..<100: return 0
            case 100..<1000: return 1
            case 1000..<5000: return 2
            default: return 3
            }
            }.reduce([Int: [Item]]()) { dic, tuple in
                var dic = dic
                dic[tuple.key] = tuple.value.sorted{ $0.price < $1.price }
                return dic
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "レベル\(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
        }
        let item = self.items[indexPath.section]![indexPath.row]
        cell!.textLabel?.text = item.name
        cell?.detailTextLabel?.text = "\(item.price)G"
        return cell!
    }
}

PlaygroundPage.current.liveView = viewController(style: .grouped)
