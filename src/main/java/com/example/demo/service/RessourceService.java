package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import com.example.demo.entity.*;

public interface RessourceService {

	List<Ressource> findCaracteristiquesImprimanteByEtat(int etat);

	List<Ressource> findCaracteristiquesOrdinateurByEtat(int etat);

	Ressource findRessource(Integer ressourceId);
	
	
	List<Ressource> findRessourcesByEnseignantId(Integer enseignantId);

	void deleteRessource(Integer id);
	void addBesoin(Ressource bs);

	
	List<Ressource> listeRessourceFrn(int AppelOffreId) ;
	Ressource ChercherRessourceFrn(int ressourceId) ;
    public void EnregisterDecisions(Ressource rs) ;
    
    
    

	public  List<Ressource> listeRessourceRespo(int AppelOffreId) ;

	
	
	void updateAppelOffreId(int ressourceId,int newAppelOffreId);
	
	void updateCodeInventaire(int ressourceId,String codeInventaire);
	
	void updateEtatRessourceTo3Byid(int idRessource);
	
	 List<Ressource> getRessourcesLivres(int idAppelOffre);
	 
	 void updateEtatRessourceTo4Byid(int idRessource); 
	 
	 List<Ressource> getAllRessources();

	public void deleteRessource(int id);

	public Ressource getRessourceById(int ressourceId);

	public void enregistrerRessource(Ressource ressource);

	List<Ressource> listeRessourceEtatRespo(int etat);

}
