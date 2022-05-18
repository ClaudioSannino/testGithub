//
//  ViewController.swift
//  Jeson Decode/Encode
//
//  Created by ESANNICDS on 10/05/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDequeuer, UITableViewDragDelegate {
    
    // MARK: - Songs
    struct Songs: Codable {
        let startSongs: [StartSong]?
        let endSongs: EndSongs?
    }
    
    // MARK: - EndSongs
    struct EndSongs: Codable {
        let song: [Song]?
    }
    
    // MARK: - Song
    struct Song: Codable {
        let song: String?
    }
    
    // MARK: - StartSong
    struct StartSong: Codable {
        let song: String?
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func actionInserisci(_ sender: Any) {
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var songs : [String] = []
    
    let defaults = UserDefaults.standard
    
    var controller = UIAlertController(title: "CONFERMI?", message: "Confermi di voler aggiungere la nuova canzone?", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        createSongsArray()
        createAlert()
        
        provaMap()
    }
    
    
    
    @objc(tableView:itemsForBeginningDragSession:atIndexPath:) func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = songs[indexPath.row%songs.count]
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let mover = songs.remove(at: sourceIndexPath.row)
        songs.insert(mover, at: destinationIndexPath.row)
        
        defaults.set(songs, forKey: "mySongs")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell =  (self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
        
        cell.textLabel?.text = self.songs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            songs.remove(at: indexPath.row)
            defaults.set(songs, forKey: "mySongs")
            tableView.reloadData()
        }
    }
    
    
    
    func registerTableView()
    {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
    }
    
    
    
    func createSongsArray()
    {
        if(defaults.object(forKey: "mySongs") == nil)
        {
            if let path = Bundle.main.path(forResource: "SongList", ofType: "json") {
                
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                    let song = try JSONDecoder().decode(Songs.self, from: data)
                    
                    let starts = song.startSongs!.map({$0.song!})
                    
                    let end = song.endSongs!.song!.map({$0.song!})
                    
                    songs.append(contentsOf: starts + end)
                    
                } catch {
                }
            }
            defaults.set(songs, forKey: "mySongs")
        }
        else
        {
            songs = defaults.object(forKey: "mySongs") as! [String]
        }
    }
    
    
    
    func createAlert()
    {
        let actionSI = UIAlertAction(title: "SI", style: UIAlertAction.Style.default, handler:
                                        { [self] (paramAction:UIAlertAction!) in
            
            songs.append(textField.text!)
            
            defaults.set(songs, forKey: "mySongs")
            
            tableView.reloadData()
        })
        
        let actionNO = UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler:
                                        { [self](paramAction:UIAlertAction!) in
            textField.text?.removeAll()
            
        })
        
        controller.addAction(actionSI)
        controller.addAction(actionNO)
    }
    
    
    
    func provaMap()
    {
        var strings = ["tesT", "#Map", "arrAy", "#stRinghe", "22", "#22"]
        print(strings.sorted())
        print(strings.sorted(by: >))
        
        let stringsMaiuscole = strings.map {$0.uppercased()}
        print(stringsMaiuscole)
        
        let hashtag = strings.map(hashtags)
        print(hashtag)
        
        
        let flatmapTags = strings.flatMap(hashtags)
        print(flatmapTags)
        
        
        let compact = strings.compactMap { Int($0) }
        print(compact)
        
        let compactMap = strings.compactMap(Int.init)
        print(compactMap)
    }
    
    
    
    
    
    func hashtags(in string: String) -> [String] {
        let words = string.components(
            separatedBy: .whitespacesAndNewlines
        )
        
        let tags = words.filter { $0.starts(with: "#") }
        
        return tags.map { $0.lowercased() }
    }
}















//    struct Test: Codable {
//        let pagoPa: PagoPa?
//        let custID: String?
//        let code: String?
//
//        enum CodingKeys: String, CodingKey {
//            case custID = "custId"
//            case pagoPa, code
//        }
//    }
//
//    // MARK: - PagoPa
//    struct PagoPa: Codable {
//        let code, category, verifyID, paNoticeCode: String?
//        let paAgencyCF: String?
//        let amount: Int?
//        let payerCF, paymentModel, fastBankID, currency: String?
//        let paAgencyDescr: String?
//        let reasons: [Reason]?
//        let iuvcode: String?
//
//        enum CodingKeys: String, CodingKey {
//            case code, category
//            case verifyID = "verifyId"
//            case paNoticeCode, paAgencyCF, amount, payerCF, paymentModel, fastBankID, currency, paAgencyDescr, reasons, iuvcode
//        }
//    }
//
//    // MARK: - Reason
//    struct Reason: Codable {
//        let cau: String?
//    }



////        DECODE TEST
//        if let path = Bundle.main.path(forResource: "VerifyBollettinoResponse", ofType: "json") {
//
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                print(data)
//
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                print("jsonData1 \(jsonResult)")
//
//                let decoder = JSONDecoder()
//                let test = try decoder.decode(Test.self, from: data)
//                let stringaTest = test.pagoPa?.reasons![0].cau
//                print("\nTest.custID: \(test.custID!)")
//                print("Test.pagoPa.paAgencyDescr: \(test.pagoPa?.paAgencyDescr ?? "Test")")
//                print("stringaTest: \(stringaTest!)")
//                print("PagoPa.reasons[1]: \(test.pagoPa?.reasons![1].cau! ?? "Test")\n")
//
////                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
////                    print("jsonData2 \(jsonResult)")
////                }
//            } catch {
//                // handle error
//            }
//        }
//
//
////        ENCODE TEST
//        struct TestEncode: Codable {
//            let code, category, verifyID, paNoticeCode: String?
//            let paAgencyCF: String?
//            let amount: Int?
//        }
//
//        let testEncode = TestEncode(code: "PPAprova", category: "PPA", verifyID: "testVerifyID", paNoticeCode: "00112233", paAgencyCF: "44556677", amount: 8899)
//
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//
//        do
//        {
//            let data = try encoder.encode(testEncode)
//            print("Encode test:\n\(String(data: data, encoding: .utf8)!)\n")
//
//        } catch {
//
//        }

//    }

