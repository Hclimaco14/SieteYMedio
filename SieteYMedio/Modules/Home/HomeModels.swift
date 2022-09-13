//
//  HomeModels.swift
//  SieteYMedio
//
//  Created by Hector Climaco on 11/09/22.
//  
//

import UIKit

enum Palo: String {
    case bastos, copas, espadas, oros
}

enum EstadoJuego {
    case  ganaJugador, pierdeJugador, empate, encurso
    
    var title: String {
        switch self {
        case .ganaJugador:
            return "Ganaste"
        case .pierdeJugador:
            return "Perdiste"
        case .empate:
            return "Empate"
        case .encurso:
            return ""
        }
    }
    
    var message:String{
        switch self {
        case .ganaJugador:
            return "Felicidades la suerte esta de tu lado 🎉"
        case .pierdeJugador:
            return "Mas suerte para la proxíma 😢"
        case .empate:
            return "Empate vulve a intetarlo 😯"
        case .encurso:
            return ""
        }
    }
}

class Carta {
    var valor: Int
    var type: Palo
    
    init?(_ valor: Int, _ tipo: Palo) {
        if (valor >= 1 && valor <= 12) && valor != 8 && valor != 9 {
            self.valor = valor
            self.type = tipo
        } else {
            return nil
        }
    }
    var description: String { return "el \(self.valor) de \(self.type.rawValue)"}
}

class Mano {
    var cartas: [Carta]
    var tamano:Int { return cartas.count}
    
    init() {
        self.cartas = []
    }
    
    init(cartas: [Carta]) {
        self.cartas = cartas
    }
    
    func addCarta(_ carta: Carta) {
        self.cartas.append(carta)
    }
    
    func getCarta(_ index: Int) -> Carta? {
        if index < 0 && index >= cartas.count {
            return nil
        } else {
            return cartas[index]
        }
    }
    
    func sumarMano() -> Double {
        var sum = 0.0
        for val in cartas {
            if val.valor >= 10 {
                sum += 0.5
            } else {
                sum += Double(val.valor)
            }
        }
        return sum
    }
}

class Baraja {
    var cartas = [Carta]()
    
    init(){
        cartas += makePalo(.bastos)
        cartas += makePalo(.oros)
        cartas += makePalo(.copas)
        cartas += makePalo(.espadas)
    }
    
    
    fileprivate func makePalo(_ type: Palo) -> [Carta] {
        var cartasPalo = [Carta]()
        for index in 1...12 {
            if let carta = Carta(index,type) {
                cartasPalo.append(carta)
            }
        }
        
        return cartasPalo
    }
    
    func repartirCarta()-> Carta? {
        return cartas.popLast()
    }
    
    func barajar() {
        cartas.shuffle()
    }
}
