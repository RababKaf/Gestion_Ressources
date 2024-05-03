package com.example.demo.entity;

import jakarta.persistence.*;

@Entity
public class Ordinateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "cpu")
    private String CPU;

    @Column(name = "disque_dur")
    private String disqueDur;

    @Column(name = "ecran")
    private String ecran;

    @Column(name = "ram")
    private String RAM;

    @OneToOne
    @JoinColumn(name = "ressource_id")
    private Ressource ressource;

    public Ordinateur() {
        // Constructeur par défaut
    }

	public Ordinateur(String cPU, String disqueDur, String ecran, String rAM, Ressource ressource) {
		super();
		CPU = cPU;
		this.disqueDur = disqueDur;
		this.ecran = ecran;
		RAM = rAM;
		this.ressource = ressource;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCPU() {
		return CPU;
	}

	public void setCPU(String cPU) {
		CPU = cPU;
	}

	public String getDisqueDur() {
		return disqueDur;
	}

	public void setDisqueDur(String disqueDur) {
		this.disqueDur = disqueDur;
	}

	public String getEcran() {
		return ecran;
	}

	public void setEcran(String ecran) {
		this.ecran = ecran;
	}

	public String getRAM() {
		return RAM;
	}

	public void setRAM(String rAM) {
		RAM = rAM;
	}

	public Ressource getRessource() {
		return ressource;
	}

	public void setRessource(Ressource ressource) {
		this.ressource = ressource;
	}

  
}