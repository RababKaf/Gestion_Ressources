package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.*;
import com.example.demo.service.FournisseurService;
import com.example.demo.service.OffreService;
import com.example.demo.service.PanneService;
import com.example.demo.service.PropositionService;
import com.example.demo.service.RessourceService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller 
public class PanneController {
	
	private final PropositionService  proposititonService;
	private final RessourceService   ressourceService;
	private final NotificationService  notificationService;
	private final OffreService   offreService;
	private final PanneService panneservice ;
	private final UserService userservice ;
	
	
	public PanneController(PropositionService proposititonService, RessourceService ressourceService,
			NotificationService notificationService, OffreService offreService, PanneService panneservice,
			UserService userservice) {
		
		this.proposititonService = proposititonService;
		this.ressourceService = ressourceService;
		this.notificationService = notificationService;
		this.offreService = offreService;
		this.panneservice = panneservice;
		this.userservice = userservice;
	}
	
	@GetMapping("/Liste_Panne")
	public String GetPanne( Model  model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = userservice.findUser(userEmail);
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
		List<Ressource> listRs= new ArrayList<>();
		List<Panne> listPannes = panneservice.getPannesRsp() ;
		List<Panne> MyPannes = new ArrayList<>();
		List<Constat> ListeConstats= new ArrayList<>();
		
		for(Panne panne : listPannes )
		{
			Ressource  rs = panne.getRessource();
			if(rs.getEtat()==8)
			{
				listRs.add(rs) ;
				MyPannes.add(panne);
				Constat cs =panne.getConstat() ;
				ListeConstats.add(cs);	
			}
			
          }
		
		List<Proposition> listePr = new ArrayList<>();
		for(Ressource rs : listRs)
		{
			List<Proposition> Prps = rs.getPropositions();
			for(Proposition prs :Prps)
			{
				Offre offre = prs.getOffre();
				if(offre.getEtat()==1)
				listePr.add(prs);	
			}
			
			
		}
		
		model.addAttribute("pr" ,listePr);
		model.addAttribute("rs" ,listRs) ;
		model.addAttribute("pn" ,MyPannes) ;
		model.addAttribute("cs" ,ListeConstats) ;
		
		return "PanneRespo" ;}return "connexion";
	}
	
	@GetMapping("/Changer")
    public String ChngerRs(@RequestParam("idRs") int rsId,@RequestParam("idUser") int idUser ) 
    {
		Ressource rs=ressourceService.ChercherRessourceFrn(rsId) ;
		rs.setEtat(9);
		Notification notif = new Notification();
		User user = userservice.ChercherUserFr(idUser) ;
		notif.setUser(user) ;
		String  motif_G="Bonjour "+user.getNom_complet() +" notre faculté vous demande de remplacer l'une des ressources que vous nous avez envoyées en raison d'une panne";
        Date date = new Date();
        notif.setMessage(motif_G);
        notif.setDate_envoi(date);
        notificationService.EnvoyerMotifLN(notif) ;
		
		return "redirect:/Liste_Panne?success=true" ;
    }
	
	@GetMapping("/Reparer")
    public String ModifierRs(@RequestParam("idRs") int rsId,@RequestParam("idUser") int idUser ) 
    {
		Ressource rs=ressourceService.ChercherRessourceFrn(rsId) ;
		rs.setEtat(10);
		Notification notif = new Notification();
		User user = userservice.ChercherUserFr(idUser) ;
		notif.setUser(user) ;
		String  motif_G="Bonjour "+user.getNom_complet() +" notre faculté vous demande de réparer l'une des ressources que vous nous avez envoyées en raison d'une panne";
        Date date = new Date();
        notif.setMessage(motif_G);
        notif.setDate_envoi(date);
        notificationService.EnvoyerMotifLN(notif) ;
		
		return "redirect:/Liste_Panne?success=true" ;
    }
   
}
