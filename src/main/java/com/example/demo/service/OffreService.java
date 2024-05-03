package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Offre;
import com.example.demo.entity.Proposition;

public interface OffreService {
	
	public boolean AjouterOffre(Offre offre) ;
	public List<Offre> GetOffreFr(int frnId) ;
	public Offre getOffre(Long offre_id) ;
	public void SupprimerOffre(Offre offre) ;
	public List<Offre> GetOffre();
	
    public Offre getOffreByIdAndEtat(Long long1,int etat);

}
