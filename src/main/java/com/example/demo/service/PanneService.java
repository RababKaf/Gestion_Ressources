package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.*;

public interface PanneService {
	public void enregPanne(Panne panne);

	List<Panne> getALLPanne();

	public Panne getPanne(Integer panneId);

	List<Panne> getPannesByTechnicienWithNullConstat(Technicien technicien);

	public List<Panne> getPannesByTechnicienWithNullConstat7(Technicien tech);
	
	public void addPanne(Panne p);
	
	public Panne getPanneRsp(int id) ;
	public Constat getConstatRsp(int id) ;
	public List<Panne> getPannesRsp();

	

	void deletePanne(int ressourceId);
	List<Panne> getPanneByRessource( int ressourceId);

	
}
