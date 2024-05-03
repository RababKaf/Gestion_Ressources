package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.entity.Imprimante;
import com.example.demo.repository.ImprimanteRepository;
import com.example.demo.repository.OrdinateurRepository;
import com.example.demo.service.ImprimanteService;

import jakarta.transaction.Transactional;
@Service
public class ImprimanteServiceImplement implements ImprimanteService {

	private ImprimanteRepository imprimanteRepository;

	public ImprimanteServiceImplement(ImprimanteRepository imprimanterepository) {
		super();
		this.imprimanteRepository = imprimanterepository;
	}

	@Override
	public Imprimante getImprimantesEns(Integer id) {
		// TODO Auto-generated method stub
		return  imprimanteRepository.findByRessourceId(id);
	}

	@Override
	public List<Imprimante> getImprimantesEns() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteImprimantesEns(Integer id) {
		// TODO Auto-generated method stub
		imprimanteRepository.deleteById(id);
	}

	@Override
	public Imprimante getImprimanteE(Integer id) {
		// TODO Auto-generated method stub
		return imprimanteRepository.getById(id);
	}

	@Override
	public void addImprimanteEns(Imprimante imp) {
		// TODO Auto-generated method stub
		imprimanteRepository.save(imp);
	}

  

	@Override
	public Imprimante GetListeImprimanteFrn(int ressourceId) {
		// TODO Auto-generated method stub
		return imprimanteRepository.findByRessourceId(ressourceId);
	}	@Override
	public Imprimante GetListeImprimanteRespo(int ressourceId) {
		// TODO Auto-generated method stub
		return imprimanteRepository.findByRessourceId(ressourceId);
	}
	
	
	@Transactional
	@Override
	public void deleteImprimante(int ressourceId) {
		// TODO Auto-generated method stub
		imprimanteRepository.deleteByRessourceId(ressourceId);
		
	}
	@Override
	public void updateImprimante(Imprimante imprimante) {
		// TODO Auto-generated method stub
		imprimanteRepository.save(imprimante);
		
	}
    
	
	
}
