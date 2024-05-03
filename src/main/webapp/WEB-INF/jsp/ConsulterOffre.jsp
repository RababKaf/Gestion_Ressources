<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace Responsable </title>

  <%@  include file="links.jsp"%>

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
                        
                            <% List<Proposition> listprp = (List<Proposition>)request.getAttribute("ListeProposition");
                               List<Ressource> listRs = (List<Ressource>)request.getAttribute("listeRessource");
                            %>
                           
                           
                             <div class="card recent-sales overflow-auto">
                             <h5 class="card-title">Liste des propositions<span>| </span></h5>
                             <table class="table" id="myTable">
              <thead>
              <tr  style="text-align:center; ">
              
               <th colspan="3">La demande</th>
            <th colspan="3">La proposition</th>
              </tr>
                <tr style ="background-color:rgb(216, 242, 247)  ;">
                  <td scope="col">#</th>
                  <th scope="col" >Type</th>
                  <th scope="col">Caractéristiques </th>
                  <th scope="col">Marque</th>
                  <th scope="col">Prix</th>
                  <th scope="col">Date de fin de garantie</th>
                </tr>
              </thead>
                
              <tbody>
              <% for (int i = 0; i < listprp.size(); i++) { 
            	  Ressource rs=  listRs.get(i) ;
            	  Proposition pr = listprp.get(i) ;
            	  Imprimante  imp =rs.getImprimante();
            	  Ordinateur or = rs.getOrdinateur() ;
              
              %>
                                 <tr>
                                      <td><%= pr.getId() %></td>
                                     
                                      <% if(imp != null) {%>
                                      <td>Imprimante</td>
                                      <td>
                                      <label><b>Resolution: </b><%=imp.getResolution() %></label>
                                      <p> <b>Vitesse : </b><%=imp.getVitesseImpression() %></p>
                                      </td>
                                      <%} else { %>
                                      <td>Ordinateur</td>
                                      <td>
                                      <label><b>CPU: </b><%= or.getCPU() %></label><br>
                                      <label><b>Disque Dur : </b><%= or.getDisqueDur() %></label><br>
                                      <label> <b> Ecran :</b> <%= or.getEcran() %></label>
                                      <p><b>RAM : </b><%=or.getRAM() %></p>
                                      </td>
                                      <%} %>
                                      <td><%= pr.getMarque() %></td>
                                      <td><%= pr.getPrix() %><b> DH</b></td>
                                      <td><%= pr.getDureGarantie() %></td>
                                      
                               </tr>
                            <% } %>
               
              </tbody>
            </table>
    
          </div>
              
                    </div>
                </section>
  
   
</body>
</html>