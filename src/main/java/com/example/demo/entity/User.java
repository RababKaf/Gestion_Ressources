package com.example.demo.entity;

import jakarta.persistence.*;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String email;

    @Column(columnDefinition = "MEDIUMBLOB")
    private Blob image;

    private String mot_de_passe;
    private String nom_complet;
    private int role;
    private String  tel;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Notification> notifications = new ArrayList<>();

    @OneToOne(mappedBy = "user")
    private Fournisseur fournisseur;

    @OneToOne(mappedBy = "user")
    private Responsable responsable;

    @OneToOne(mappedBy = "user")
    private Enseignant enseignant;

    public User(int id, String email, Blob image, String mot_de_passe, String nom_complet, int role, String tel,
			List<Notification> notifications, Fournisseur fournisseur, Responsable responsable, Enseignant enseignant,
			Technicien technicien) {
		super();
		this.id = id;
		this.email = email;
		this.image = image;
		this.mot_de_passe = mot_de_passe;
		this.nom_complet = nom_complet;
		this.role = role;
		this.tel = tel;
		this.notifications = notifications;
		this.fournisseur = fournisseur;
		this.responsable = responsable;
		this.enseignant = enseignant;
		this.technicien = technicien;
	}

	@OneToOne(mappedBy = "user")
    private Technicien technicien;

    public int getId() {
		return id;
	}

	public String getEmail() {
		return email;
	}

	public Blob getImage() {
		return image;
	}

	public String getMot_de_passe() {
		return mot_de_passe;
	}

	public String getNom_complet() {
		return nom_complet;
	}

	public int getRole() {
		return role;
	}

	public String getTel() {
		return tel;
	}

	public List<Notification> getNotifications() {
		return notifications;
	}

	public Fournisseur getFournisseur() {
		return fournisseur;
	}

	public Responsable getResponsable() {
		return responsable;
	}

	public Enseignant getEnseignant() {
		return enseignant;
	}

	public Technicien getTechnicien() {
		return technicien;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setImage(Blob image) {
		this.image = image;
	}

	public void setMot_de_passe(String mot_de_passe) {
		this.mot_de_passe = mot_de_passe;
	}

	public void setNom_complet(String nom_complet) {
		this.nom_complet = nom_complet;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setNotifications(List<Notification> notifications) {
		this.notifications = notifications;
	}

	public void setFournisseur(Fournisseur fournisseur) {
		this.fournisseur = fournisseur;
	}

	public void setResponsable(Responsable responsable) {
		this.responsable = responsable;
	}

	public void setEnseignant(Enseignant enseignant) {
		this.enseignant = enseignant;
	}

	public void setTechnicien(Technicien technicien) {
		this.technicien = technicien;
	}

	public User() {
        // Constructeur par défaut
    }

    // Ajoutez vos getters et setters ici
}
