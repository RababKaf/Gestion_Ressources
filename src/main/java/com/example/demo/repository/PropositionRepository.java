package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.*;

@Repository
public interface PropositionRepository extends JpaRepository<Proposition, Integer> {
	 List<Proposition> findByOffreIsNull();
	 
	    List<Proposition>  findByRessourceId(int ressourceId);
	    void deleteByRessourceId(int ressourceId);

}
