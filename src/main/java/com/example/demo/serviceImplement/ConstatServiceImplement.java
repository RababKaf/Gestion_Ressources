package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Constat;
import com.example.demo.repository.*;
import com.example.demo.service.ConstatService;

import jakarta.transaction.Transactional;
@Service
public class ConstatServiceImplement implements ConstatService{
	@Autowired
	ConstatRepository constatRepository;
	@Override
	public void saveConstat(Constat constat) {
		
	 constatRepository.save(constat);
		
	}
	@Override
	public List<Constat> getAllConstats() {
		// TODO Auto-generated method stub
		return constatRepository.findAll();
	}
	@Override
	public Constat getconstat(Integer constatId) {
		// TODO Auto-generated method stub
		return constatRepository.getReferenceById(constatId);
	}
	@Transactional
	@Override
    public void deleteConstatByPanneId(int panneId) {
        constatRepository.deleteByPanneId(panneId);
    }
}
