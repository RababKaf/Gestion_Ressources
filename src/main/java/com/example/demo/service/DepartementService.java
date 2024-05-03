package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Departement;

public interface DepartementService {

	
	Departement getDepartementRespo(int id);

	List<Departement> getAll();
	
}
