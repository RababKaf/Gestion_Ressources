package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Departement;

@Repository
public interface DepartementRepository extends JpaRepository<Departement, Integer>{

	
	Departement findDepartementById(int id);
}
