package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.Enseignant;
import com.example.demo.entity.Ressource;

public interface EnseignantRepository extends JpaRepository<Enseignant,Integer> {
  List<Enseignant> getEnseignantByDepartementId(int idDepar);

Enseignant findEnseignantById(int id);
}
