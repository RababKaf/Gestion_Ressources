package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.entity.Affectation;
import com.example.demo.entity.Notification;

import jakarta.transaction.Transactional;

public interface AffectationRepository extends JpaRepository<Affectation, Integer> {
	 List<Affectation> findByDepartementId(int idDepar);
	 

		Affectation findByRessourceId(int ressourceId);
		void deleteByRessourceId(int ressourceId);
		Affectation findById(int affectationId);
		
		 @Transactional
		    @Modifying
		    @Query("UPDATE Affectation a SET a.enseignant = null, a.departement = null WHERE a.ressource.id = :ressourceId")
		    void removeEnseignantAndDepartementByRessourceId(@Param("ressourceId") int ressourceId);
		 @Transactional
		    @Modifying
		    @Query("UPDATE Affectation a SET a.enseignant.id = :enseignant WHERE a.ressource.id = :ressourceId")
		    void updateEnseignantByRessourceId(@Param("enseignant") int enseignant, @Param("ressourceId") int ressourceId);
		    
		 @Transactional
		    @Modifying
		    @Query("UPDATE Affectation a SET a.departement.id = :departementId WHERE a.ressource.id = :ressourceId")
		    void updateDepartementIdByRessourceId(@Param("departementId") int departementId, @Param("ressourceId") int ressourceId);
		
}
