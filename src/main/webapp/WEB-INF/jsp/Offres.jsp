<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Espace fournisseur</title>

  <%@  include file="links.jsp"%>

</head>

<body>

<script>
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    const successParamSup = urlParams.get('successSup');
    
    // Vérifier si l'ajout de proposition a réussi
    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "L'offre a été modifiée avec succès!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de la modification de l'offre.", "error");
    }
    
    if (successParamSup === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "L'offre a été supprimée avec succès!", "success");
    } else if (successParamSup === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de la supprission de l'offre.", "error");
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
            <li class="menu-item">
                 <a href="/ListeAO"><i class="fas fa-qrcode"></i>Appels d'offre</a></li>
       <li class="menu-item"><a href="/MesOffres"><i class="fas fa-stream"></i>Mes Offes</a></li>
         
        </ul>
        </nav>
<section>
                        <h2>Espace fournisseur</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                            <% List<Offre> ListeOffres = (List<Offre>)request.getAttribute("ListeOffres");%>
                           
                           
                             <div class="card recent-sales overflow-auto">
                             <h5 class="card-title">Mes Offres <span>| </span></h5>
                             <table class="table" id="myTable">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Date de livraison</th>
                  <th scope="col">Total </th>
                  <th scope="col">Etat</th>
                  <th scope="col" style="width: 140px;">Action</th>
                 
                </tr>
              </thead>
                
              <tbody>
              <% for (Offre offre : ListeOffres) { %>
                                 <tr>
                                      <td><%= offre.getId() %></td>
                                      <td><%= offre.getDateLivraison() %></td>
                                      <td><%= offre.getTotal() %><b> DH</b></td>
                                      <td>
                                      <% int etat = offre.getEtat() ; %>
                                      <% if (etat == -1) {%>
                                      <span class="badge" style="background-color: red ;">Refuser</span>
                                      <%}  if(etat==1){ %>
                                       <span class="badge" style="background-color: green ;">Accepter</span>
                                      <%}  if(etat==0){ %>
                                      <span class="badge" style="background-color : rgb(41, 97, 182);">En cours</span>
                                      <%} %>
                                       </td>
                                   <td>
		                                  <a class=" link-unstyled" href="#" data-bs-toggle="modal" data-bs-target="#ModifierOffreModal<%=offre.getId() %>">
									          <i class="bi bi-pencil-square icona" style="color:rgb(59, 134, 164);" data-bs-toggle="tooltip" title="Modifier l'offre" data-bs-placement="top"></i>
									      </a>
									      
									      <a  class="ms-3 link-unstyled" href="#" data-bs-toggle="modal" data-bs-target="#modalSupprimer<%=offre.getId() %>" >
										        <i class="bi bi-trash3-fill icona"  style= "color:rgb(203, 41, 41);" data-bs-toggle="tooltip" title="Supprimer l'offre" data-bs-placement="top"></i>
										   </a>
			                                       
			                          </td>
                                      
                               </tr>
                            <% } %>
               
              </tbody>
            </table>
    </div>
                    
                                 
                <%/**** Mes modaaal ****/ %>
                 <% for (Offre offre : ListeOffres) { %>
                 
                 <% /******** Modal envoyer offre ************/ %>
 
 <div class="modal modalStyle" id="ModifierOffreModal<%=offre.getId() %>" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;text-align:center">
    <div class="modal-content">
       <div class="modal-header">
       <h4 class="modal-title" id="exampleModalLabel" style="color:rgb(91, 140, 160)">Modifier offre  :</h4>
      </div>
      <div class="modal-body">
      <form action="/ModifierOffre" method="post">
      <input type="hidden" name="OffreId" value="<%=offre.getId() %>">
         
      <div class="row mb-5 ">
		  <label class="col-sm-3 col-form-label"><b>Total:</b></label>
		  <div class="col-sm-9">
		    <input type="text" name="total" class="form-control"  value ="<%=offre.getTotal() %> " required>
		  </div>
		</div>
		
		   <div class="row  mb-5">
		  <label class="col-sm-3 col-form-label"><b>Date de livraison :</b></label>
		  <div class="col-sm-9">
		    <input type="date" name="DateLivraison"  class="form-control" value="<%= offre.getDateLivraison() %>" required>
		  </div>
		</div>
		
 
      
      <div class="modal-footer">
        <button style="background-color:rgb(133, 185, 196) ;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
         <input style="background-color:rgb(133, 185, 196) ;" type="submit" class="btn btn-primary" value="Modifier" />
      </div>
        </form>
    
       
       
      </div>
    </div>
  </div>
</div>
                 <%} %>
                 
        <% /******** Modal supprimer ********/ %>
           
 <% for (Offre offre : ListeOffres) { %>

<div class="modal modalStyle" id="modalSupprimer<%=offre.getId() %>" tabindex="-1">
    <div class="modal-dialog" >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title text-warning" id="exampleModalLabel" style="font-family:Lucida Bright; "><small class="font-weight-bold" style="color:#cda01b;">
            <i class="bi bi-exclamation-triangle-fill" style="color:#e82311;"></i>
          </small>Confirmation de la suppression </h5><b>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body delete-modal">
         
          <p style="color:red;text-align:center;">Souhaitez-vous réellement supprimer cette offre ?</p>
          </b>
       
           <div style="text-align:center;">
              <div style="text-align:center;"class="modal-footer mt-2 ms-2 " >
           <button style="background-color:#545784A6;" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Non</button>
            <form  method="Post" action="/SuprimerOffre">
             <input type="hidden" name="idOffre" value="<%=offre.getId() %>">
              <input type="submit"  data-bs-dismiss="modal" value="Oui" class="btn btn-danger" style="font-size: 18px;">
          
            </form>
             </div>
          </div>
  
      </div>
    </div>
  </div> 
  </div>
     <%
}
   %>
  
        
                </section>
   
    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>