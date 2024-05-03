package com.example.demo.entity;

import jakarta.persistence.*;

@Entity
public class Responsable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Responsable() {
        // Constructeur par défaut
    }

	public Long getId() {
		return id;
	}

	public User getUser() {
		return user;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setUser(User user) {
		this.user = user;
	}

	

    // Ajoutez vos méthodes spécifiques pour le Responsable ici
}
