package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.Fournisseur;
import com.example.demo.entity.Notification;
import com.example.demo.entity.Offre;
import com.example.demo.entity.Ressource;
import com.example.demo.entity.User;
import com.example.demo.service.FournisseurService;
import com.example.demo.service.NotificationService;
import com.example.demo.service.OffreService;

import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller 
public class FournisseurController {

	final FournisseurService fournisseurService ;
	final NotificationService  notificationService ;
	final UserService userService ;

	final OffreService offreService ;
	int fr_id=1 ;
	
	@Autowired
	public FournisseurController(FournisseurService fournisseurService, NotificationService notificationService,
			UserService userService, OffreService offreService) {
		super();
		this.fournisseurService = fournisseurService;
		this.notificationService = notificationService;
		this.userService = userService;
	
		this.offreService=offreService ;
	}
	
	
	@GetMapping("/Fournisseurs")
	public String getFournisseurs( Model model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userService.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    


	
		Object[][] data = fournisseurService.getUsersAndFournisseurs();
        model.addAttribute("data", data);
		return "FournisseurRespo" ;	}return "connexion";
	}

	@PostMapping("/ajouterAuListeNoire")
	 public String AjouterAuListeNoire(@RequestParam("motif") String motif,
			 @RequestParam("fournisseurId") int fournisseurId,
			 @RequestParam("UserId") int UserId)
	 {
		Fournisseur fr = fournisseurService.ChercherFrn(fournisseurId) ;
		fr.setListeNoire(1) ;
		fournisseurService.EnregisterFr(fr);
        Notification motifLN = new Notification(); 
        String  motif_G="Vous avez été éliminé par le responsable de l'établissement FST de Fès pour la raison suivante: " +motif ;
        Date date = new Date();
        User user = userService.ChercherUserFr(UserId) ;
        motifLN.setMessage(motif_G);
        motifLN.setDate_envoi(date);
        motifLN.setUser(user) ;
        notificationService.EnvoyerMotifLN(motifLN) ;
        
		 return "redirect:/Fournisseurs?success=true";
	 }
	
	@GetMapping("/ListeNoire")
    public String getListeNoire(Model model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userService.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    


        Object[][] data = fournisseurService.getUsersAndFournisseurs();
        List<Object[]> filteredList = new ArrayList<>();

        for (Object[] row : data) {
            Fournisseur fournisseur = (Fournisseur) row[1];
            if (fournisseur.getListeNoire() == 1) {
                filteredList.add(row);
            }
        }

        model.addAttribute("data", filteredList.toArray(new Object[0][]));
        return "ListeNoire";}return "connexion";
    }
	
	// recuperer mais offre:
	@GetMapping("/MesOffres")
	public String MesOffres(Model model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userService.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = notificationService.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = notificationService.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", notificationService.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	        
		List<Offre> ListeOffres = offreService.GetOffreFr(user.getFournisseur().getId()) ;
		model.addAttribute("ListeOffres", ListeOffres) ;
		return "Offres" ;}return "connexion";
	}
	
	
	@PostMapping("/AccepterOffre")
	public String AccepterOffre(@RequestParam("idOffre") Long OffreId)
	{
		Offre MyOffre =offreService.getOffre(OffreId) ;
		String msgR = "Votre offre est refusée" ;
		String msgA="Votre offre est acceptée" ;
		Date date = new Date();
		List<Offre> listeOffres = offreService.GetOffre();
		for(Offre offre : listeOffres)
		{
			// envoyer de la notification :
			 Fournisseur fr =offre.getFournisseur() ;
			 User user =fr.getUser() ;
			 Notification notif = new Notification(); 
			 notif.setDate_envoi(date);
			 notif.setUser(user);
			 
			 // enregiqter l'offre :
			if(offre.getId()== MyOffre.getId())
			{
				offre.setEtat(1) ;
			    notif.setMessage(msgA) ;
			}
			else 
			{
				offre.setEtat(-1) ;
				notif.setMessage(msgR) ;
			}
			boolean etatEnrg =offreService.AjouterOffre(offre);
			notificationService.EnvoyerMotifLN(notif);
			
		}
		
		
		
		return "redirect:/Propositions?success=true";
	}
	
	@PostMapping("/Restauration")
	public String restuarer(@RequestParam("frId") int frId)
	{
		Fournisseur fr = fournisseurService.ChercherFrn(frId) ;

		fr.setListeNoire(-1) ;
		fournisseurService.EnregisterFr(fr);
        Notification motifLN = new Notification(); 
        String  motif_G="Le responsable vous retire de la liste noire" ;
        Date date = new Date();
        motifLN.setMessage(motif_G);
        motifLN.setDate_envoi(date);
        motifLN.setUser(fr.getUser()) ;
        notificationService.EnvoyerMotifLN(motifLN) ;
        
        return "redirect:/ListeNoire?success=true";
	}
	
	
	
}
