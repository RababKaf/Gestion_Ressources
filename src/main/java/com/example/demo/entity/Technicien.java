package com.example.demo.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Technicien {

    public Long getId() {
		return id;
	}

	public User getUser() {
		return user;
	}

	public List<Panne> getPannes() {
		return pannes;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setPannes(List<Panne> pannes) {
		this.pannes = pannes;
	}

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "technicien", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Panne> pannes = new ArrayList<>();

    public Technicien() {
        // Constructeur par défaut
    }

    // Ajoutez vos méthodes spécifiques pour le Technicien ici
}
