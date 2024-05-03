package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Technicien;
@Repository
public interface TechnicienRepository extends JpaRepository<Technicien,Long>{
	
	 Technicien findByUserId(int userId);

}
