package com.example.demo.entity;


import java.util.Date;

import jakarta.persistence.*;


@Entity
public class Affectation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "date_affectation")
    private Date dateAffectation;

    public int getId() {
		return id;
	}

	public Date getDateAffectation() {
		return dateAffectation;
	}

	public String getEtat() {
		return etat;
	}

	public Ressource getRessource() {
		return ressource;
	}

	public Enseignant getEnseignant() {
		return enseignant;
	}

	public Departement getDepartement() {
		return departement;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setDateAffectation(Date dateAffectation) {
		this.dateAffectation = dateAffectation;
	}

	public void setEtat(String etat) {
		this.etat = etat;
	}

	public void setRessource(Ressource ressource) {
		this.ressource = ressource;
	}

	public void setEnseignant(Enseignant enseignant) {
		this.enseignant = enseignant;
	}

	public void setDepartement(Departement departement) {
		this.departement = departement;
	}


	@Column(name = "etat")
    private String etat;

    
    public Affectation() {
		
	}




	public Affectation(Ressource ressource, Departement departement) {
		super();
		this.ressource = ressource;
		this.departement = departement;
	}



	public Affectation(Ressource ressource, Enseignant enseignant) {
		super();
		this.ressource = ressource;
		this.enseignant = enseignant;
	}


	@OneToOne
    @JoinColumn(name = "ressource_id")
    private Ressource ressource;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "enseignant_id")
    private Enseignant enseignant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Departement departement;
    
}
