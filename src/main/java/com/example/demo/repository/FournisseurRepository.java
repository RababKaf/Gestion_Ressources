package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.entity.Fournisseur;

import jakarta.transaction.Transactional;

public interface FournisseurRepository extends JpaRepository<Fournisseur,Integer> {
	 Fournisseur findById(int id);
	    
	    // Méthode pour mettre à jour un fournisseur selon son ID
	    @Transactional
	    @Modifying
	    @Query("UPDATE Fournisseur f SET f.adresse = :adresse, f.nomSociete = :nomSociete, "
	    		+ "f.nomCompletGerant = :nomCompletGerant, f.siteInternet = :siteInternet "
	    		+ "WHERE f.id = :id")
	    void updateFournisseur(@Param("id") int id, 
	    		@Param("adresse") String adresse, 
	    		@Param("nomSociete") String nomSociete,
	    		@Param("nomCompletGerant") String nomCompletGerant, 
	    		@Param("siteInternet") String siteInternet);
}
