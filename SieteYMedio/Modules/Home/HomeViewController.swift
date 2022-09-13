//
//  HomeViewController.swift
//  SieteYMedio
//
//  Created by Hector Climaco on 11/09/22.
//  
//

import UIKit

protocol HomeDisplayLogic {
    func displayPuntaje(puntaje: String)
    func displayMano(mano: Mano)
    func displayEstado(estado: EstadoJuego)
}

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var puntajeLbl: UILabel!
    @IBOutlet weak var cartasCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    @IBOutlet weak var puntajeJugadorLbl: UILabel!
    @IBOutlet weak var pedirCartaBtn: UIButton!
    @IBOutlet weak var plantarseBtn: UIButton!
    @IBOutlet weak var nuevaPartidaBtn: UIButton!
    
    
    
    
    var mano = Mano() {
        didSet {
            DispatchQueue.main.async {
                self.cartasCollectionView.reloadData()
                self.puntajeJugadorLbl.isHidden = false
                self.puntajeJugadorLbl.text = "Puntaje: \(self.mano.sumarMano())"
            }
        }
    }
    
    var interactor: HomeBusinessLogic?
    var router: HomeRoutingLogic?
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        configureView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.iniciarPartida()
    }
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = HomeInteractor()
        let presenter       = HomePresenter()
        let router          = HomeRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    func configureCollection() {
        cartasCollectionView.dataSource = self
        cartasCollectionView.delegate = self
        cartasCollectionView.register(UINib(nibName: CartaCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: CartaCell.identifier)
    }
    
    func configureView() {
        self.puntajeJugadorLbl.isHidden = true
        self.pedirCartaBtn.layer.cornerRadius = 5
        self.pedirCartaBtn.clipsToBounds = true
        self.plantarseBtn.layer.cornerRadius = 5
        self.plantarseBtn.clipsToBounds = true
        self.nuevaPartidaBtn.layer.cornerRadius = 5
        self.nuevaPartidaBtn.clipsToBounds = true
    }
    
    // MARK: - Private
    func updateGame(estado: EstadoJuego) {
        configureActions(estado: estado)
        switch estado {
        case .ganaJugador,.pierdeJugador,.empate:
            self.showMessage(title: estado.title, message: estado.message)
        case .encurso:
            break
        }
    }
    
    func configureActions(estado: EstadoJuego) {
        switch estado {
        case .ganaJugador,.pierdeJugador,.empate:
            pedirCartaBtn.isEnabled = false
            plantarseBtn.isEnabled = false
        case .encurso:
            pedirCartaBtn.isEnabled = true
            plantarseBtn.isEnabled = true
        }
    }
    
    func showMessage(title: String, message: String) {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }

            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    // MARK: - Actions
    
    @IBAction func pedirCartaAction() {
        interactor?.pedirCarta()
    }
    
    @IBAction func plantarseAction() {
        interactor?.plantarce()
    }
    
    @IBAction func nuevaPartida() {
        interactor?.nuevaPartida()
        configureActions(estado: .encurso)
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mano.cartas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = cartasCollectionView.dequeueReusableCell(withReuseIdentifier: CartaCell.identifier, for: indexPath) as? CartaCell else {
            return UICollectionViewCell()
        }
        
        cell.carta = mano.cartas[indexPath.row]
        
        return cell
    }
    
    
}

extension HomeViewController: HomeDisplayLogic {
    func displayPuntaje(puntaje: String){
        self.puntajeLbl.text = puntaje
    }
    
    func displayMano(mano: Mano) {
        self.mano = mano
    }
    
    func displayEstado(estado: EstadoJuego) {
        self.updateGame(estado: estado)
    }
}

extension  HomeViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = ( cartasCollectionView.layer.frame.width / 3) * 0.85
        let height = width * 1.4
        
        return CGSize(width: width, height: height)
    }
}
