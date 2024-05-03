package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.*;

public interface UserService {
	 public boolean validateUser(String email, String password);
	 public User findUser(String email);
	public User saveUser(User user);
	public int verifyUser(String email);
	List<User> findUserByRole(int i);
	
	
	Enseignant getCHDCH(int idUser);
	Enseignant getEnseignantCH(int idUser);
	
	User getResponsableCH();
	
	public User ChercherUserFr(int userId ) ;
	User getUserById(int idUser);

	List<User> getAllEnseignants(int role);

}
