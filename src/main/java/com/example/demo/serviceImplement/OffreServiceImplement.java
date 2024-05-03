package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Offre;
import com.example.demo.repository.OffreRepository;
import com.example.demo.service.OffreService;

@Service
public class OffreServiceImplement  implements OffreService{
	
	final OffreRepository  offrerepository ;
	
	@Autowired 
	public OffreServiceImplement(OffreRepository offrerepository) {
	
		this.offrerepository = offrerepository;
	}

	@Override
	public boolean AjouterOffre(Offre offre) {
		 try {
		    	 offrerepository.save(offre);
		        return true; // Retourne true si l'ajout est réussi
		    } catch (Exception e) {
		        e.printStackTrace();
		        return false; // Retourne false si l'ajout échoue
		    }
	}

	@Override
	public List<Offre> GetOffreFr(int frnId) {
		return offrerepository.findByFournisseurId(frnId);
	}

	@Override
	public Offre getOffre(Long offre_id) {
		Offre offre = offrerepository.findById(offre_id).get();
		return offre;
	}

	@Override
	public void SupprimerOffre(Offre offre) {
		offrerepository.delete(offre);
		
	}

	@Override
	public List<Offre> GetOffre() {
		return offrerepository.findAll();
	}
	
	
	@Override
	public Offre getOffreByIdAndEtat(Long id,int etat) {
		// TODO Auto-generated method stub
		return offrerepository.findByIdAndEtat(id,etat);
	}
	
	

}
