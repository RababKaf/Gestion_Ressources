package com.example.demo.entity;

import java.sql.Date;

import jakarta.persistence.*;

@Entity
public class Proposition {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "marque")
    private String marque;

    @Column(name = "prix")
    private double prix;

    @Column(name = "duree_garantie")
    private Date DureGarantie;
    
    
    @ManyToOne
    @JoinColumn(name = "offre_id")
    private Offre offre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ressource_id")
    private Ressource ressource;

    public Proposition() {
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMarque() {
		return marque;
	}

	public void setMarque(String marque) {
		this.marque = marque;
	}

	public double getPrix() {
		return prix;
	}

	public void setPrix(double prix) {
		this.prix = prix;
	}

	public Date getDureGarantie() {
		return DureGarantie;
	}

	public void setDureGarantie(Date dureGarantie) {
		DureGarantie = dureGarantie;
	}

	public Offre getOffre() {
		return offre;
	}

	public void setOffre(Offre offre) {
		this.offre = offre;
	}

	public Ressource getRessource() {
		return ressource;
	}

	public void setRessource(Ressource ressource) {
		this.ressource = ressource;
	}

    
    // Ajoutez vos getters et setters ici
}
   
