package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Proposition;
import com.example.demo.repository.*;
import com.example.demo.service.*;

import jakarta.transaction.Transactional;

@Service
public class PropositionServiceImplement  implements PropositionService {
	
private final PropositionRepository propositionrepository ;
	
	@Autowired
	public PropositionServiceImplement(PropositionRepository propositionrepository)
	{
		this.propositionrepository=propositionrepository ;
	}

	@Override
	public boolean AjouterPropsition(Proposition proposition) {
	    try {
	        propositionrepository.save(proposition);
	        return true; // Retourne true si l'ajout est réussi
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false; // Retourne false si l'ajout échoue
	    }
	}

	@Override
	public List<Proposition> recupererPropositionsAvecOffreNull() {
		
		return propositionrepository.findByOffreIsNull();
	}

	@Override
	public void modifierProposition(Proposition proposition) {
		propositionrepository.save(proposition);
		
	}
	
	@Override
	public Proposition GetPropositionFrn(int id_prop)
	{
		return propositionrepository.findById(id_prop).get() ;
	}

	@Override
	public void SupprimerProp(Proposition prp) {
		propositionrepository.delete(prp);
		
	}
	
	@Override
	public List<Proposition> getPropositionByIdRessource(int id) {
		// TODO Auto-generated method stub
		return propositionrepository.findByRessourceId(id);
	}
	@Transactional
	@Override
	public void deleteProposition(int ressourceId) {
		// TODO Auto-generated method stub
		propositionrepository.deleteByRessourceId(ressourceId);
		
	}

}
