package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Technicien;

public interface TechnicienService {

 Technicien findTech(Long techId);

List<Technicien> getTech();

Technicien getTechnicienByUserId(int userId);
	

}
