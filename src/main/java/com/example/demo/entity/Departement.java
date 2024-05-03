package com.example.demo.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
public class Departement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String nomDepartement;

    @OneToMany(mappedBy = "departement", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Affectation> affectations = new ArrayList<>();
     
    @OneToOne
    @JoinColumn(name = "chefDep_id")
    private Enseignant chefDep;

    @OneToMany(mappedBy = "departement")
    private List<Enseignant> enseignants = new ArrayList<>();

    public Departement() {
        // Constructeur par défaut
    }

	public int getId() {
		return id;
	}

	public String getNomDepartement() {
		return nomDepartement;
	}

	public List<Affectation> getAffectations() {
		return affectations;
	}

	public Enseignant getChefDep() {
		return chefDep;
	}

	public List<Enseignant> getEnseignants() {
		return enseignants;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setNomDepartement(String nomDepartement) {
		this.nomDepartement = nomDepartement;
	}

	public void setAffectations(List<Affectation> affectations) {
		this.affectations = affectations;
	}

	public void setChefDep(Enseignant chefDep) {
		this.chefDep = chefDep;
	}

	public void setEnseignants(List<Enseignant> enseignants) {
		this.enseignants = enseignants;
	}

    // Getters and setters
}
