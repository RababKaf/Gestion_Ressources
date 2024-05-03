package com.example.demo.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.AppelOffre;

import jakarta.transaction.Transactional;

@Repository
public interface AppelOffreRepository extends JpaRepository<AppelOffre,Integer>{
	 @Query("SELECT DISTINCT ao FROM AppelOffre ao JOIN ao.ressources r WHERE ao.etat = 0 AND r.codeBarre IS NULL")
	    List<AppelOffre> findByEtatAndNullCodeBarre();
	 
	 List<AppelOffre> findAll();

	    
	    @Modifying
	    @Query(value = "INSERT INTO appel_offre (date_debut, date_fin, description, etat) VALUES (:dateDebut, :dateFin, :description, 0)", nativeQuery = true)
	    @Transactional
	    void insertAppelOffre(@Param("dateDebut") Date dateDebut, @Param("dateFin") Date dateFin, @Param("description") String description);

	    @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
	    int getLastInsertedId();
	    
	    @Transactional
	    AppelOffre save(AppelOffre appelOffre);


		AppelOffre getAppelOffreById(int id);
}
