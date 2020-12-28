//
//  ViewController.swift
//  RezervacijaSoba
//
//  Created by Ivana Lubar on 27/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var vremenaDolaskaTextField: UITextField!
    @IBOutlet var vremenaOdlaskaTextField: UITextField!
    @IBOutlet var k_brojSoba: UITextField!
    @IBOutlet var rezultatLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func rezervacijaSoba(vremenaDolaska: [Int], vremenaOdlaska: [Int], k: Int) -> Bool {
        let n = vremenaDolaska.count // sa n označavamo duljinu ulaznih nizova. Buduci da su oni jednaki, svejedno nam je hoćemo li računati vremenaDolaska.count ili vremenaOdlaska.count

        let a = vremenaDolaska.sorted() // sortiranje ulaznih nizova
        let b = vremenaOdlaska.sorted()

        // Ako su nizovi sortirani, možemo jednostavno prelaziti preko svakog elementa pomoću dva pokazivača - jedan na dolascima, drugi na odlascima  i provoditi provjeru

        // na početku se brojač i indeksi postavljaju na 0
        var brojac: Int = 0 // označava trenutni broj gostiju u hotelu
        var indexA: Int = 0
        var indexB: Int = 0

        while (indexA < n && indexB < n) { // dok ne dođemo do zadnjih indeksa u nizovima
            if (a[indexA] < b[indexB]) { // provjeravamo koji element je manji
                indexA = indexA + 1 // povećavamo indeks niza A (vremena dolaska)
                brojac = brojac + 1 // ako bilježimo dolazak nekog gosta, moramo povećati brojač za tog gosta

                if (brojac > k) { // ukoliko je brojač veći od k, vraćamo false jer smo dobili odgovor da k soba nije dovoljno za boravak gostiju
                    return false;
                }
            } else {
                indexB = indexB + 1 // povećavamo indeks niza B (vremena odlaska)
                brojac = brojac - 1 // ako bilježimo odlazak nekog gosta, moramo umanjiti brojač za tog gosta
            }
        }
        return true // ako su sve provjere prošle, dobivamo rezultat da je k soba dovoljno za boravak gostiju
    }

    @IBAction func izracunajButtonActionHandler() {
        guard
            let vremenaDolaska = vremenaDolaskaTextField.text?.split(separator: ",").map({ Int($0)!}),
            let vremenaOdlaska = vremenaOdlaskaTextField.text?.split(separator: ",").map({ Int($0)!}),
            let k = k_brojSoba.text.map({ Int($0)!}),
            vremenaDolaska.count == vremenaOdlaska.count
        else {
            let alert = UIAlertController(title: "Pogrešan unos", message: "Vremena dolaska i odlaska odvojite zarezom. Polja za vremena dolaska i odlaska moraju biti iste duljine.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }

        rezultatLabel.text = rezervacijaSoba(vremenaDolaska: vremenaDolaska, vremenaOdlaska: vremenaOdlaska, k: k) ? "Broj soba: \(k) je dovoljan za boravak gostiju"  : "Broj soba: \(k) nije dovoljan za boravak gostiju"
    }
}

