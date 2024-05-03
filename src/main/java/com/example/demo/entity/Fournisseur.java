package com.example.demo.entity;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Fournisseur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "adresse")
    private String adresse;

    @Column(name = "nom_societe")
    private String nomSociete;

    @Column(name = "nom_complet_gerant")
    private String nomCompletGerant;
    
    @Column(name = "listeNoire")
    private int listeNoire=-1;


    @Column(name = "site_internet")
    private String siteInternet;

    @OneToMany(mappedBy = "fournisseur", cascade = CascadeType.ALL)
    private List<Offre> offres = new ArrayList<>();

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Fournisseur() {
        // Constructeur par défaut
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAdresse() {
		return adresse;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}

	public String getNomSociete() {
		return nomSociete;
	}

	public void setNomSociete(String nomSociete) {
		this.nomSociete = nomSociete;
	}

	public String getNomCompletGerant() {
		return nomCompletGerant;
	}

	public void setNomCompletGerant(String nomCompletGerant) {
		this.nomCompletGerant = nomCompletGerant;
	}

	public int getListeNoire() {
		return listeNoire;
	}

	public void setListeNoire(int listeNoire) {
		this.listeNoire = listeNoire;
	}

	public String getSiteInternet() {
		return siteInternet;
	}

	public void setSiteInternet(String siteInternet) {
		this.siteInternet = siteInternet;
	}

	public List<Offre> getOffres() {
		return offres;
	}

	public void setOffres(List<Offre> offres) {
		this.offres = offres;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

    
    // Getters and setters
}
