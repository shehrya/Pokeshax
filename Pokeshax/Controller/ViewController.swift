//
//  ViewController.swift
//  Pokeshax
//
//  Created by Shehryar Khan on 03.10.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    var Pokeshax = [pokeshax]()
    var filteredPokeshax = [pokeshax]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokeshaxCSV()
        initAudio()
        
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func parsePokeshaxCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = pokeshax(name: name, pokeshaxId: pokeId )
                Pokeshax.append(poke)
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: pokeshax!
        
        if inSearchMode {
            
            poke = filteredPokeshax[indexPath.row]
            
        } else {
            
            poke = Pokeshax[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokeshaxDetailVC", sender: poke)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokeshax.count
        }
        
        return Pokeshax.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let Poke: pokeshax!
            if inSearchMode {
                Poke = filteredPokeshax[indexPath.row]
                cell.configureCell(pokeshax: Poke)
            } else {
                
                Poke = Pokeshax[indexPath.row]
                cell.configureCell(pokeshax: Poke)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
        } else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        }else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokeshax = Pokeshax.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeshaxDetailVC" {
            if let detailVC = segue.destination as? PokeshaxDetailVC {
                if let poke = sender as? pokeshax {
                    detailVC.pokeshax = poke
                }
            }
        }
    }
}

