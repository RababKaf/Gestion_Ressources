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
    color:rgb(133, 185, 196) ;
    font-size:28px;
    
}

.link-unstyled:hover {
    color: black;
}

</style>
</head>

<body>



<script>
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    console.log(successParam);
    // Vérifier si l'ajout de proposition a réussi
    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "Fournisseur retirer de la lite noire avec succès!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
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
                    
                        <h2>Espace Responsable</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                             <% Object[][] data = (Object[][]) request.getAttribute("data"); %>
          
                  <div class="card recent-sales overflow-auto">
                  
                  
                      <div class="d-grid gap-2 mx-4 d-md-flex justify-content-md-end">
						   
						        <a class="link-unstyled " href="/Fournisseurs" ><i class="bi bi-box-arrow-right"></i></a>
						    
				  </div>
						
                  
                    <table class="table" id="myTable">
			              <thead>
			                <tr>
			                  <th scope="col">#</th>
			                  <th scope="col" >Nom Fournisseur</th>
			                  <th scope="col">Email </th>
			                  <th scope="col">Nom Societe</th>
			                  <th scope="col">Restaurer </th>
			                 
			                 
			                </tr>
			              </thead>
			                
			              <tbody>
			               <% for (Object[] row : data) { %>
			               
			                                 <tr>
			                                   
			                                      <td><%= ((Fournisseur)row[1]).getId() %></td>
			                                      <td><%= ((User)row[0]).getNom_complet() %></td>
			                                      <td><%= ((User)row[0]).getEmail() %></td>
			                                      <td><%= ((Fournisseur)row[1]).getNomSociete() %></td>
			                                      <td>
			                                      <a  class="ms-3 link-unstyled" href="#" data-bs-toggle="modal" data-bs-target="#modalisteNoire<%=((Fournisseur)row[1]).getId() %>" >
												        <i class="bi bi-arrow-clockwise icona"  style= "color:green;" data-bs-toggle="tooltip" title="Restaurer la liste noire" data-bs-placement="top"></i>
												   </a>
			                                      </td>
			                                     
			                                      
			                               </tr>
			                            <% } %>
               
						              </tbody>
						            </table>
						          </div>
	                          </div>
                 
                  <% for(Object[] row : data){%>

<div class="modal modalStyle" id="modalisteNoire<%=((Fournisseur)row[1]).getId() %>" tabindex="-1">
 <div class="modal-dialog" >
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title text-success" id="exampleModalLabel" style="font-family:Lucida Bright; "><small class="font-weight-bold" style="color:#cda01b;">
          
          </small>Confirmation de la restauration: </h4><b>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body delete-modal">
         
          <p style="text-align:center; color: rgb(17, 140, 161) ;"> Vous voulez vraiment retirer ce fournisseur de la liste noire ? .</p>
          </b>
       
           <div style="text-align:center;">
              <div style="text-align:center;"class="modal-footer mt-2 ms-2 " >
           <button style="background-color:#545784A6;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Non</button>
            <form  method="Post" action="/Restauration">
             <input type="hidden" name="frId" value="<%=((Fournisseur)row[1]).getId() %>">
              <input type="submit"  data-bs-dismiss="modal" value="Oui" class="btn btn-success" style="font-size: 18px;">
          
            </form>
             </div>
          </div>
  
      </div>
    </div>
  </div> 
</div>

 <% } %>
	                </section>
	    
</body>
</html>