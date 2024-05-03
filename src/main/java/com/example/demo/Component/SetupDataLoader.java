package com.example.demo.Component;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.*;
import com.example.demo.entity.Technicien;
import com.example.demo.entity.User;
import com.example.demo.repository.*;





@Component
public class SetupDataLoader implements ApplicationListener<ContextRefreshedEvent> {

    private boolean alreadySetup = false;

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ResponsableRepository responsableRepository;
    @Autowired
    private TechnicienRepository technicienRepository;
    @Autowired
    private DepartementRepository departementRepository;
    @Autowired
    private EnseignantRepository enseignantRepository;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		  if (alreadySetup) {
	            return;
	        }
			
			User user=new User();
			// chef departement 
			user=createUserIfNotFound("tahaNamir@gmail.com","Taha Namir","1234",1,"0685122445");
			
			//enseignant
			user=createUserIfNotFound("AbdouKaf@gmail.com","Abdoulmalek Kaf","1234",2,"0689958540");
			user=createUserIfNotFound("yasserNwabghi@gmail.com","Yasser nwabghi","1234",2,"0744517879");
			
			//Responsable
			user=createUserIfNotFound("IlhameJebbari@gmail.com","Ilhame Jebbari","1234",5,"0665602233");

			
			//service Maint
			
			user=createUserIfNotFound("ServiceMaintRN@gmail.com","Service MaintRN","1234",6,"0520154232");
			//technicien
			user=createUserIfNotFound("RababKaf@gmail.com","Rabab Kaf","1234",4,"0741213022");
			user=createUserIfNotFound("SalwaAlaoui@gmail.com","Salwa Alaoui","1234",4,"0600215855");
			user=createUserIfNotFound("ChaimaeIsmaili@gmail.com","Chaimae Ismaili","1234",4,"0655152324");
			
	
	
	
	
	
	}
	


    @Transactional
    private final User createUserIfNotFound(final String email, final String firstName, final String password, final int role,final String tele) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            user = new User();
            user.setNom_complet(firstName);
            user.setMot_de_passe(password);
            user.setEmail(email);
            user.setRole(role);
            user.setTel(tele);  
            //pour le chef
            if(role==1) {
            	user = userRepository.save(user);
            	Enseignant ens=new Enseignant();
            	ens.setUser(user);
            	
            	enseignantRepository.save(ens);
            	
            	Departement dep=new Departement();
            	dep.setNomDepartement("Informatique");
            	
            	dep.setChefDep(ens);
            	departementRepository.save(dep);
            	
            	ens.setDepartement(dep);
            	enseignantRepository.save(ens);
            	
            // pour les enseignants	
            }
            else
            if(role==2) {
            	user = userRepository.save(user);
            	Enseignant ens=new Enseignant();
            	ens.setUser(user);
            	
            	enseignantRepository.save(ens);
            	
            	Departement dep=new Departement();
            	dep.setNomDepartement("Informatique");
            	
            	User userChef=userRepository.findByEmail("tahaNamir@gmail.com");
            	dep.setChefDep(userChef.getEnseignant());
            	departementRepository.save(dep);
            	
            	ens.setDepartement(dep);
            	enseignantRepository.save(ens);
            	
            }
            
            
            
            
            //pour les techniciens
            else  
          if(role==4) {
        	  user = userRepository.save(user);
        	  Technicien tech=new Technicien();
        	  tech.setUser(user);
        	  technicienRepository.save(tech);
          }
          
          //pour les responsables
          else
          if(role==5) {
        	  user = userRepository.save(user);
        	  Responsable res=new Responsable();
        	  res.setUser(user);
        	  responsableRepository.save(res);
          }
          
        
        }
        if(role==6) 
        	user=userRepository.save(user);
        
        return user;
    }
















}











