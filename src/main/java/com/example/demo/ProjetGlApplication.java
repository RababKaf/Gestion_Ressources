package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;



@SpringBootApplication
public class ProjetGlApplication {
	


	public static void main(String[] args) {
	
		
		SpringApplication.run(ProjetGlApplication.class, args);
	}
	
	
	

}
