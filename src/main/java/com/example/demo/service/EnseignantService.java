package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Enseignant;

public interface EnseignantService {
	Enseignant getEnseignantEns(Integer id);
	List<Enseignant> getEnseignantDepar(int idDep);
	
	public Enseignant getEnseignantRespo(int id);

}
