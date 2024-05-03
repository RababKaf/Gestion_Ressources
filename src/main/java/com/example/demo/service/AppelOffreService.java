package com.example.demo.service;

import java.sql.Date;
import java.util.List;

import com.example.demo.entity.AppelOffre;

public interface AppelOffreService {

	List<AppelOffre> getAllService();
	
	public List<AppelOffre> getAppelOffresFr() ;
	public AppelOffre ChercherAOFr(int id) ;
	
	public List<AppelOffre> getListeAppelesOffres();
	public void insertAppelOffre(Date dateDebut,Date deteFin, String description);
	public int getLastInsertId();
	public AppelOffre updateAppelOffre(AppelOffre appelOffre);
	public AppelOffre getAppelOffreById(int id);


}
