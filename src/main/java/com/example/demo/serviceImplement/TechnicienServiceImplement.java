package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Technicien;
import com.example.demo.repository.TechnicienRepository;
import com.example.demo.service.TechnicienService;
@Service
public class TechnicienServiceImplement implements TechnicienService {
@Autowired
TechnicienRepository technicienRepository;
	@Override
	public Technicien findTech(Long techId) {
		// TODO Auto-generated method stub
		return technicienRepository.getReferenceById(techId);
	}
	@Override
	public List<Technicien> getTech() {
		// TODO Auto-generated method stub
		return technicienRepository.findAll();
	}
	@Override
	public Technicien getTechnicienByUserId(int userId) {
        return technicienRepository.findByUserId(userId);
    }
}
