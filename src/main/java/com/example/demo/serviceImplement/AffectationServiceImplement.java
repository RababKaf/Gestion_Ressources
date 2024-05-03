package com.example.demo.serviceImplement;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.entity.Affectation;
import com.example.demo.repository.AffectationRepository;
import com.example.demo.service.AffectationService;

import jakarta.transaction.Transactional;

@Service
public class AffectationServiceImplement  implements AffectationService{
private final AffectationRepository affectationrepository;

public AffectationServiceImplement(AffectationRepository affectationrepository) {
	super();
	this.affectationrepository = affectationrepository;
}

@Override
public void affecter(Affectation af) {
	// TODO Auto-generated method stub
	affectationrepository.save(af);
}

@Override
public List<Affectation> getAffectationCHD(int idDepa) {
	// TODO Auto-generated method stub
	return affectationrepository.findByDepartementId(idDepa);
}

@Override
public void deleteAffectationCHD(int idAff) {
	// TODO Auto-generated method stub
	affectationrepository.deleteById(idAff);
}

@Override
public Affectation getAffectationByressourceId(int ressourceId) {
	// TODO Auto-generated method stub
	return affectationrepository.findByRessourceId(ressourceId);
}

@Transactional
@Override
public void deleteAffectation(int ressourceId) {
	// TODO Auto-generated method stub
	affectationrepository.deleteByRessourceId(ressourceId);
}


@Override
public Affectation getAffectationById(int affectationId) {
	// TODO Auto-generated method stub
	return affectationrepository.findById(affectationId);
}


@Override
public void updateAffectationNULL(int ressourceId) {
	// TODO Auto-generated method stub
	affectationrepository.removeEnseignantAndDepartementByRessourceId(ressourceId);
}


@Override
public void updateAffectationEns(int ressourceId,int idEns) {
	// TODO Auto-generated method stub
	affectationrepository.updateEnseignantByRessourceId(idEns, ressourceId);
}

@Override
public void updateAffectationDep(int ressourceId,int idDep) {
	// TODO Auto-generated method stub
	affectationrepository.updateDepartementIdByRessourceId(idDep, ressourceId);
}

}
