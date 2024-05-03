package com.example.demo.serviceImplement;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.service.FournisseurService;
@Service
public class FournisseurServiceImplement implements FournisseurService {
	private final FournisseurRepository fournisseurRepository;
	
    private final UserRepository userRepository ;
	@Autowired
	public FournisseurServiceImplement(FournisseurRepository fournisseurRepository , UserRepository userRepository) {
		super();
		this.fournisseurRepository = fournisseurRepository;
		this.userRepository = userRepository;
	}
	

	@Override
	public Fournisseur ChercherFrn(int frnId) {
		Fournisseur fr=fournisseurRepository.findById(frnId) ;
		return fr;
	}


	@Override
	public Object[][] getUsersAndFournisseurs() {
		
		List<Object[]> userAndFournisseurList = userRepository.findUserAndFournisseur();

	        Object[][] result = new Object[userAndFournisseurList.size()][2];
	        int index = 0;
	        for (Object[] objects : userAndFournisseurList) {
	            User user = (User) objects[0];
	            Fournisseur fournisseur = (Fournisseur) objects[1];
	            result[index][0] = user;
	            result[index][1] = fournisseur;
	            index++;
	        }
		
		return  result ;
	}


	@Override
	public void EnregisterFr(Fournisseur fournisseur) {
		fournisseurRepository.save(fournisseur) ;
		
		
	}
	 
	
	


	@Override
	public Fournisseur getFournisseurById(int id) {
		// TODO Auto-generated method stub
		return fournisseurRepository.findById(id);
	}

	@Override
	public void enregistrerFournisseur(Fournisseur fournisseur) {
		// TODO Auto-generated method stub
		 fournisseurRepository.updateFournisseur(fournisseur.getId(),fournisseur.getAdresse(),
				fournisseur.getNomSociete(),
				fournisseur.getNomCompletGerant(),
				fournisseur.getSiteInternet());
	}


		@Override
	public Fournisseur saveFournisseur(Fournisseur fournisseur) {
        return fournisseurRepository.save(fournisseur);
    }

}
