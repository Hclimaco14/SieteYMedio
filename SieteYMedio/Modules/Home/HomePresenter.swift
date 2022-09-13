//
//  HomePresenter.swift
//  SieteYMedio
//
//  Created by Hector Climaco on 11/09/22.
//  
//

import UIKit

protocol HomePresentationLogic {
    func presentPuntaje(puntaje: Double)
    func presentMano(mano: Mano)
    func presentEstado(estado: EstadoJuego)
}

class HomePresenter: HomePresentationLogic {
    
    var view: HomeDisplayLogic?
    
    func presentPuntaje(puntaje: Double) {
        view?.displayPuntaje(puntaje: "Puntaje: \(puntaje)")
    }
   
    func presentMano(mano: Mano) {
        view?.displayMano(mano: mano)
    }
    
    func presentEstado(estado: EstadoJuego){
        view?.displayEstado(estado: estado)
    }
}
