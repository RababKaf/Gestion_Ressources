package com.example.demo.serviceImplement;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.demo.entity.Ordinateur;
import com.example.demo.repository.OrdinateurRepository;
import com.example.demo.repository.RessourceRepository;
import com.example.demo.service.OrdinateurService;

import jakarta.transaction.Transactional;
@Service
public class OrdinateurServiceImplement implements  OrdinateurService{

	private OrdinateurRepository ordinateurrepository;

	public OrdinateurServiceImplement(OrdinateurRepository ordinateurrepository) {
		super();
		this.ordinateurrepository = ordinateurrepository;
	}

	@Override
	public Ordinateur getOrdinateursEns(Integer id) {
		// TODO Auto-generated method stub
		return ordinateurrepository.findByRessourceId(id);
	}

	@Override
	public void deleteOrdinateursEns(Long id) {
		// TODO Auto-generated method stub
		ordinateurrepository.deleteById(id);
	}

	@Override
	public Ordinateur getOrdinateurE(Long id) {
		// TODO Auto-generated method stub
		return ordinateurrepository.getById(id);
	}

	@Override
	public void addOrdinateurEns(Ordinateur ord) {
		// TODO Auto-generated method stub
		ordinateurrepository.save(ord);
	}



	@Override
	public Ordinateur GetListeOrdinateurFrn(int ressourceId) {
		// TODO Auto-generated method stub
		return ordinateurrepository.findByRessourceId(ressourceId);
	}
	
	@Override
	public Ordinateur GetListeOrdinateurRespo(int ressourceId) {
		// TODO Auto-generated method stub
		return ordinateurrepository.findByRessourceId(ressourceId);
	}
	
	@Transactional
	@Override
	public void deleteOrdinateur(Long id) {
		// TODO Auto-generated method stub
		ordinateurrepository.deleteById(id);
		
	}
	@Override
	public void updateOrdinateur(Ordinateur ordinateur) {
		// TODO Auto-generated method stub
		ordinateurrepository.save(ordinateur);
		
	}

	
	
}
