package com.example.demo.serviceImplement;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.*;
import com.example.demo.entity.Ressource;
import com.example.demo.repository.RessourceRepository;
import com.example.demo.service.RessourceService;
@Service
public class RessourceServiceImplement implements RessourceService {
	  @Autowired
	    private RessourceRepository ressourceRepository;
	


	    @Override
	    public List<Ressource> findCaracteristiquesImprimanteByEtat(int etat) {
	        List<Ressource> ressources = ressourceRepository.findImprimantesByEtat(etat);
	       

	        return ressources;
	    }

	    @Override
	    public List<Ressource> findCaracteristiquesOrdinateurByEtat(int etat) {
	        List<Ressource> ressources = ressourceRepository.findOrdinateursByEtat(etat);
	     

	        return ressources;
	    }

	
		

		@Override
		public List<Ressource> findRessourcesByEnseignantId(Integer enseignantId) {
			// TODO Auto-generated method stub
			//enseignantId =1;
			return ressourceRepository.findByEnseignantId(enseignantId);
		}

		@Override
		public Ressource findRessource(Integer id) {
			// TODO Auto-generated method stub
			return ressourceRepository.getById(id);
		}

		@Override
		public void deleteRessource(Integer id) {
			// TODO Auto-generated method stub
			ressourceRepository.deleteById(id);
		}

		@Override
		public void addBesoin(Ressource bs) {
			// TODO Auto-generated method stub
			ressourceRepository.save(bs);
		}
		
		

		@Override
		public List<Ressource> listeRessourceFrn(int AppelOffreId) {
			
			List<Ressource> ListeRessource = ressourceRepository.findByAppelOffreId(AppelOffreId);
			
			
			return ListeRessource;
		}

		@Override
		public Ressource ChercherRessourceFrn(int ressourceId) {
			  Ressource rs =ressourceRepository.findById(ressourceId) ;
			return rs ;
		}

		@Override
		public void EnregisterDecisions(Ressource rs) {
			ressourceRepository.save(rs) ;
			
		}
		@Override
		public List<Ressource> listeRessourceRespo(int AppelOffreId) {
			// TODO Auto-generated method stub
			List<Ressource> ListeRessource = ressourceRepository.findByAppelOffreId(AppelOffreId);
			return ListeRessource;
		}
		
		@Override
		public List<Ressource> listeRessourceEtatRespo(int etat) {
			// TODO Auto-generated method stub
			List<Ressource> ListeRessource = ressourceRepository.findByEtat(etat);
			return ListeRessource;
		}

		@Override
		public void updateAppelOffreId(int ressourceId, int newAppelOffreId) {
			// TODO Auto-generated method stub
			ressourceRepository.updateAppelOffreIdForRessource(ressourceId, newAppelOffreId);
		}

		@Override
		public void updateCodeInventaire(int ressourceId, String codeInventaire) {
			// TODO Auto-generated method stub
			ressourceRepository.updateCodeInventaireForRessource(ressourceId, codeInventaire);
		}

		@Override
		public void updateEtatRessourceTo3Byid(int idRessource) {
			// TODO Auto-generated method stub
			ressourceRepository.updateEtatTo3ById(idRessource);
			
		}

		@Override
		public List<Ressource> getRessourcesLivres(int idAppelOffre) {
			// TODO Auto-generated method stub
			return ressourceRepository.findByAppelOffreIdAndCodeBarreIsNotNull(idAppelOffre);
		}

		@Override
		public void updateEtatRessourceTo4Byid(int idRessource) {
			// TODO Auto-generated method stub
			ressourceRepository.updateEtatTo4ById(idRessource);
		}

		@Override
		public List<Ressource> getAllRessources() {
			// TODO Auto-generated method stub
			return ressourceRepository.findAllByCodeBarreIsNotNull();
		}

		@Override
		public void deleteRessource(int id) {
			// TODO Auto-generated method stub
			ressourceRepository.deleteById(id);
			
		}

		@Override
		public Ressource getRessourceById(int ressourceId) {
			// TODO Auto-generated method stub
			return ressourceRepository.findById(ressourceId);
		}

		@Override
		public void enregistrerRessource(Ressource ressource) {
			// TODO Auto-generated method stub
			ressourceRepository.save(ressource);
		}

	

}
