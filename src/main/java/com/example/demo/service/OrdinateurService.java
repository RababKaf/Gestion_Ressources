package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import com.example.demo.entity.Ordinateur;

public interface OrdinateurService {
	


	Ordinateur getOrdinateursEns(Integer id);
	void deleteOrdinateursEns(Long id);
	Ordinateur getOrdinateurE(Long id);
	void addOrdinateurEns(Ordinateur ord);
	
	
	

	Ordinateur GetListeOrdinateurFrn(int ressourceId);
	
	
	 public  Ordinateur GetListeOrdinateurRespo(int ressourceId) ;

		public void deleteOrdinateur(Long id);
		void updateOrdinateur(Ordinateur ordinateur);
}
