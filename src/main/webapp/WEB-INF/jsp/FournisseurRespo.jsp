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

<style>
.bColor
{
color:rgb(48, 96, 184)  ;
}
.link-unstyled {
    text-decoration: none;
    color :red ;
    
}

.link-unstyled:hover {
    color: white;
}

</style>
</head>

<body>

<script>
    // RÃ©cupÃ©rer le paramÃ¨tre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    console.log(successParam);
    // VÃ©rifier si l'ajout de proposition a rÃ©ussi
    if (successParam === 'true') {
        // Afficher une alerte de succÃ¨s avec SweetAlert
        swal("SuccÃ¨s!", "Fournisseur ajouté às la lite noire avec succés!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'Ã©chec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'ajout de la proposition.", "error");
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
                        <h2>Espace Responsable</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                             <% Object[][] data = (Object[][]) request.getAttribute("data"); %>
          
                  <div class="card recent-sales overflow-auto">
                  
                  
		 <div class="d-flex mb-3 justify-content-between align-items-center">
				    <h5 class="card-title">Liste des fournisseurs <span>| </span></h5>
				    <div>
				        <button class="btn btn-outline-danger" type="button">
				            <a class="link-unstyled" href="/ListeNoire">Liste noire des fournisseurs</a>
				        </button>
				    </div>
				</div>
				
                    <table class="table" id="myTable">
			              <thead>
			                <tr>
			                  <th scope="col">#</th>
			                  <th scope="col" >Nom Fournisseur</th>
			                  <th scope="col">Email </th>
			                  <th scope="col">Nom Societe</th>
			                  <th scope="col" style="width: 140px;">Action</th>
			                 
			                </tr>
			              </thead>
			                
			              <tbody>
			               <% for (Object[] row : data) { %>
			               <% if (((Fournisseur)row[1]).getListeNoire()==-1){ %>
			             
			                                 <tr>
			                                   
			                                      <td><%= ((Fournisseur)row[1]).getId() %></td>
			                                      <td><%= ((User)row[0]).getNom_complet() %></td>
			                                      <td><%= ((User)row[0]).getEmail() %></td>
			                                      <td><%= ((Fournisseur)row[1]).getNomSociete() %></td>
			                                      <td>
<!-- 			                                       <a href="#" ><span class="badge">Consulter</span></a> -->
<!-- 			                                       <i class="bi bi-person-x-fill"></i> 
			                                       <i class="bi bi-card-heading icona"></i>
			                                       <i class="bi bi-person-fill-x icona"></i> -->
			                                       
				                                  <a class=" link-unstyled" href="#" data-bs-toggle="modal" data-bs-target="#modalConsulter<%=((Fournisseur)row[1]).getId() %>" >
											          <i class="bi bi-card-heading icona" style="color:rgb(59, 134, 164);" data-bs-toggle="tooltip" title="Consulter Fournisseur" data-bs-placement="top"></i>
											      </a>
											      
											      <a  class="ms-3 link-unstyled" href="#" data-bs-toggle="modal" data-bs-target="#modalisteNoire<%=((Fournisseur)row[1]).getId() %>" >
												        <i class="bi bi-person-fill-x icona"  style= "color:rgb(203, 41, 41);" data-bs-toggle="tooltip" title="ajouter a la liste noire" data-bs-placement="top"></i>
												   </a>
			                                       
			                                       </td>
			                                      
			                               </tr>
			                            <% }} %>
               
						              </tbody>
						            </table>
						          </div>
	                          </div>
                       
                        <%                     /**********  les modaaaal **********/ 

								//*******************Consulter fournisseur*********************************//  %>
						<% for (Object[] row : data) { %>
<div class="modal modalStyle" id="modalConsulter<%=((Fournisseur)row[1]).getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 40%;text-align:center">
    <div class="modal-content">
       <div class="modal-header">
       <h4 class="modal-title" id="exampleModalLabel" style="color:rgb(91, 140, 160)">Carte fournisseur  :</h4>
      </div>
      <div class="modal-body">
<div class="container">
  <div class="row ">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Nom Complet:</b></label>
      <label ><span><%= ((User)row[0]).getNom_complet() %></span></label>
    </div>
  </div>

  <div class="row ">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Email:</b></label>
      <label ><span><%= ((User)row[0]).getEmail() %></span></label>
    </div>
  </div>

  <div class="row">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Telephone:</b></label>
      <label ><span><%= ((User)row[0]).getFournisseur().getAdresse() %></span></label>
    </div>
  </div>

  <div class="row">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Nom Societe:</b></label>
      <label ><span><%= ((Fournisseur)row[1]).getNomSociete() %></span></label>
    </div>
  </div>

  <div class="row ">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Nom Gerant:</b></label>
      <label ><span><%= ((Fournisseur)row[1]).getNomCompletGerant() %></span></label>
    </div>
  </div>

  <div class="row ">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Adresse :</b></label>
      <label ><span><%= ((Fournisseur)row[1]).getAdresse() %></span></label>
    </div>
  </div>

  <div class="row">
    <div class="col align-items-start">
      <label class="mb-0 d-flex align-items-center"><b>Site Internet:</b></label>
      <label ><a href="<%= ((Fournisseur)row[1]).getSiteInternet() %>"><%= ((Fournisseur)row[1]).getSiteInternet() %></a></label>
    </div>
  </div>
</div>


      
      <div class="modal-footer">
        <button style="background-color:rgb(133, 185, 196) ;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
      </div>
       
    
       
       
      </div>
    </div>
  </div>
</div>
<%} %>
			<% /**************************** Modal liste noire ************************/ %>	
			

 <% for(Object[] row : data){%>

<div class="modal modalStyle" id="modalisteNoire<%=((Fournisseur)row[1]).getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;text-align:center">
    <div class="modal-content">
       <div class="modal-header">
     
       <h4 class="modal-title" id="exampleModalLabel" style="color:rgb(91, 140, 160)">Ajouter a liste noire:</h4>
     
      </div>
      <div class="modal-body">
      <form action="/ajouterAuListeNoire" method="post">
      <input type="hidden" name="fournisseurId" value="<%=((Fournisseur)row[1]).getId() %>">
      <input type="hidden" name="UserId" value="<%=((User)row[0]).getId() %>">
  
     
        <label class="mb-3 d-flex align-items-center"><b>Motif d'elimination:</b></label>
      <div class="input-group mb-3">
        <textarea type="text" name="motif" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"  placeholder="Motif de mise sur liste noire"></textarea>
      </div>
      
      
      <div class="modal-footer">
        <button style="background-color:rgb(133, 185, 196) ;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
         <input style="background-color:rgb(133, 185, 196) ;" type="submit" class="btn btn-primary" value="Confirmer" />
      </div>
        </form>
    
       
       
      </div>
    </div>
  </div>
</div>

 <% } %>
 				
	             
	    </div>   </section>
</body>
</html>