package com.example.demo.entity;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;


@Entity
public class AppelOffre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "date_debut")
    private Date dateDebut;

    @Column(name = "date_fin")
    private Date dateFin;

    private String  description ;
    
    private int etat;


    public int getEtat() {
		return etat;
	}



	public void setEtat(int etat) {
		this.etat = etat;
	}



	public String getDescription() {
		return description;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	public int getId() {
		return id;
	}



	public Date getDateDebut() {
		return dateDebut;
	}



	public Date getDateFin() {
		return dateFin;
	}



	public List<Ressource> getRessources() {
		return ressources;
	}



	public void setId(int id) {
		this.id = id;
	}



	public void setDateDebut(Date dateDebut) {
		this.dateDebut = dateDebut;
	}



	public void setDateFin(Date dateFin) {
		this.dateFin = dateFin;
	}



	public void setRessources(List<Ressource> ressources) {
		this.ressources = ressources;
	}



	@OneToMany(mappedBy = "appelOffre", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Ressource> ressources = new ArrayList<>();

    // Ajoutez ici les getters et setters si nécessaire

}

