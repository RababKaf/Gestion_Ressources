package com.example.demo.entity;
import java.time.LocalDateTime;
import jakarta.persistence.*;
import java.util.Date;

@Entity
public class Panne {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "date_intervention")
    private Date dateIntervention;
    
    @Column(name = "date_panne")
    private Date datePanne;

    @Column(name = "etat")
    private String etat;

    @Column(name = "explication_panne")
    private String explicationPanne;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "technicien_id")
    private Technicien technicien;

    @OneToOne(mappedBy = "panne")
    private Constat constat;

    public int getId() {
		return id;
	}

	public Date getDateIntervention() {
		return dateIntervention;
	}

	public Date getDatePanne() {
		return datePanne;
	}

	public String getEtat() {
		return etat;
	}

	public String getExplicationPanne() {
		return explicationPanne;
	}

	public Technicien getTechnicien() {
		return technicien;
	}

	public Constat getConstat() {
		return constat;
	}

	public Ressource getRessource() {
		return ressource;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setDateIntervention(Date dateIntervention) {
		this.dateIntervention = dateIntervention;
	}

	public void setDatePanne(Date datePanne) {
		this.datePanne = datePanne;
	}

	public void setEtat(String etat) {
		this.etat = etat;
	}

	public void setExplicationPanne(String explicationPanne) {
		this.explicationPanne = explicationPanne;
	}

	public void setTechnicien(Technicien technicien) {
		this.technicien = technicien;
	}

	public void setConstat(Constat constat) {
		this.constat = constat;
	}

	public void setRessource(Ressource ressource) {
		this.ressource = ressource;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ressource_id")
    private Ressource ressource;

    public Panne() {
        // Constructeur par défaut
    }

	public Panne(Date datePanne, String explicationPanne, Ressource ressource) {
		super();

		this.datePanne = datePanne;
		this.explicationPanne = explicationPanne;
		this.ressource = ressource;
	}

}