package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Ressource;

import jakarta.transaction.Transactional;
@Repository
public interface RessourceRepository extends JpaRepository<Ressource,Integer>{
	  @Query("SELECT r FROM Ressource r INNER JOIN FETCH r.imprimante WHERE r.etat = ?1")
	    List<Ressource> findImprimantesByEtat(int etat);

	    @Query("SELECT r FROM Ressource r INNER JOIN FETCH r.ordinateur WHERE r.etat = ?1")
	    List<Ressource> findOrdinateursByEtat(int etat);
	    
	    
		List<Ressource> findByEnseignantId(Integer idEnseignant);
		
		List<Ressource> findByAppelOffreId(int AppelOffreId) ;
		
		List<Ressource> findByEtat(int etat);
		
		
		List<Ressource> findByEtatAndAppelOffreId(int etat, int appelOffreId);
	    List<Ressource> findAllByCodeBarreIsNotNull();
	    void deleteById(int idRessource);
	    Ressource findById(int ressourceId);
		
		@Transactional
		@Modifying
		@Query("UPDATE Ressource r SET r.appelOffre.id = :newAppelOffreId WHERE r.id = :ressourceId")
		void updateAppelOffreIdForRessource(@Param("ressourceId") int ressourceId, @Param("newAppelOffreId") int newAppelOffreId);

		@Transactional
		 @Modifying
		    @Query("UPDATE Ressource r SET r.codeBarre = :codeBarre WHERE r.id = :ressourceId")
		    void updateCodeInventaireForRessource(@Param("ressourceId") int ressourceId, @Param("codeBarre") String codeBarre);

		@Transactional
	    @Modifying
	    @Query("UPDATE Ressource r SET r.etat = 3 WHERE r.id = :id")
	    void updateEtatTo3ById(@Param("id") int id);
		
		@Transactional
	    @Modifying
	    @Query("UPDATE Ressource r SET r.etat = 4 WHERE r.id = :id")
	    void updateEtatTo4ById(@Param("id") int id);
		
		

		@Query("SELECT r FROM Ressource r WHERE r.appelOffre.id = :appelOffreId AND r.codeBarre IS NOT NULL")
	    List<Ressource> findByAppelOffreIdAndCodeBarreIsNotNull(@Param("appelOffreId") int appelOffreId);

}
