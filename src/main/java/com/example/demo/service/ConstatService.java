package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Constat;
import com.example.demo.entity.Panne;

public interface ConstatService {

	void saveConstat(Constat constat);

	List<Constat> getAllConstats();

	Constat getconstat(Integer  constatId);
	
	void deleteConstatByPanneId(int panneId);

}
