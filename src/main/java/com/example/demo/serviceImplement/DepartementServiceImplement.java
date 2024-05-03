package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Departement;
import com.example.demo.repository.*;
import com.example.demo.service.DepartementService;


@Service
public class DepartementServiceImplement implements DepartementService {

	
	private final DepartementRepository departementRepository;
	
	@Autowired
	public DepartementServiceImplement(DepartementRepository departementRepository) {
		
		this.departementRepository=departementRepository;
	}
	@Override
	public Departement getDepartementRespo(int id) {
		// TODO Auto-generated method stub
		
		return departementRepository.findDepartementById(id);
		
	}
	@Override
	public List<Departement> getAll() {
		// TODO Auto-generated method stub
		return departementRepository.findAll();
	}

}
