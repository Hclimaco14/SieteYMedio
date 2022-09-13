//
//  HomeWorker.swift
//  SieteYMedio
//
//  Created by Hector Climaco on 11/09/22.
//  
//

import UIKit

class JuegoWorker {
    var baraja: Baraja
    var manoJugador : Mano
    var jugadaMaquina : Double = 0.0

    init() {
        self.baraja = Baraja()
        self.manoJugador = Mano()
    }

    
    func comenzarPartida() {
        self.baraja.barajar()
        jugadaMaquina = Double(Int.random(in: 1...7))
        if (Bool.random()) {
            jugadaMaquina += 0.5
        }
    }

    
    func pedirCarta() -> EstadoJuego{
        if let pedida = self.baraja.repartirCarta() {
            print("Sacas \(pedida.description)")
            self.manoJugador.addCarta(pedida)
            let valorMano = manoJugador.sumarMano()
            print("Llevas \(valorMano) puntos")
            if (valorMano>7.5) {
                return .pierdeJugador
            } else {
                return .encurso
            }
        } else {
            return estadoPartida()
        }
    }


    func jugadorSePlanta() {
        
    }


    func estadoPartida() -> EstadoJuego {
        if self.manoJugador.sumarMano() > self.jugadaMaquina {
            return .ganaJugador
        } else if self.manoJugador.sumarMano() < self.jugadaMaquina {
            return .pierdeJugador
        } else if self.manoJugador.sumarMano() == self.jugadaMaquina {
            return .empate
        } else {
            return .encurso
        }
    }

}
