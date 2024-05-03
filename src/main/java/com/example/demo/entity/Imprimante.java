package com.example.demo.entity;

import jakarta.persistence.*;

@Entity
public class Imprimante {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "resolution")
    private String resolution;

    @Column(name = "vitesse_impression")
    private String vitesseImpression;

    @OneToOne
    @JoinColumn(name = "ressource_id")
    private Ressource ressource;

    public Imprimante() {
        // Constructeur par défaut
    }

	public Imprimante(String resolution, String vitesseImpression, Ressource ressource) {
		super();
		this.resolution = resolution;
		this.vitesseImpression = vitesseImpression;
		this.ressource = ressource;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public String getVitesseImpression() {
		return vitesseImpression;
	}

	public void setVitesseImpression(String vitesseImpression) {
		this.vitesseImpression = vitesseImpression;
	}

	public Ressource getRessource() {
		return ressource;
	}

	public void setRessource(Ressource ressource) {
		this.ressource = ressource;
	}

    
}