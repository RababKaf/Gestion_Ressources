package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.Ordinateur;

public interface OrdinateurRepository extends JpaRepository<Ordinateur, Long> {
	Ordinateur findByRessourceId(Integer ressourceId);
	Ordinateur findByRessourceId(int ressourceId) ;

	void deleteById(Long idOrdinateur);
	
}
