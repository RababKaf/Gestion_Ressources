package com.example.demo.serviceImplement;


import com.example.demo.entity.*;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImplement implements UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserServiceImplement(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

	
	@Override
	public boolean validateUser(String email, String password) {
	    User user = userRepository.findByEmail(email);
	    if(user==null)
	    	return false;
        return user != null && user.getMot_de_passe().equals(password);
	   
       
	}

	  @Override
	    public User saveUser(User user) {
	        return userRepository.save(user);
	    }
	  
	@Override
	public User findUser(String email) {
		User user = userRepository.findByEmail(email);
	
		
		return user;
	}


	@Override
	public int verifyUser(String email) {
	
		List<User> users=userRepository.findAll();
		for (User user : users) {
			if(email.equals(user.getEmail()))
		      return 1;
		}
		return 0;
		
	}
@Override
public List<User> findUserByRole(int i){

	return userRepository.findByRole(i);
}



	@Override
	public Enseignant getCHDCH(int id) {
		// TODO Auto-generated method stub
		return userRepository.getById(id).getEnseignant();
		
	}


	@Override
	public Enseignant getEnseignantCH(int id) {
		// TODO Auto-generated method stub
		return userRepository.getById(id).getEnseignant().getDepartement().getChefDep();
	}


	@Override
	public User getResponsableCH() {
		// TODO Auto-generated method stub
//		List<User> rsps=userRepository.findAll();
//		for ( User r : rsps) {
//			if(r.getRole()==5)
//				return r;
//		}
		List<User> users=userRepository.findByRole(5);
	
		return users.get(0);
			
		  
	}
	@Override
	public User ChercherUserFr(int userId) {
		User user =userRepository.findById(userId);
		return user;
	}
	
	@Override
	public User getUserById(int idUser) {
		// TODO Auto-generated method stub
		return userRepository.findById(idUser);
	}


	@Override
	public List<User> getAllEnseignants(int role) {
		// TODO Auto-generated method stub
		return userRepository.findByRole(role);
	}

}
