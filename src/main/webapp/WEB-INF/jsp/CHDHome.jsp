<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace chef de département</title>
  <%@  include file="links.jsp"%>

<style>
.bColor
{
color:rgb(48, 96, 184)  ;
}

</style>

</head>



<body>

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
                <a href="/myressources_CHD"><i class="fas fa-qrcode"></i>Les besoins</a>
            </li>
            <li class="menu-item">
              <a href="/communiquer_CHD"><i class="fas fa-link"></i>Demmander des besoins</a>
            </li>
         
        </ul>
        </nav>
                        <section>
                    <div class="p-3">
                        <h2>Espace chef de departement</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalAjouter" >
             				 <i class="bi bi-plus-square"  style="color:rgb(58, 109, 221); margin-left: 700px;font-size:30px;" data-bs-toggle="tooltip" title="Ajouter un nouveau besoin" data-bs-placement="top"></i>
              					</a>
                            <% 
                            
                               List<Ressource> listeRessources = (List<Ressource>)request.getAttribute("ListeRessources");
                               List<Ordinateur> listeOrdinateur = (List<Ordinateur>)request.getAttribute("ListeOrdinateur");
                               List<Imprimante> listeImprimante = (List<Imprimante>)request.getAttribute("ListeImprimante");
                            
                            %>
                           
                           
                             <div class="card recent-sales overflow-auto">
                             
                             
                             
                             <%  if (!listeOrdinateur.isEmpty()) {  %>
                             <h5 class="card-title">Liste besoins <span>|Ordinateur </span></h5>
				              <table class="table  ">
				              <thead>
				                <tr>
				                  <th scope="col">#</th>
				                  <th scope="col" >CPU</th>
				                  <th scope="col">RAM </th>
				                  <th scope="col">disque Dur</th>
				                  <th scope="col">Ecran</th>
				                  <th scope="col"> Enseignant</th>
				                  <th scope="col">Action</th>
				                
				                 
				                </tr>
				              </thead> 
				              <tbody>
				              
				              <% for (Ordinateur or : listeOrdinateur) { %>
				                                 <tr>
				                                      <td><%= or.getId() %></td>
				                                      <td><%= or.getCPU() %></td>
				                                      <td><%= or.getRAM() %></td>
				                                      <td><%= or.getDisqueDur() %></td>
				                                      <td><%= or.getEcran() %></td>
				                                      <td><%= (or.getRessource().getEnseignant() != null) ? or.getRessource().getEnseignant().getUser().getNom_complet() : "partagé" %></td>
				                                   
				                                      
               <% 
           if (or.getRessource().getEnseignant() != null){
                            	   %>
                   <td>        	    
             	 
             	  <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalModifierOrd<%=or.getId() %>" >
             	 <i class="bi bi-pencil"   style="color:rgb(58, 109, 221);font-size:25px;" data-bs-toggle="tooltip" title="Modifer projet" data-bs-placement="top"></i>
              	</a>
              	</a>
             	 
             	  <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalSupprimer<%=or.getId() %>" >
             	 <i class="bi bi-trash3"  style="color:rgb(255, 0, 0);font-size:25px;" data-bs-toggle="tooltip" title="Supprimer projet" data-bs-placement="top"></i>
              	</a>
              	</a>
              	</td>
                     
                                 <% }
          else { %>
                                 
                     <td>        	    
             	 
             	  <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalModifierOrdPAR<%=or.getId() %>" >
             	 <i class="bi bi-pencil"   style="color:rgb(58, 109, 221);font-size:25px;" data-bs-toggle="tooltip" title="Modifer projet" data-bs-placement="top"></i>
              	</a>
              	</a>
             	 
             	  <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalSupprimerOrdPAR<%=or.getId() %>" >
             	 <i class="bi bi-trash3"  style="color:rgb(255, 0, 0);font-size:25px;" data-bs-toggle="tooltip" title="Supprimer projet" data-bs-placement="top"></i>
              	</a>
              	</a>
              	</td>  
		  
		     <%  }%>
              
             	 
                 
				                            <% } %>
                                        
				               </tr>
				              </tbody>
				            </table>
				            <% }%>
				                
				            <br><br>
				            
				              <!-- la table imprimante -->
				             
						    <%  if (!listeImprimante.isEmpty()) {  %>
						    <h5 class="card-title">Liste besoins | Imprimante </h5>
						        <table class="table">
						            <thead>
						                <tr>
						                    <th scope="col">#</th>
						                    <th scope="col">Résolution</th>
						                    <th scope="col">Vitesse d'impression</th>
						                    <th scope="col"> Enseignant</th>
						                    
						                     <th scope="col">Action</th>
						                </tr>
						            </thead> 
						            <tbody>
						                <% for (Imprimante imp : listeImprimante) { %>
						                    <tr>
						                        <td><%= imp.getId() %></td>
						                        <td><%= imp.getResolution() %></td>
						                        <td><%= imp.getVitesseImpression() %></td>
						                        <td><%= (imp.getRessource().getEnseignant() != null) ? imp.getRessource().getEnseignant().getUser().getNom_complet() : "partagé" %></td>
				                                   
				                                   
						                              
						                       
              	
              	
              	
              	
              	               <% 
           if (imp.getRessource().getEnseignant() != null){
                            	   %>
                        	    
             	 
             	  <td>
             	 <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalModifierImp<%=imp.getId() %>" >
             	 <i class="bi bi-pencil"   style="color:rgb(58, 109, 221);font-size:25px;" data-bs-toggle="tooltip" title="Modifer projet" data-bs-placement="top"></i>
              	</a>
              	
              	 <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalSupprimer<%=imp.getId() %>" >
             	 <i class="bi bi-trash3"  style="color:rgb(255, 0, 0);font-size:25px;" data-bs-toggle="tooltip" title="Supprimer projet" data-bs-placement="top"></i>
              	</a>
              	</td>
              	
                     
                                 <% }
          else { %>
                                 
                            	    
             	 
             	 <td>
             	 <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalModifierImpPAR<%=imp.getId() %>" >
             	 <i class="bi bi-pencil"   style="color:rgb(58, 109, 221);font-size:25px;" data-bs-toggle="tooltip" title="Modifer projet" data-bs-placement="top"></i>
              	</a>
              	
              	 <a class="ms-5" href="#" data-bs-toggle="modal" data-bs-target="#modalSupprimerImpPAR<%=imp.getId() %>" >
             	 <i class="bi bi-trash3"  style="color:rgb(255, 0, 0);font-size:25px;" data-bs-toggle="tooltip" title="Supprimer projet" data-bs-placement="top"></i>
              	</a>
              	</td>
               
		  
		     <%  }%>
						                <% } %>
						                </tr>
						            </tbody>
						        </table>
						    <% } %>
						        
										    
				          </div>
              
      <form id="validationForm" method="post" action="EnvoyerBesoinsCHD">
		  
		    <button  type="submit" style="margin-left: 500px;" onclick="this.disabled=true; this.innerText='Envoi en cours...'; this.form.submit();" class="btn btn-primary">Envoyer les besoins au responsable</button>
		</form>
                    </div>
             
   
    
     <%                           
    List<Ordinateur> listeOrdinateur1 = (List<Ordinateur>)request.getAttribute("ListeOrdinateur");
	
for (Ordinateur or : listeOrdinateur1) { 
	 if (or.getRessource().getEnseignant()!= null){%>
		 
		 <div class="modal modalStyle" id="modalSupprimer<%=or.getId() %>" tabindex="-1">
		    <div class="modal-dialog" >
		      <div class="modal-content">
		        <div class="modal-header">
		          <h5 class="modal-title" id="exampleModalLabel" style="color:rgb(39, 148, 232); font-size:26px; font-family:Lucida Bright;">Confirmation de la suppression:</h5>
		          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		        </div>
		        <div class="modal-body delete-modal">
		         
		          <p>Voulez-vous vraiment supprimer ce besoin ?</p>
		          <small class="font-weight-bold" style="color:#cda01b;">
		            <i class="bi bi-exclamation-triangle-fill" style="color:#e82311;"></i>
		              Cette action ne peut pas être annulée !
		          </small>
		          <div class="modal-footer mt-3 ms-4 " >
		           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
		            <form  method="post" action="/SupprimerBesoinOrdiCHD">
		             <input type="hidden" name="idOrdi" value="<%=or.getId() %>">
		             <input type="hidden"  name="idChef" value="<%=or.getRessource().getEnseignant().getDepartement().getChefDep().getId() %>">
		              <input type="submit"  data-bs-dismiss="modal" value="Supprimer" class="btn btn-danger" style="font-size: 18px;">
		            </form>
		            
		          </div>
		  
		      </div>
		    </div>
		  </div> 
		  </div>



		<div class="modal modalStyle" id="modalModifierOrd<%= or.getId() %>" tabindex="-1">
		    <div class="modal-dialog" style="max-width: 50%;">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="exampleModalLabel" style="color: #0f63b8f1;">mes besoins :</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>

		            <div class="modal-body">
		                <div class="data-panel">
		                    <h5 class="mb-4" style="color: rgb(18, 46, 108);">Modifier mon besoin</h5>

		                    <form  method="post" action="/ModifierBesoinOrdCHD">
		                 
		    <div class="mb-3">
		         <input type="hidden" name="idOrd" value="<%= or.getId() %>">
		         <input type="hidden" name="idChef" value="<%= or.getRessource().getEnseignant().getDepartement().getChefDep().getId() %>">
		        
		        <div class="row mb-3">
		            <div class="col-md-6">
		                <label for="cpu" class="form-label">CPU :</label>
		                <input type="text" id="cpu" name="cpu" value="<%= or.getCPU() %>" class="form-control">
		            </div>
		            <div class="col-md-6">
		                <label for="ram" class="form-label">RAM :</label>
		                <input type="text" id="ram" name="ram" value="<%= or.getRAM() %>" class="form-control">
		            </div>
		        </div>
		        
		        <div class="row mb-3">
		            <div class="col-md-6">
		                <label for="disqueDur" class="form-label">Disque Dur :</label>
		                <input type="text" id="disqueDur" name="disqueDur" value="<%= or.getDisqueDur() %>" class="form-control">
		            </div>
		            <div class="col-md-6">
		                <label for="ecran" class="form-label">Écran :</label>
		                <input type="text" id="ecran" name="ecran" value="<%= or.getEcran() %>" class="form-control">
		            </div>
		        </div>
		    </div>

		    <div class="modal-footer">
		        <input type="submit" class="btn btn-primary" value="Modifier">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
		    </div>
		</form>


		                </div>
		            </div>
		        </div>
		    </div>
		</div>

		 
	 <%}
	 else
	 {
                 
                            %>
                            

<div class="modal modalStyle" id="modalSupprimerOrdPAR<%=or.getId() %>" tabindex="-1">
    <div class="modal-dialog" >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel" style="color:rgb(39, 148, 232); font-size:26px; font-family:Lucida Bright;">Confirmation de la suppression:</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body delete-modal">
         
          <p>Voulez-vous vraiment supprimer ce besoin ?</p>
          <small class="font-weight-bold" style="color:#cda01b;">
            <i class="bi bi-exclamation-triangle-fill" style="color:#e82311;"></i>
              Cette action ne peut pas être annulée !
          </small>
          <div class="modal-footer mt-3 ms-4 " >
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
            <form  method="post" action="/SupprimerBesoinOrdiCHDPAR">
             <input type="hidden" name="idOrdi" value="<%=or.getId() %>">
              <input type="hidden" name="idChef" value="<%= or.getRessource().getAffectation().getDepartement().getChefDep().getId() %>">
        
            <input type="submit"  data-bs-dismiss="modal" value="Supprimer" class="btn btn-danger" style="font-size: 18px;">
            </form>
            
          </div>
  
      </div>
    </div>
  </div> 
  </div>



<div class="modal modalStyle" id="modalModifierOrdPAR<%= or.getId() %>" tabindex="-1">
    <div class="modal-dialog" style="max-width: 50%;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel" style="color: #0f63b8f1;">mes besoins :</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="data-panel">
                    <h5 class="mb-4" style="color: rgb(18, 46, 108);">Modifier mon besoin</h5>

                    <form  method="post" action="/ModifierBesoinOrdCHD">
                 
    <div class="mb-3">
        <input type="hidden" name="idOrd" value="<%= or.getId() %>">
       
        <input type="hidden" name="idChef" value="<%= or.getRessource().getAffectation().getDepartement().getChefDep().getId() %>">
        
        <div class="row mb-3">
            <div class="col-md-6">
                <label for="cpu" class="form-label">CPU :</label>
                <input type="text" id="cpu" name="cpu" value="<%= or.getCPU() %>" class="form-control">
            </div>
            <div class="col-md-6">
                <label for="ram" class="form-label">RAM :</label>
                <input type="text" id="ram" name="ram" value="<%= or.getRAM() %>" class="form-control">
            </div>
        </div>
        
        <div class="row mb-3">
            <div class="col-md-6">
                <label for="disqueDur" class="form-label">Disque Dur :</label>
                <input type="text" id="disqueDur" name="disqueDur" value="<%= or.getDisqueDur() %>" class="form-control">
            </div>
            <div class="col-md-6">
                <label for="ecran" class="form-label">Écran :</label>
                <input type="text" id="ecran" name="ecran" value="<%= or.getEcran() %>" class="form-control">
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <input type="submit" class="btn btn-primary" value="Modifier">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
    </div>
</form>


                </div>
            </div>
        </div>
    </div>
</div>
 <%}
	
  %>
 <%
						}
   				%>
   				
   				<%                           
   			 List<Imprimante> listeImprimante1 = (List<Imprimante>)request.getAttribute("ListeImprimante");
                
                        		  for (Imprimante imp : listeImprimante1) {
                        			
                        					 if (imp.getRessource().getEnseignant()!= null){%>
                        					 
<div class="modal modalStyle" id="modalSupprimer<%=imp.getId() %>" tabindex="-1">
    <div class="modal-dialog" >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel" style="color:rgb(39, 148, 232); font-size:26px; font-family:Lucida Bright;">Confirmation de la suppression:</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body delete-modal">
        
          <p>Voulez-vous vraiment supprimer ce besoin ?</p>
          <small class="font-weight-bold" style="color:#cda01b;">
            <i class="bi bi-exclamation-triangle-fill" style="color:#e82311;"></i>
              Cette action ne peut pas être annulée !
          </small>
          <div class="modal-footer mt-3 ms-4 " >
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
            <form  method="post" action="/SupprimerBesoinImpCHD">
             <input type="hidden" name="idImpri" value="<%=imp.getId() %>">
              <input type="hidden"  name="idChef" value="<%=imp.getRessource().getEnseignant().getDepartement().getChefDep().getId() %>">
              <input type="submit"  data-bs-dismiss="modal" value="Supprimer" class="btn btn-danger" style="font-size: 18px;">
            </form>
            
          </div>
  
      </div>
    </div>
  </div> 
  </div>
  
  
  
  
<div class="modal modalStyle" id="modalModifierImp<%= imp.getId() %>" tabindex="-1">
    <div class="modal-dialog" style="max-width: 50%;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel" style="color: #0f63b8f1;">mes besoins :</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="data-panel">
                    <h5 class="mb-4" style="color: rgb(18, 46, 108);">Modifier mon besoin</h5>

                    <form method="post" action="/ModifierBesoinImpCHD">
			    <div class="mb-3">
			        <input type="hidden" name="idImp" value="<%= imp.getId() %>">
			        <input type="hidden" name="idChef" value="<%= imp.getRessource().getEnseignant().getDepartement().getChefDep().getId() %>">
			        
			        <div class="row mb-3">
			            <div class="col-md-6">
			                <label for="vitesseImpression" class="form-label">Vitesse d'impression :</label>
			                <input type="text" id="vitesseImpression" name="vitesseImpression" value="<%= imp.getVitesseImpression() %>" class="form-control">
			            </div>
			            <div class="col-md-6">
			                <label for="resolution" class="form-label">Résolution :</label>
			                <input type="text" id="resolution" name="resolution" value="<%= imp.getResolution() %>" class="form-control">
			            </div>
			        </div>
			    </div>
			
			    <div class="modal-footer">
			        <input type="submit" class="btn btn-primary" value="Modifier">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
			    </div>
			</form>

                </div>
            </div>
        </div>
    </div>
</div>
<%} else {%>
   				<div class="modal modalStyle" id="modalSupprimerImpPAR<%=imp.getId() %>" tabindex="-1">
    <div class="modal-dialog" >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel" style="color:rgb(39, 148, 232); font-size:26px; font-family:Lucida Bright;">Confirmation de la suppression:</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body delete-modal">
        
          <p>Voulez-vous vraiment supprimer ce besoin ?</p>
          <small class="font-weight-bold" style="color:#cda01b;">
            <i class="bi bi-exclamation-triangle-fill" style="color:#e82311;"></i>
              Cette action ne peut pas être annulée !
          </small>
          <div class="modal-footer mt-3 ms-4 " >
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
            <form  method="post" action="/SupprimerBesoinImpCHDPAR">
             <input type="hidden" name="idImpri" value="<%=imp.getId() %>">
              <input type="hidden"  name="idChef" value="<%=imp.getRessource().getAffectation().getDepartement().getChefDep().getId() %>">
              <input type="submit"  data-bs-dismiss="modal" value="Supprimer" class="btn btn-danger" style="font-size: 18px;">
            </form>
            
          </div>
  
      </div>
    </div>
  </div> 
  </div>
  
  
  
  
<div class="modal modalStyle" id="modalModifierImpPAR<%= imp.getId() %>" tabindex="-1">
    <div class="modal-dialog" style="max-width: 50%;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel" style="color: #0f63b8f1;">mes besoins :</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="data-panel">
                    <h5 class="mb-4" style="color: rgb(18, 46, 108);">Modifier mon besoin</h5>

                    <form method="post" action="/ModifierBesoinImpCHD">
			    <div class="mb-3">
			        <input type="hidden" name="idImp" value="<%= imp.getId() %>">
			        <input type="hidden" name="idChef" value="<%= imp.getRessource().getAffectation().getDepartement().getChefDep().getId() %>">
			        
			        <div class="row mb-3">
			            <div class="col-md-6">
			                <label for="vitesseImpression" class="form-label">Vitesse d'impression :</label>
			                <input type="text" id="vitesseImpression" name="vitesseImpression" value="<%= imp.getVitesseImpression() %>" class="form-control">
			            </div>
			            <div class="col-md-6">
			                <label for="resolution" class="form-label">Résolution :</label>
			                <input type="text" id="resolution" name="resolution" value="<%= imp.getResolution() %>" class="form-control">
			            </div>
			        </div>
			    </div>
			
			    <div class="modal-footer">
			        <input type="submit" class="btn btn-primary" value="Modifier">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
			    </div>
			</form>

                </div>
            </div>
        </div>
    </div>
</div>
 <%}
	
  %>
 <%
						}
   				%>
   		
   	<div class="modal modalStyle" id="modalAjouter" tabindex="-1">
  <div class="modal-dialog" style="max-width: 50%;">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="color:#0f63b8f1">Ajouter un besoin partage </h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="modal-body">
              <div class="data-panel">
                

                  <form  id="formId" method="post" action="/AddBesoinPartage">
                       <div class="mb-3">
			        <label for="typeRessource" class="form-label">Type de ressource :</label>
			        <select name="typeRessource" id="typeRessource" class="form-select" onchange="afficherChamps(this.value)">
			            <option value="ordinateur">Ordinateur</option>
			            <option value="imprimante">Imprimante</option>
			        </select>
			    </div>
			
			    <div id="ordinateurFields" style="display:block;">
			        <div class="row mb-3">
			           
			            <div class="col-md-6">
			                <label for="cpu" class="form-label">CPU :</label>
			                <input type="text" id="cpu" name="cpu" class="form-control form-control-sm">
			            </div>
			            
			            <div class="col-md-6">
			                <label for="ram" class="form-label">RAM :</label>
			                <input type="text" id="ram" name="ram" class="form-control form-control-sm">
			            </div>
			        </div>
			        <div class="row mb-3">
			            
			            <div class="col-md-6">
			                <label for="disqueDur" class="form-label">Disque Dur :</label>
			                <input type="text" id="disqueDur" name="disqueDur" class="form-control form-control-sm">
			            </div>
			            <div class="col-md-6">
			                <label for="ecran" class="form-label">Écran :</label>
			                <input type="text" id="ecran" name="ecran" class="form-control form-control-sm">
			            </div>
			        </div>
			       
			    </div>
			
			    <div id="imprimanteFields" style="display:none;">
			        <div class="row mb-3">
			            <div class="col-md-6">
			                <label for="vitesseImpression" class="form-label">Vitesse d'impression :</label>
			                <input type="text" id="vitesseImpression" name="vitesseImpression" class="form-control form-control-sm">
			            </div>
			            <div class="col-md-6">
			                <label for="resolution" class="form-label">Résolution :</label>
			                <input type="text" id="resolution" name="resolution" class="form-control form-control-sm">
			            </div>
			        </div>
			    </div>
			
			    <div class="modal-footer">
			        <input type="submit" class="btn btn-primary" value="Ajouter" onclick="submitForm()">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
			    </div>
			</form>
              </div>
          </div>
      </div>
  </div>
</div>
   	
   	</section>
    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>

function submitForm() {
    document.getElementById('formId').submit(); 
}

function afficherChamps(typeRessource) {
    var ordinateurFields = document.getElementById('ordinateurFields');
    var imprimanteFields = document.getElementById('imprimanteFields');

    if (typeRessource === 'ordinateur') {
        ordinateurFields.style.display = 'block';
        imprimanteFields.style.display = 'none';
    } else if (typeRessource === 'imprimante') {
        ordinateurFields.style.display = 'none';
        imprimanteFields.style.display = 'block';
    }
}
    // Récupérer le paramètre de l'URL
    const urlParams = new URLSearchParams(window.location.search);
    
    const testModif = urlParams.get('testModif');
    if (testModif === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "Le besoin a été modifié  avec succès!", "success");
    } else if (testModif === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'envoie des deonnees.", "error");
    }
    
    
    const testSup = urlParams.get('testSup');
    if (testSup === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "Le besoin a été supprimé  avec succès!", "success");
    } else if (testSup === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'envoie des deonnees.", "error");
    }
    </script>


</body>

</html>