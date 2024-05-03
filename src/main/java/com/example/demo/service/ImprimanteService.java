package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Imprimante;
import com.example.demo.entity.User;

public interface ImprimanteService {
	List<Imprimante> getImprimantesEns();

	Imprimante getImprimantesEns(Integer id);
	void deleteImprimantesEns(Integer id);
	Imprimante getImprimanteE(Integer id);
	void addImprimanteEns(Imprimante imp);
	
	
	Imprimante GetListeImprimanteFrn(int ressourceId) ;
	
	public   Imprimante GetListeImprimanteRespo(int ressourceId);
	public void deleteImprimante(int ressourceId);
	public void updateImprimante(Imprimante imprimante);


}
