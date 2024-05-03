<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.example.demo.entity.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/styles/global.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceuil</title>
    <link rel="icon" href="/images/logo.png" type="image/icon type">
    <script src="/js/jquery.js"></script>
</head>
<body >
<%@ include file="navbar.jsp" %>
    <div id="navbarcontainer"></div>
    <div class="newscontainer">
        <div id="bighometitle">Welcome To NetRessourcesFaculty</div>
        <div id="newsnews">
            <span id="newsnewsnews">Les Appels d'Offres Actuelles</span>
        </div>
        <div id="newsholder">
        
         <%List<AppelOffre> appOffs = (List<AppelOffre>) request.getAttribute("appelOffres");
        if (appOffs != null && !appOffs.isEmpty()) 
        for (AppelOffre appOff : appOffs) { %> 
        
        
         <span id="singlenewsholder">
            <span id="newstitle"> <span style="display: block; text-align: center;">
            AppelOffre n°<span style="color: blue;"><%=appOff.getId()%></span><br>  de <span style="color: blue;"><%=appOff.getDateDebut()%></span> jusqu'à <span style="color: blue;"><%=appOff.getDateFin()%></span> </span></span>
          <br>
            <span id="newsdescription"><%=appOff.getDescription()%><br>
            <%List<Ressource> resses=appOff.getRessources();
        if (resses!= null && !resses.isEmpty()) {
        	  for (Ressource ress : resses) { %>
        	<% if (ress.getOrdinateur()!= null){  %> 
            
             
              <ul><li><strong>Ordinateur</strong> <%= ress.getMarque() %> :
<strong>Processeur (CPU) :</strong> <%= ress.getOrdinateur().getCPU() %> GHz ,
<strong>Disque dur :</strong> <%= ress.getOrdinateur().getDisqueDur() %> Go ,
<strong>Mémoire vive (RAM) :</strong> <%= ress.getOrdinateur().getRAM() %> Go ,
<strong>Écran :</strong> <%= ress.getOrdinateur().getEcran()%>
<%} %></li>


    	<% if (ress.getImprimante()!= null){  %> 
            
             
              <li><strong>Imprimante</strong> <%= ress.getMarque() %> :
<strong>Résolution :</strong> <%= ress.getImprimante().getResolution() %>,
       <strong>Vitesse d'impression :</strong> <%= ress.getImprimante().getVitesseImpression() %>
    </li></ul>
<%} %>


</li></ul>
<%}} %>
 <a href="/inscription" style="display: block; text-align: center;">Répondre</a> 
 
</span>
        
    
    </span>
          <% } %>
        </div>
    </div>
    <script src="/js/index.js"></script>
</body>
</html>
