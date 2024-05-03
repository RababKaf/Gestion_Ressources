package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Offre;

@Repository 
public interface OffreRepository extends JpaRepository<Offre , Long> {
	public List<Offre> findByFournisseurId(int Fournisseurid) ;
	
	Offre findByIdAndEtat(Long id, int etat);
}
