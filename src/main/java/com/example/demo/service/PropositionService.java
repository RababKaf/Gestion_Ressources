package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Proposition;

public interface PropositionService {
	
	public boolean AjouterPropsition(Proposition proposition) ;
	public List<Proposition> recupererPropositionsAvecOffreNull() ;
	void modifierProposition(Proposition proposition);
	public Proposition GetPropositionFrn(int id_prop);
	public void SupprimerProp(Proposition prp );
	

    public List<Proposition> getPropositionByIdRessource(int id);
    public void deleteProposition(int ressourceId);

}
