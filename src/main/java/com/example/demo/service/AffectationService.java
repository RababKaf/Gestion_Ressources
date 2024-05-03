package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Affectation;

public interface AffectationService {

	void affecter(Affectation af);
	
	List<Affectation> getAffectationCHD(int idDepa);
	void deleteAffectationCHD(int idAff);

	Affectation getAffectationByressourceId(int ressourceId);
	void  deleteAffectation (int ressourceId);
	Affectation getAffectationById(int affectationId);
	void updateAffectationNULL(int ressourceId);
	public void updateAffectationDep(int ressourceId,int idDep);
	public void updateAffectationEns(int ressourceId,int idEns);
}
