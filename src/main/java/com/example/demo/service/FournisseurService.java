package com.example.demo.service;

import com.example.demo.entity.Fournisseur;

public interface FournisseurService {
	public Fournisseur saveFournisseur(Fournisseur fournisseur) ;
	
	public Fournisseur ChercherFrn(int frnId) ;
	public Object[][] getUsersAndFournisseurs() ;
	public void EnregisterFr(Fournisseur fournisseur);
	  public Fournisseur getFournisseurById(int id);

		public void enregistrerFournisseur(Fournisseur fournisseur);
}
