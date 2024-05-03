package com.example.demo.controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.*;
import com.example.demo.service.NotificationService;
import com.example.demo.serviceImplement.EnseignantServiceImplement;
import com.example.demo.serviceImplement.ImprimanteServiceImplement;
import com.example.demo.serviceImplement.OrdinateurServiceImplement;
import com.example.demo.serviceImplement.PanneServiceImplement;
import com.example.demo.serviceImplement.RessourceServiceImplement;
import com.example.demo.serviceImplement.UserServiceImplement;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class EnseignantController {
	private final RessourceServiceImplement rsi;
	private final OrdinateurServiceImplement osi;
	private final ImprimanteServiceImplement isi;
	private final PanneServiceImplement psi;
	private final EnseignantServiceImplement esi;
	private final UserServiceImplement usi;
	 private final NotificationService notificationService;
	
	
	public EnseignantController(RessourceServiceImplement rsi, OrdinateurServiceImplement osi,
			ImprimanteServiceImplement isi,PanneServiceImplement psi,EnseignantServiceImplement esi,UserServiceImplement usi,NotificationService notificationService) {
		super();
		this.rsi = rsi;
		this.osi = osi;
		this.isi = isi;
		this.psi=psi;
		this.esi=esi;
		this.usi=usi;
		this.notificationService=notificationService;
		
	}


	@GetMapping("/myressources_Ens")
	//String ListeRessourcesEns(@RequestParam("id") int idUser, Model model)
	String ListeRessourcesEns(Integer idUser, Model model,HttpServletRequest request)
	{ 	
    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = usi.findUser(userEmail);
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
	    


     
		idUser=userId;
		Enseignant e =usi.getEnseignantCH(idUser);
		Integer idEnseignant=e.getId();
		List<Ordinateur> ListeOrdinateur= new ArrayList<Ordinateur>() ;
		List<Imprimante> ListeImprimante= new ArrayList<Imprimante>() ;
		List<Ressource> ListeRessources= rsi.findRessourcesByEnseignantId(idEnseignant) ;
		for (Ressource rs : ListeRessources) {
	        Ordinateur ordinateur = osi.getOrdinateursEns(rs.getId());
	        if (ordinateur != null  & rs.getCodeBarre()!= null & (rs.getEtat()==4 ||rs.getEtat()==6 ) ) {
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            Imprimante imprimante = isi.getImprimantesEns(rs.getId());
	            if (imprimante != null & rs.getCodeBarre()!= null & (rs.getEtat()==4 ||rs.getEtat()==6 )) {
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    
	    model.addAttribute("ListeOrdinateur", ListeOrdinateur);
	    model.addAttribute("ListeImprimante", ListeImprimante);
	    model.addAttribute("ListeRessources", ListeRessources);
		
		return "ressourcesENS" ;}
	    return "Connexion";
		
	}
	
	@PostMapping("/enregistrerPanne")
	public String enregistrerPanne(@RequestParam("idRessource") int idRessource, @RequestParam("descriptionPanne") String descriptionPanne,@RequestParam("idEns") Integer idEnseignant) {
		
		Ressource ressource = rsi.findRessource(idRessource);
		ressource.setEtat(6);
		Calendar calendar = Calendar.getInstance();
        Date datePanne = calendar.getTime();
		Panne p =new Panne(datePanne,descriptionPanne,ressource);
		psi.addPanne(p);
		
		return "redirect:/myressources_Ens?idEnseignant=" +idEnseignant+ "&pantest=true";
	}
	@GetMapping("/myBesoins_ENS")
	String naviguerBesoins(Integer idUser, Model model,HttpServletRequest request)
	{
		HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = usi.findUser(userEmail);
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
	    
		idUser=userId;
		Enseignant e =usi.getEnseignantCH(idUser);
		Integer idEnseignant=e.getId();
		List<Ordinateur> ListeOrdinateur= new ArrayList<Ordinateur>() ;
		List<Imprimante> ListeImprimante= new ArrayList<Imprimante>() ;
		List<Ressource> ListeRessources= rsi.findRessourcesByEnseignantId(idEnseignant) ;
		
		for (Ressource rs : ListeRessources) {
	        Ordinateur ordinateur = osi.getOrdinateursEns(rs.getId());
	        if (ordinateur != null & rs.getCodeBarre()== null & rs.getEtat()==0 ) {
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            Imprimante imprimante = isi.getImprimantesEns(rs.getId());
	            if (imprimante != null & rs.getCodeBarre()== null & rs.getEtat()==0 ) {
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    
	    model.addAttribute("ListeOrdinateur", ListeOrdinateur);
	    model.addAttribute("ListeImprimante", ListeImprimante);
	    model.addAttribute("ListeRessources", ListeRessources);
		return "besoinsENS";}return "connexion";
	}

	@PostMapping("/SupprimerBesoinOrdiEns")
	public String SupprimerBesoinOrdi(@RequestParam("idOrdi") Long idOrdi,@RequestParam("idEns") Integer idEnseignant) {
		
		Ordinateur ord=osi.getOrdinateurE(idOrdi);
		osi.deleteOrdinateursEns(idOrdi);
		rsi.deleteRessource(ord.getRessource().getId());
		
		
	    return "redirect:/myBesoins_ENS?idEnseignant=" +idEnseignant+ "&success=true";
	}	
	
	@PostMapping("/SupprimerBesoinImpEns")
	public String SupprimerBesoinImp(@RequestParam("idImpri") Integer idImpri,@RequestParam("idEns") Integer idEnseignant) {
		
		
		Imprimante imp=isi.getImprimanteE(idImpri);
		isi.deleteImprimantesEns(idImpri);
		rsi.deleteRessource(imp.getRessource().getId());
		
		return "redirect:/myBesoins_ENS?idEnseignant=" +idEnseignant+ "&success=true"; 
	}
	
	@PostMapping("/AddBesoinEns")
	public String AddBesoin(
	    @RequestParam("typeRessource") String typeRessource,
	    Integer idUser,
	    @RequestParam(value = "cpu", required = false) Optional<String> cpu,
	    @RequestParam(value = "ram", required = false) Optional<String> ram,
	    @RequestParam(value = "disqueDur", required = false) Optional<String> disqueDur,
	    @RequestParam(value = "ecran", required = false) Optional<String> ecran,
	    @RequestParam(value = "vitesseImpression", required = false) Optional<String> vitesseImpression,
	    @RequestParam(value = "resolution", required = false) Optional<String> resolution
	) {
		
		 idUser=1;
		 Enseignant ens=usi.getEnseignantCH(idUser);
		 Integer idEnseignant=ens.getId();
		Enseignant enseignant= esi.getEnseignantEns(idEnseignant);
				
	   Ressource ressource=new Ressource(0,enseignant);
	   
	   
	    	if ("ordinateur".equals(typeRessource)) {
	    		String c =cpu.get();
	    		String r =ram.get();
	    		String e =ecran.get();
	    		String d =disqueDur.get();
	    		Ordinateur ord = new Ordinateur(c,d,e,r,ressource);
	    		rsi.addBesoin(ressource);
	    		osi.addOrdinateurEns(ord);
	        } else 
	        {
	        	String v=vitesseImpression.get();
	        	String r=resolution.get();
	        	Imprimante imp = new Imprimante(r,v,ressource);
	        	rsi.addBesoin(ressource);
	        	isi.addImprimanteEns(imp);
	        } 
	        

            
	    	 return "redirect:/myBesoins_ENS?idEnseignant=" +idEnseignant+ "&testAj=true";
	}

	
	@PostMapping("/ModifierBesoinOrdEns")
	public String ModifierBesoinOrd(
	    @RequestParam("idOrd") Long idOrd,
	    @RequestParam("idEns") int idEnseignant,
	    @RequestParam(value = "cpu", required = false) Optional<String> cpu,
	    @RequestParam(value = "ram", required = false) Optional<String> ram,
	    @RequestParam(value = "disqueDur", required = false) Optional<String> disqueDur,
	    @RequestParam(value = "ecran", required = false) Optional<String> ecran
	) {
	    		String c =cpu.get();
	    		String r =ram.get();
	    		String e =ecran.get();
	    		String d =disqueDur.get();
	    		Ordinateur ord =osi.getOrdinateurE(idOrd);
	    		ord.setCPU(c);
	    		ord.setDisqueDur(d);
	    		ord.setRAM(r);
	    		ord.setEcran(e);
	    		osi.addOrdinateurEns(ord);
            
	    	 return "redirect:/myBesoins_ENS?idEnseignant=" +idEnseignant+ "&testModif=true";
	}


	
	@PostMapping("/ModifierBesoinImpEns")
	public String ModifierBesoinImp(
	    @RequestParam("idImp") int idImp,
	    @RequestParam("idEns") int idEnseignant,
	    @RequestParam(value = "vitesseImpression", required = false) Optional<String> vitesseImpression,
	    @RequestParam(value = "resolution", required = false) Optional<String> resolution
	) {
	    		String v=vitesseImpression.get();
	        	String r=resolution.get();
	        	Imprimante imp =isi.getImprimanteE(idImp);
	        	imp.setResolution(r);
	        	imp.setVitesseImpression(v);
	        	isi.addImprimanteEns(imp);
            
	    	 return "redirect:/myBesoins_ENS?idEnseignant=" +idEnseignant+ "&testModif=true";
	}
	
	@PostMapping("/validerBesoinsEns")
	public String validerBesoins( Integer idUser) {
		 idUser=1;
		 Enseignant ens=usi.getEnseignantCH(idUser);
		 Integer idEnseignant=ens.getId();
		List<Ordinateur> ListeOrdinateur= new ArrayList<Ordinateur>() ;
		List<Imprimante> ListeImprimante= new ArrayList<Imprimante>() ;
		List<Ressource> ListeRessources= rsi.findRessourcesByEnseignantId(idEnseignant) ;
		
		for (Ressource rs : ListeRessources) {
	        Ordinateur ordinateur = osi.getOrdinateursEns(rs.getId());
	        if (ordinateur != null & rs.getCodeBarre() == null & rs.getEtat()==0) {
	        	rs.setEtat(1);
	        	rsi.addBesoin(rs);
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            Imprimante imprimante = isi.getImprimantesEns(rs.getId());
	            if (imprimante != null & rs.getCodeBarre()== null & rs.getEtat()==0) {
	            	rs.setEtat(1);
	            	rsi.addBesoin(rs);
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    
	   
            
	    	 return "redirect:/myBesoins_ENS?idEnseignant=" +idEnseignant+ "&testModif=true";
	}
}
