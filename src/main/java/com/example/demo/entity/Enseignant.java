package com.example.demo.entity;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Enseignant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(mappedBy = "chefDep")
    private Departement departementChef;

    @ManyToOne
    @JoinColumn(name = "departement_id")
    private Departement departement;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "enseignant", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Ressource> ressources = new ArrayList<>();

    @OneToMany(mappedBy = "enseignant", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Affectation> affectations = new ArrayList<>();

    public Enseignant() {
        // Constructeur par défaut
    }

	public int getId() {
		return id;
	}

	public Departement getDepartementChef() {
		return departementChef;
	}

	public Departement getDepartement() {
		return departement;
	}

	public User getUser() {
		return user;
	}

	public List<Ressource> getRessources() {
		return ressources;
	}

	public List<Affectation> getAffectations() {
		return affectations;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setDepartementChef(Departement departementChef) {
		this.departementChef = departementChef;
	}

	public void setDepartement(Departement departement) {
		this.departement = departement;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setRessources(List<Ressource> ressources) {
		this.ressources = ressources;
	}

	public void setAffectations(List<Affectation> affectations) {
		this.affectations = affectations;
	}

    // Getters and setters
}
