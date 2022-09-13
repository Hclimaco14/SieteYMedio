//
//  HomeInteractor.swift
//  SieteYMedio
//
//  Created by Hector Climaco on 11/09/22.
//  
//


import Foundation


protocol HomeBusinessLogic {
    func iniciarPartida()
    func pedirCarta()
    func plantarce()
    func nuevaPartida()
}

class HomeInteractor:  HomeBusinessLogic {
    
    var presenter: HomePresentationLogic?
    var worker = JuegoWorker()
    
    func iniciarPartida() {
        worker.comenzarPartida()
        presenter?.presentPuntaje(puntaje: worker.jugadaMaquina)
    }
    
    func pedirCarta() {
        presenter?.presentEstado(estado: worker.pedirCarta())
        presenter?.presentMano(mano: worker.manoJugador)
    }
    
    func plantarce() {
        presenter?.presentEstado(estado: worker.estadoPartida())
    }
    
    func nuevaPartida() {
        worker = JuegoWorker()
        worker.comenzarPartida()
        presenter?.presentPuntaje(puntaje: worker.jugadaMaquina)
        presenter?.presentMano(mano: worker.manoJugador)
    }
    
}
