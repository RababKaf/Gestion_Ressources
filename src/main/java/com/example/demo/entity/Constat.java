package com.example.demo.entity;

import jakarta.persistence.*;

@Entity
public class Constat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String Explication_Panne;
    private String Frequence_Panne;
    private String ordre;

    public Constat() {
        // Default constructor
    }

    @OneToOne
    @JoinColumn(name = "panne_id")
    private Panne panne;

	public int getId() {
		return id;
	}

	public String getExplication_Panne() {
		return Explication_Panne;
	}

	public String getFrequence_Panne() {
		return Frequence_Panne;
	}

	public String getOrdre() {
		return ordre;
	}

	public Panne getPanne() {
		return panne;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setExplication_Panne(String explication_Panne) {
		Explication_Panne = explication_Panne;
	}

	public void setFrequence_Panne(String frequence_Panne) {
		Frequence_Panne = frequence_Panne;
	}

	public void setOrdre(String ordre) {
		this.ordre = ordre;
	}

	public void setPanne(Panne panne) {
		this.panne = panne;
	}


}

    


