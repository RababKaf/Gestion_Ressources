package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.entity.Enseignant;
import com.example.demo.repository.EnseignantRepository;
import com.example.demo.service.EnseignantService;

@Service
public class EnseignantServiceImplement implements EnseignantService {

	private final EnseignantRepository enseignantrepository;
	
	
	public EnseignantServiceImplement(EnseignantRepository enseignantrepository) {
		super();
		this.enseignantrepository = enseignantrepository;
	}


	@Override
	public Enseignant getEnseignantEns(Integer id) {
		// TODO Auto-generated method stub
		return enseignantrepository.getById(id);
	}


	@Override
	public List<Enseignant> getEnseignantDepar(int idDep) {
		// TODO Auto-generated method stub
		return enseignantrepository.getEnseignantByDepartementId(idDep);
	}
	
 

    @Override
    public Enseignant getEnseignantRespo(int id) {
        return enseignantrepository.findEnseignantById(id);
    }

}
