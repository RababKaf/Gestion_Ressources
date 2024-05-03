package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.Imprimante;
import com.example.demo.entity.Ordinateur;

public interface ImprimanteRepository  extends JpaRepository<Imprimante, Integer>{
	Imprimante findByRessourceId(Integer ressourceId);
	Imprimante findByRessourceId(int ressourceId) ;
	
	
	void  deleteByRessourceId(int ressourceId);
}
