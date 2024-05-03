package com.example.demo.serviceImplement;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.AppelOffre;
import com.example.demo.repository.AppelOffreRepository;
import com.example.demo.service.AppelOffreService;
@Service
public class AppelOffreServiceImplement implements AppelOffreService{
@Autowired
AppelOffreRepository appelOffreRepository;
	@Override
	public List<AppelOffre> getAllService() {
		// TODO Auto-generated method stub
		return appelOffreRepository.findByEtatAndNullCodeBarre();
	}
	@Autowired
	public AppelOffreServiceImplement(AppelOffreRepository appeloffrerepository)
	{
		this.appelOffreRepository=appeloffrerepository ;
	}
	
	public List<AppelOffre> getAppelOffresFr()
	{
		
		return appelOffreRepository.findAll() ;
	}

	@Override
	public AppelOffre ChercherAOFr(int id) {
		
		return appelOffreRepository.findById(id).get();
	}
	   @Override
	    public List<AppelOffre> getListeAppelesOffres() {
	        return appelOffreRepository.findAll();
	    }

		@Override
		public void insertAppelOffre(Date dateDebut, Date deteFin,String description) {
			// TODO Auto-generated method stub
			appelOffreRepository.insertAppelOffre(dateDebut, deteFin,description);
			
		}

		@Override
		public int getLastInsertId() {
			// TODO Auto-generated method stub
			return appelOffreRepository.getLastInsertedId();
		}

		@Override
		public AppelOffre updateAppelOffre(AppelOffre appelOffre) {
			// TODO Auto-generated method stub
			return appelOffreRepository.save(appelOffre);
			
		}

		@Override
		public AppelOffre getAppelOffreById(int id) {
			// TODO Auto-generated method stub
			return appelOffreRepository.getAppelOffreById(id);
		}
}
