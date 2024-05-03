<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace Responsable</title>



  <%@  include file="links.jsp"%>

</head>

<body>
<script>
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    const successParamSup = urlParams.get('success');
    
    // Vérifier si l'ajout de proposition a réussi
    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "Votre demande a été evoyée avec succes!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de la modification de l'offre.", "error");
    }
    
    
</script>

<header>
        <img src="data:image/png;base64, <%=request.getAttribute("image") %>" alt="Picture" id="profile-pic">
        
        <h4>${nom}</h4>
<div class="notification-container">
    <i class="fas fa-bell" style="font-size: 24px;" onclick="toggleNotifications()"></i>
    <span class="notification-badge" id="notificationCount">${unreadCount}</span>
    <div class="notification-messages" id="notificationMessages">
         <%     List<Notification> unreadNotifications = (List<Notification>) request.getAttribute("unreadNotifications");
        if (unreadNotifications != null && !unreadNotifications.isEmpty()) 
        for (Notification notification : unreadNotifications) { %> 
        <div class="notification-card" id="<%= notification.getId() %>" onclick="markAsRead('<%= notification.getId() %>')">
            <p class="short-message"><%= notification.getMessage().substring(0, Math.min(notification.getMessage().length(), 20)) + "..." %></p>
            <p class="full-message" style="display: none;"><%= notification.getMessage() %></p>
        </div>
        <% } %>
        
    <%
        List<Notification> readNotifications = (List<Notification>) request.getAttribute("readNotifications");
        if (readNotifications != null && !readNotifications.isEmpty()) 
        	for (Notification notification : readNotifications) { %>
        <div class="notification-card" style="background-color: #fff;" id="<%= notification.getId() %>" onclick="markAsRead('<%= notification.getId() %>')">
            <p><%= notification.getMessage() %></p>
        </div>
        <% } %>
    </div>
</div>

    <a href="/Déconnexion" class="logout-link">
        <i class="fas fa-sign-out-alt" style="font-size: 24px;"></i>
        <span>Déconnexion</span>
    </a>

    </header>
    

    <nav>
         <ul>
               
                <li class="menu-item">  <a href="/updateRessources"><i class="fas fa-link"></i> Consulter ressources</a></li>
                    <li class="menu-item">   <a href="/appelOffre"> <i class="fas fa-qrcode"></i>    Gestion de appel d'offre</a></li>
                        <li class="menu-item"> <a href="/appelOffreCode"><i class="fas fa-link"></i>     Gestion de ressource</a></li>
    <li class="menu-item"><a href="/Fournisseurs"><i class="fas fa-stream"></i>Fournisseurs</a></li>
     <li class="menu-item"><a href="/Propositions"><i class="fas fa-calendar-week"></i>Propositions</a></li>
     <li class="menu-item"><a href="/Liste_Panne"><i class="far fa-question-circle"></i>Panne</a></li>
             
        </ul>
        </nav>
<section>
           
               <div class="p-3">
                        <h2>Espace Responable</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                            <% List<Proposition> lprs = (List<Proposition>)request.getAttribute("pr");%>
                             <% List<Ressource> lrs = (List<Ressource>)request.getAttribute("rs");%>
                              <% List<Panne> lpn = (List<Panne>)request.getAttribute("pn");%>
                              <%  List<Constat> Lcs = (List<Constat>)request.getAttribute("cs"); %>
                           
            
                             <div class="card recent-sales overflow-auto">
                             <h5 class="card-title">Appels d'offre  <span>| </span></h5>
              <table class="table" id="myTable">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col" >Ressource</th>
                  <th scope="col">Date de panne </th>
                  <th scope="col">Technicien</th>
                  <th scope="col">Fournisseur</th>
                  <th scope="col">Date de fin de garantie</th>
                   <th scope="col">Constat</th>
                   <th scope="col" style="text-align:center;">Action</th>
                 
                </tr>
              </thead>
                
              <tbody>
              <% for ( int i=0 ; i < lpn.size() ; i++) { 
            	  
            	  Ressource rs=  lrs.get(i) ;
            	  Proposition pr = lprs.get(i) ;
            	  Panne pn =lpn.get(i);
            	  Constat cs =Lcs.get(i);
            	  Imprimante  imp =rs.getImprimante();
            	  Ordinateur or = rs.getOrdinateur() ;
            	 
              
              %>
                                 <tr>
                                      
                                      <td><%= rs.getId() %></td>
                                      <td>
                                      <% if(imp!= null) {%>
                                      Imprimante
                                      <% } else { %>
                                       Ordinateur
                                        <%} %>
                                        </td>
                                      <td><%=pn.getDatePanne() %></td>
                                      <td><%= pn.getTechnicien().getUser().getNom_complet()  %></td>
                                      <td><%=pr.getOffre().getFournisseur().getUser().getNom_complet() %></td>
                                       <td><%= pr.getDureGarantie() %></td>
                                      <td> 
                                       <a href="#" data-bs-toggle="modal" data-bs-target="#modalConsulter<%=cs.getId() %>" >
								          voir plus 
								      </a></td>
                                      <td>
                                      <a href="/Changer?idUser=<%=pr.getOffre().getFournisseur().getUser().getId() %>&idRs=<%=rs.getId()%>" ><span  class="badge">Changer</span></a>
                                       <br><a href="/Reparer?idUser=<%=pr.getOffre().getFournisseur().getUser().getId() %>&idRs=<%=rs.getId()%>" ><span class="badge">Réparer </span></a>
                                       
                                       </td>
                                      
                               </tr>
                            <% } %>
               
              </tbody>
            </table>
    
          </div>
      </div>

<% 	//Consulter fournisseur//  %>
						<% if(request.getAttribute("cs")!=null){ 
						   	List<Constat> Lcs2 = (List<Constat>)request.getAttribute("cs");
						     for(Constat cs : Lcs2){                        %>
<div class="modal modalStyle" id="modalConsulter<%= cs.getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 40%;text-align:center">
    <div class="modal-content">
       <div class="modal-header">
       <h4 class="modal-title" id="exampleModalLabel" style="color:rgb(91, 140, 160)">Constat :</h4>
      </div>
      <div class="modal-body">
      
      
      
<div class="container">
  <div class="row ">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Odre de panne :</b></label>
      <label ><span><%= cs.getOrdre() %></span></label>
    </div>
  </div>

  <div class="row ">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Fréquence de panne :</b></label>
      <label ><span><%= cs.getFrequence_Panne() %></span></label>
    </div>
  </div>

  <div class="row">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Explication de panne:</b></label>
      <label ><span><%= cs.getExplication_Panne() %></span></label>
    </div>
  </div>



  
      <div class="modal-footer">
        <button style="background-color:rgb(133, 185, 196) ;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
      </div>
          
      </div>
    </div>
  </div>
</div>
<%}} %>
               
            
    
         </div>
              
                 
                </section>
      

    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
