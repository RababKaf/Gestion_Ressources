package com.example.demo.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private Date date_envoi;
    private boolean is_read;
    private String message;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    public Notification() {
        // Constructeur par défaut
    }

	public Notification(int id, Date date_envoi, boolean is_read, String message, User user) {
		super();
		this.id = id;
		this.date_envoi = date_envoi;
		this.is_read = is_read;
		this.message = message;
		this.user = user;
	}

	
	public Notification(Date date_envoi, String message, User user) {
		super();
		this.date_envoi = date_envoi;
		this.message = message;
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public Date getDate_envoi() {
		return date_envoi;
	}

	public boolean isIs_read() {
		return is_read;
	}

	public String getMessage() {
		return message;
	}

	public User getUser() {
		return user;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setDate_envoi(Date date_envoi) {
		this.date_envoi = date_envoi;
	}

	public void setIs_read(boolean is_read) {
		this.is_read = is_read;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setUser(User user) {
		this.user = user;
	}

  
}
