package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Constat;
import com.example.demo.entity.Panne;
import com.example.demo.entity.Technicien;
import com.example.demo.repository.ConstatRepository;
import com.example.demo.repository.PanneRepository;
import com.example.demo.repository.TechnicienRepository;
import com.example.demo.service.PanneService;

import jakarta.transaction.Transactional;
@Service
public class PanneServiceImplement implements PanneService {
@Autowired
PanneRepository panneRepository;
@Autowired
ConstatRepository constatRepository ;
@Autowired
TechnicienRepository technicienRepository ;



@Override
public Panne getPanneRsp(int id) {
	Panne panne = panneRepository.findById(id).get();
	return panne ;
}


@Override
public Constat getConstatRsp(int id) {
	
	return constatRepository.findById(id).get();
}


@Override
public List<Panne> getPannesRsp() {
	
	return  panneRepository.findAll();
}

	@Override
	public void enregPanne(Panne panne) {
		panneRepository.save(panne);
		
		
	}
	
	@Override
	public  List<Panne> getALLPanne() {
		return panneRepository.findAllByRessourceEtatEquals6();
		
		
	}

	@Override
	public Panne getPanne(Integer panneId) {
		// TODO Auto-generated method stub
		return panneRepository.getReferenceById(panneId);
	}
	
	@Override
	 public List<Panne> getPannesByTechnicienWithNullConstat(Technicien technicien) {
	        return panneRepository.findByTechnicienAndConstatIsNull(technicien);
	    }

	@Override
	public List<Panne> getPannesByTechnicienWithNullConstat7(Technicien tech) {
		// TODO Auto-generated method stub
		return panneRepository.findPannesWithNullConstatAndEtatRessource7(tech);
	}
	
	@Override
	public void addPanne(Panne p) {
		
		panneRepository.save(p);
	}
	
	@Transactional
	@Override
	public void deletePanne(int ressourceId) {
		// TODO Auto-generated method stub

		panneRepository.deleteByRessourceId(ressourceId);
	}
	@Override
	public List<Panne> getPanneByRessource(int ressourceId) {
		// TODO Auto-generated method stub
		return panneRepository.findByRessourceId(ressourceId);
	}

}
