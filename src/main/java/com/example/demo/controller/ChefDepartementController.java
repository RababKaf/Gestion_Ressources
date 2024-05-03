package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.configuration.TraitementImage;
import com.example.demo.entity.Affectation;
import com.example.demo.entity.Enseignant;
import com.example.demo.entity.Imprimante;
import com.example.demo.entity.Notification;
import com.example.demo.entity.Ordinateur;
import com.example.demo.entity.Ressource;
import com.example.demo.entity.User;
import com.example.demo.serviceImplement.AffectationServiceImplement;
import com.example.demo.serviceImplement.EnseignantServiceImplement;
import com.example.demo.serviceImplement.ImprimanteServiceImplement;
import com.example.demo.serviceImplement.NotificationServiceImplement;
import com.example.demo.serviceImplement.OrdinateurServiceImplement;
import com.example.demo.serviceImplement.RessourceServiceImplement;
import com.example.demo.serviceImplement.UserServiceImplement;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChefDepartementController {
	private final RessourceServiceImplement rsi;
	private final OrdinateurServiceImplement osi;
	private final ImprimanteServiceImplement isi;
	private final EnseignantServiceImplement esi;
	private final NotificationServiceImplement nsi;
	private final AffectationServiceImplement asi;
	private final UserServiceImplement usi;
	public ChefDepartementController(RessourceServiceImplement rsi, OrdinateurServiceImplement osi,
			ImprimanteServiceImplement isi, EnseignantServiceImplement esi,NotificationServiceImplement nsi,AffectationServiceImplement asi,UserServiceImplement usi) {
		super();
		this.rsi = rsi;
		this.osi = osi;
		this.isi = isi;
		this.esi = esi;
		this.nsi=nsi;
		this.asi=asi;
		this.usi=usi;
	}
	@GetMapping("/myressources_CHD")
	//String ListeRessourcesEns(@RequestParam("id") int idEnseignant, Model model)
	String ListeBesoins(Integer idUser, Model model,HttpServletRequest request)
	{

    	HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = usi.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = nsi.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = nsi.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", nsi.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    


     
		idUser=userId;
		Enseignant chef=usi.getCHDCH(idUser);
		int idDepar=chef.getDepartement().getId();
		
		List<Enseignant> ListeEnseignant=esi.getEnseignantDepar(idDepar);
		List<Ordinateur> ListeOrdinateur= new ArrayList<Ordinateur>() ;
		List<Imprimante> ListeImprimante= new ArrayList<Imprimante>() ;
		List<Ressource> ListeRessources=new ArrayList<Ressource>();
		for ( Enseignant e : ListeEnseignant){
			List<Ressource> lrc= rsi.findRessourcesByEnseignantId(e.getId()) ;
			ListeRessources.addAll(lrc);
		}
		List<Affectation> affs=asi.getAffectationCHD(idDepar);
		for (Affectation a : affs)
		{
			ListeRessources.add(a.getRessource());
			System.err.println("chaymaa"+a.getRessource().getId());
		}
		for (Ressource rs : ListeRessources) {
	        Ordinateur ordinateur = osi.getOrdinateursEns(rs.getId());
	        if (ordinateur != null  & rs.getCodeBarre()== null & rs.getEtat()==1) {
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            Imprimante imprimante = isi.getImprimantesEns(rs.getId());
	            if (imprimante != null & rs.getCodeBarre()== null & rs.getEtat()==1) {
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    
	    model.addAttribute("ListeOrdinateur", ListeOrdinateur);
	    model.addAttribute("ListeImprimante", ListeImprimante);
	    model.addAttribute("ListeRessources", ListeRessources);
		
		return "CHDHome" ;}return "connexion";
		
	}
	
	
	@PostMapping("/SupprimerBesoinOrdiCHD")
	public String SupprimerBesoinOrdi(@RequestParam("idOrdi") Long idOrdi,@RequestParam("idChef") Integer idChefDep) {
		
		Ordinateur ord=osi.getOrdinateurE(idOrdi);
		osi.deleteOrdinateursEns(idOrdi);
		rsi.deleteRessource(ord.getRessource().getId());
		
		
	    return "redirect:/myressources_CHD?idChef=" +idChefDep+ "&testSup=true";
	}
	
	@PostMapping("/SupprimerBesoinOrdiCHDPAR")
	public String SupprimerBesoinOrdiPAR(@RequestParam("idOrdi") Long idOrdi,@RequestParam("idChef") Integer idChefDep) {
		
		Ordinateur ord=osi.getOrdinateurE(idOrdi);
		asi.deleteAffectationCHD(ord.getRessource().getAffectation().getId());
		osi.deleteOrdinateursEns(idOrdi);
		rsi.deleteRessource(ord.getRessource().getId());
		
		
	    return "redirect:/myressources_CHD?idChef=" +idChefDep+ "&testSup=true";
	}

	
	@PostMapping("/SupprimerBesoinImpCHD")
	public String SupprimerBesoinImp(@RequestParam("idImpri") Integer idImpri,@RequestParam("idChef") Integer idChefDep) {
		
		
		Imprimante imp=isi.getImprimanteE(idImpri);
		isi.deleteImprimantesEns(idImpri);
		rsi.deleteRessource(imp.getRessource().getId());
		
		return "redirect:/myressources_CHD?idChef=" +idChefDep+ "&testSup=true";
	}
	
	
	
	@PostMapping("/SupprimerBesoinImpCHDPAR")
	public String SupprimerBesoinImpPAR(@RequestParam("idImpri") Integer idImpri,@RequestParam("idChef") Integer idChefDep) {
		
		
		Imprimante imp=isi.getImprimanteE(idImpri);
		asi.deleteAffectationCHD(imp.getRessource().getAffectation().getId());
		isi.deleteImprimantesEns(idImpri);
		rsi.deleteRessource(imp.getRessource().getId());
		
		
		return "redirect:/myressources_CHD?idChef=" +idChefDep+ "&testSup=true";
	}
	@PostMapping("/ModifierBesoinOrdCHD")
	public String ModifierBesoinOrd(
	    @RequestParam("idOrd") Long idOrd,
	    @RequestParam("idChef") int idChefDep,
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
            
	    		return "redirect:/myressources_CHD?idChef=" +idChefDep+ "&testModif=true";
	}
	
	@PostMapping("/ModifierBesoinImpCHD")
	public String ModifierBesoinImp(
	    @RequestParam("idImp") int idImp,
	    @RequestParam("idChef") int idChefDep,
	    @RequestParam(value = "vitesseImpression", required = false) Optional<String> vitesseImpression,
	    @RequestParam(value = "resolution", required = false) Optional<String> resolution
	) {
	    		String v=vitesseImpression.get();
	        	String r=resolution.get();
	        	Imprimante imp =isi.getImprimanteE(idImp);
	        	imp.setResolution(r);
	        	imp.setVitesseImpression(v);
	        	isi.addImprimanteEns(imp);
            
	        	return "redirect:/myressources_CHD?idChef=" +idChefDep+ "&testModif=true";
	}
	

	@GetMapping("/communiquer_CHD")
	String communiquer(Integer idUser, Model model,HttpServletRequest request ) {
		HttpSession session = request.getSession();

	    TraitementImage t =new TraitementImage();
	    String userEmail = (String) session.getAttribute("userEmail");
	   // Integer userRole = (Integer) session.getAttribute("userRole");
	    User user = usi.findUser(userEmail);
        model.addAttribute("user", user);
        int userId=user.getId();
	    if ( userEmail != null ) {
	        

       
	        List<Notification> readNotifications = nsi.getReadNotificationsForUser(userId);
	        List<Notification> unreadNotifications = nsi.getUnreadNotificationsForUser(userId);
	        model.addAttribute("readNotifications", readNotifications);
	        model.addAttribute("unreadNotifications", unreadNotifications);
	        model.addAttribute("unreadCount", nsi.getUnreadNotificationsCount(userId));
	        String image = t.convertBlobToBase64(user.getImage());
	        model.addAttribute("nom", user.getNom_complet());
	        model.addAttribute("image", image);
	    


     
		idUser=userId;

	    
	    Enseignant chef = usi.getCHDCH(idUser);
	    int idDepar = chef.getDepartement().getId();
	    List<Enseignant> ListeEnseignants = esi.getEnseignantDepar(idDepar);
	    model.addAttribute("ListeEnseignants", ListeEnseignants);
	    return "communication";} return "connexion";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@PostMapping("/notifier_CHD")
	String notifier(
			@RequestParam("destinataire") String destinataire,
		    @RequestParam("message") String message,
		    Integer idUser
		) {
		 idUser=1;
		Enseignant chef = usi.getCHDCH(idUser);
	    int idDepar = chef.getDepartement().getId();
	    List<Enseignant> ListeEnseignants = esi.getEnseignantDepar(idDepar);
	    Calendar calendar = Calendar.getInstance();
		if ("tout".equals(destinataire)) {
			for(Enseignant ens :ListeEnseignants) {
				
		        Date datenotif = calendar.getTime();
		        Notification notif=new Notification(datenotif,message,ens.getUser());
				nsi.EnvoyerNotification(notif);
			}
		
		}
		else {
			Date datenotif = calendar.getTime();
			 int id = Integer.parseInt(destinataire);
			Enseignant e=esi.getEnseignantEns(id);
	        Notification notif=new Notification(datenotif,message,e.getUser());
			nsi.EnvoyerNotification(notif);
		}
        
			
			
		return "redirect:/communiquer_CHD?idChef=" +idUser+ "&testNotif=true";
	}
	@PostMapping("/EnvoyerBesoinsCHD")
	public String envoyerBesoinsCHD( Integer idUser) {
		idUser=1;
		Enseignant chef=usi.getCHDCH(idUser);
		 Calendar calendar = Calendar.getInstance();
		int idDepar=chef.getDepartement().getId();
		List<Enseignant> ListeEnseignant=esi.getEnseignantDepar(idDepar);
		List<Ordinateur> ListeOrdinateur= new ArrayList<Ordinateur>() ;
		List<Imprimante> ListeImprimante= new ArrayList<Imprimante>() ;
		List<Ressource> ListeRessources=new ArrayList<Ressource>();
		for ( Enseignant e : ListeEnseignant){
			List<Ressource> lrc= rsi.findRessourcesByEnseignantId(e.getId()) ;
			ListeRessources.addAll(lrc);
		}
		for (Ressource rs : ListeRessources) {
	        Ordinateur ordinateur = osi.getOrdinateursEns(rs.getId());
	        if (ordinateur != null  & rs.getCodeBarre()== null & rs.getEtat()==1) {
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            Imprimante imprimante = isi.getImprimantesEns(rs.getId());
	            if (imprimante != null & rs.getCodeBarre()== null & rs.getEtat()==1) {
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    
		for (Ressource rs : ListeRessources) {
	        Ordinateur ordinateur = osi.getOrdinateursEns(rs.getId());
	        if (ordinateur != null & rs.getCodeBarre() == null) {
	        	rs.setEtat(2);
	        	
	        	Affectation af=new Affectation(rs,rs.getEnseignant());
	        	asi.affecter(af);
	        	 Date datenotif = calendar.getTime();
	        	 String message="Bonjour Mr "+rs.getEnseignant().getUser().getNom_complet()+"nous avons vous affecte l'Ordinateur que vous avez demande";
		        Notification notif=new Notification(datenotif,message,rs.getEnseignant().getUser());
				nsi.EnvoyerNotification(notif);
	        
	        	rsi.addBesoin(rs);
	            ListeOrdinateur.add(ordinateur);
	        } else {
	            Imprimante imprimante = isi.getImprimantesEns(rs.getId());
	            if (imprimante != null & rs.getCodeBarre()== null) {
	            	rs.setEtat(2);
	            	Affectation af=new Affectation(rs,rs.getEnseignant());
		        	asi.affecter(af);
		        	 Date datenotif = calendar.getTime();
		        	 String message="Bonjour Mr "+rs.getEnseignant().getUser().getNom_complet()+"nous avons vous affecte l'imprimante que vous avez demande";
			        Notification notif=new Notification(datenotif,message,rs.getEnseignant().getUser());
					nsi.EnvoyerNotification(notif);
		        	
	            	rsi.addBesoin(rs);
	                ListeImprimante.add(imprimante);
	            }
	        }
	    }
	    
		 Date datenotif = calendar.getTime();
		 User responsable=usi.getResponsableCH();
    	 String message="Bonjour Mr "+responsable.getNom_complet()+" veuillez consulter la liste des besoins";
    	
        Notification notif=new Notification(datenotif,message,responsable);
        
		nsi.EnvoyerNotification(notif);
	   
            
		return "redirect:/myressources_CHD?idChef=" +idUser+ "&testEnvoie=true";
	}
	
	@PostMapping("/AddBesoinPartage")
	public String AddBesoinCHD(
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
		 Enseignant chef=usi.getCHDCH(idUser);
		
				
	   Ressource ressource=new Ressource(1);
	   
	   
	    	if ("ordinateur".equals(typeRessource)) {
	    		String c =cpu.get();
	    		String r =ram.get();
	    		String e =ecran.get();
	    		String d =disqueDur.get();
	    		Ordinateur ord = new Ordinateur(c,d,e,r,ressource);
	    		rsi.addBesoin(ressource);
	    		osi.addOrdinateurEns(ord);
	    		Affectation af=new Affectation(ressource,chef.getDepartement());
	        	asi.affecter(af);
	        } else 
	        {
	        	String v=vitesseImpression.get();
	        	String r=resolution.get();
	        	Imprimante imp = new Imprimante(r,v,ressource);
	        	rsi.addBesoin(ressource);
	        	isi.addImprimanteEns(imp);
	        	Affectation af=new Affectation(ressource,chef.getDepartement());
	        	asi.affecter(af);
	        } 
	        

            
	    	 return "redirect:/myressources_CHD?idUser=" +idUser+ "&testAj=true";
	}
	
}
