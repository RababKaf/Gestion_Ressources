package com.example.demo.repository;

import com.example.demo.entity.User;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    User findByEmail(String email);
    List<User> findByRole(int role);
    
    User findById(int idUser);
   
    

	@Query("SELECT u, f FROM User u JOIN Fournisseur f ON u.id = f.user.id")
	List<Object[]> findUserAndFournisseur();
   
}
