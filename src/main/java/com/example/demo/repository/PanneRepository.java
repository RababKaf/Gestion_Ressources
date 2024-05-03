package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Panne;
import com.example.demo.entity.Technicien;
@Repository
public interface PanneRepository extends JpaRepository<Panne,Integer>{
	
	 @Query("SELECT p FROM Panne p WHERE p.ressource.etat = 6")
	    List<Panne> findAllByRessourceEtatEquals6();
	 
	 List<Panne> findByTechnicienAndConstatIsNull(Technicien technicien);
	 
	 @Query("SELECT p FROM Panne p WHERE  p.technicien = :technicien AND p.ressource.etat = 7")
	    List<Panne> findPannesWithNullConstatAndEtatRessource7(Technicien technicien);
	 

	 void deleteByRessourceId(int ressourceId);
	 List<Panne> findByRessourceId(int ressourceId); 

}
