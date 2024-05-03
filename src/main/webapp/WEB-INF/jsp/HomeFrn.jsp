<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.util.*" %>
   <%@ page import="com.example.demo.entity.*" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Espace fournisseur</title>



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
            <li class="menu-item">
                 <a href="/ListeAO"><i class="fas fa-qrcode"></i>Appels d'offre</a></li>
       <li class="menu-item"><a href="/MesOffres"><i class="fas fa-stream"></i>Mes Offes</a></li>
         
        </ul>
        </nav>
<section>

                    <div class="p-3">
                        <h2>Espace fournisseur</h2>
                        
                        <!-- Affichage de la liste des appels d'offres -->
                        
                            <% List<AppelOffre> listeAppelOffres = (List<AppelOffre>)request.getAttribute("listeAppelOffres");%>
                           
                           
                             <div class="card recent-sales overflow-auto">
                             <h5 class="card-title">Appels d'offre  <span>| </span></h5>
              <table class="table" id="myTable">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col" style="width: 200px;">Description</th>
                  <th scope="col">Date debut </th>
                  <th scope="col">Date fin</th>
                  <th scope="col">Action</th>
                 
                </tr>
              </thead>
                
              <tbody>
              <% for (AppelOffre appelOffre : listeAppelOffres) { %>
                                 <tr>
                                      <td><%= appelOffre.getId() %></td>
                                      <td><%= appelOffre.getDescription() %></td>
                                      <td><%= appelOffre.getDateDebut()%></td>
                                      <td><%= appelOffre.getDateFin() %></td>
                                      <td> <a href="/ConsulterRessources_Frn?id=<%=appelOffre.getId()%>" ><span class="badge">Consulter</span></a></td>
                                      
                               </tr>
                            <% } %>
               
              </tbody>
            </table>
    
          </div>
              
                    </div>
                </section>
      
    <!-- Liens vers les scripts Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>