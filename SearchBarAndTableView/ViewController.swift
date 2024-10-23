//
//  ViewController.swift
//  SearchBarAndTableView
//
//  Created by Sait Demirel on 21.10.2024.
//

import UIKit

class ViewController: UIViewController {
//TableView ve SearchBar'ı bağla
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
//veri setlerini oluştur
    var ulkeler:[String] = [String]()
    var aramaSonucuUlkeler:[String] = [String]()
    var aramaYapılıyorMu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ulkeler = [
            "Türkiye", "Amerika", "Kanada", "Japonya", "İsveç", "Norveç", "Hollanda", "Almanya",
            "Arjantin", "Avusturya", "Avustralya", "Belçika", "Brezilya", "Bulgaristan",
            "Çek Cumhuriyeti", "Danimarka", "Endonezya", "Estonya", "Filipinler", "Finlandiya",
            "Fransa", "Güney Afrika", "Güney Kore", "Hindistan", "İspanya", "İtalya",
            "İsrail", "İsviçre", "Kolombiya", "Kırgızistan", "Letonya", "Meksika",
            "Malezya", "Moritanya", "Nepal", "Yeni Zelanda", "Norveç", "Romanya",
            "Rusya", "Sırbistan", "Singapur", "Slovakya", "Slovenya", "Sri Lanka",
            "Tayland", "Türkmenistan", "Uganda", "Ukrayna", "Umman", "Venezuela",
            "Zambiya", "Zimbabwe", "Bahreyn", "Birleşik Arap Emirlikleri", "İrlanda",
            "Kazakistan", "Malavi", "Paraguay"
        ]

//Searchbar ve tableview i bağla
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }


}
//tableview için extension
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if aramaYapılıyorMu {
            return aramaSonucuUlkeler.count
        }
        else {
            return ulkeler.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ulkelerHucre", for: indexPath)
        if aramaYapılıyorMu {
            cell.textLabel?.text = aramaSonucuUlkeler[indexPath.row]
        }
        else {
            cell.textLabel?.text = ulkeler[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if aramaYapılıyorMu {
            print("Seçilen Ülke: \(aramaSonucuUlkeler[indexPath.row]) ")
        }
        else {
            print("Seçilen Ülke: \(ulkeler[indexPath.row])")
        }
            
    }
}
//searchbar için extension
extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonucu: \(searchText)")
        if searchText == "" { // bu sayede arama yapılmadığı zamanda boş ekran değil tüm listeyi göreceğiz
            aramaYapılıyorMu = false
        }
        else {
            aramaYapılıyorMu = true
            //Hata : ulkeler.filter(...)'i aramalarSonucuUlkeler atamamışım filiter fonksiyonunun sonucu kullanılmadı yani
            aramaSonucuUlkeler = ulkeler.filter({$0.lowercased().contains(searchText.lowercased())})
        }
        //arama yapıldıktan sonra mutlaka bunu yap
        tableView.reloadData() //tableView Extensionları hep tekrardan çalıştırıldı
        
    }
}
