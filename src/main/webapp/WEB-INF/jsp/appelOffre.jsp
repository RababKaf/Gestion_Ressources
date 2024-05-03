<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.entity.*" %>
<%@ page import="java.util.List" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des appels d'offres</title>
    <style>
       
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-bottom: 20px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .search-container {
            text-align: left;
            margin-bottom: 20px;
        }
        .search-container input[type=text] {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        #modifierModal {
    display: none;
}

* Style pour le modal */
.modal {
  display: none; /* Par défaut, le modal est caché */
  position: fixed; /* Positionnement fixe pour couvrir la fenêtre */
  z-index: 1; /* Assure que le modal est affiché au-dessus du reste du contenu */
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto; /* Activer le défilement si nécessaire */
  background-color: rgba(0, 0, 0, 0.4); /* Fond semi-transparent */
}

/* Style pour le contenu du modal */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* Centrer le modal verticalement */
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  max-width: 600px; /* Largeur maximale du modal */
  border-radius: 5px; /* Coins arrondis */
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* Ombre légère */
}

/* Style pour le bouton de fermeture */
.close {
  color: #aaa;
  position: absolute; /* Position absolue */
  top: 10px; /* Distance depuis le haut */
  right: 10px; /* Distance depuis la droite */
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  text-decoration: none;
  cursor: pointer;
}


.form-group {
  margin-bottom: 20px;
}

label {
  display: block; /* Afficher chaque libellé sur une ligne séparée */
  font-weight: bold; 
}

textarea,
input,
select {
  width: 100%; /* Largeur maximale */
  padding: 8px; /* Espacement intérieur */
  border: 1px solid #ccc; /* Bordure légère */
  border-radius: 4px; /* Coins arrondis */
  box-sizing: border-box; /* Inclure la bordure et le rembourrage dans la largeur */
}

/* Style pour le bouton de soumission */
input[type="submit"] {
  background-color: #4CAF50; /* Couleur de fond */
  color: white; /* Couleur du texte */
  padding: 10px 20px; /* Espacement intérieur */
  border: none; /* Pas de bordure */
  border-radius: 4px; /* Coins arrondis */
  cursor: pointer; /* Curseur pointeur */
}

input[type="submit"]:hover {
  background-color: #45a049; /* Couleur de fond au survol */
}
    </style>

<%@ include file="links.jsp" %>
</head>
<body>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');

    if (successParam === 'true') {
        // Afficher une alerte de succès avec SweetAlert
        swal("Succès!", "L'opération a été effectuée avec succès!", "success");
    } else if (successParam === 'false') {
        // Afficher une alerte d'échec avec SweetAlert
        swal("Erreur!", "Une erreur s'est produite lors de l'opération.", "error");
    }
</script>
<script>
    function openModifierModal(id, dateDebut, dateFin) {
        // Remplir les champs du modal avec les valeurs de l'appel d'offre sélectionné
        document.getElementById('idAppelOffre').value = id;
        document.getElementById('startDate').value = dateDebut;
        document.getElementById('endDate').value = dateFin;

        // Afficher le modal
        $('#modifierModal').modal('show');
    }

    function filterByYear() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("appelOffreTable");
        tr = table.getElementsByTagName("tr");
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1]; // Colonne Date Début
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    function filterByMonth() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("appelOffreTable");
        tr = table.getElementsByTagName("tr");
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1]; // Colonne Date Début
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    function resetFilter() {
        var input = document.getElementById("searchInput");
        input.value = "";
        var table = document.getElementById("appelOffreTable");
        var tr = table.getElementsByTagName("tr");
        for (var i = 0; i < tr.length; i++) {
            tr[i].style.display = "";
        }
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
         
            <li class="menu-item">  <a href="/updateRessources"><i class="fas fa-link"></i> Consulter ressources</a></li>
                <li class="menu-item">   <a href="/appelOffre"> </a><i class="fas fa-qrcode"></i>    Gestion de appel d'offre</a></li>
                    <li class="menu-item"> <a href="/appelOffreCode"></a><i class="fas fa-link"></i>     Gestion de ressource</a></li>
<li class="menu-item"><a href="/Fournisseurs"><i class="fas fa-stream"></i>Fournisseurs</a></li>
 <li class="menu-item"><a href="/Propositions"><i class="fas fa-calendar-week"></i>Propositions</a></li>
 <li class="menu-item"><a href="/Liste_Panne"><i class="far fa-question-circle"></i>Panne</a></li>
     
     
    </ul>
    </nav>

                <section>
                    <div class="p-3">

<h1>Hello Responsable</h1>
<div class="search-container">
    <input type="text" placeholder="Rechercher..." id="searchInput">
    <button onclick="filterByYear()">Filtrer par Année</button>
    <button onclick="filterByMonth()">Filtrer par Mois</button>
    <button onclick="resetFilter()">Réinitialiser</button>
    <a href="/add-appel-offre">
    <button>Ajouter Appel d'offre</button>
</a>
</div>
<%
    List<AppelOffre> listeAppelOffres = (List<AppelOffre>) request.getAttribute("listeAO");
%>
<table id="appelOffreTable">
    <thead>
    <tr>
        <th>Appel d'Offre</th>
        <th>Date Début</th>
        <th>Date Fin</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <% for (AppelOffre appelOffre : listeAppelOffres) { %>
    <tr>
        <td><%= appelOffre.getDescription() %></td>
        <td><%= appelOffre.getDateDebut() %></td>
        <td><%= appelOffre.getDateFin() %></td>
        <td>
           <a href="/ModifierAppelOffreRespo?id=<%=appelOffre.getId() %>" title="Consulter">
    <i class="bi bi-eye"></i>
</a>
<a href="#" onclick="openModifierModal('<%=appelOffre.getId() %>', '<%=appelOffre.getDateDebut() %>', '<%=appelOffre.getDateFin() %>')" data-bs-toggle="modal" data-bs-target="#modifierModal" title="Modifier">
    <i class="bi bi-pencil"></i>
</a>

        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<!-- Modal -->
<div class="modal" id="modifierModal" tabindex="-1" aria-labelledby="modifierModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modifierModalLabel">Modifier</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/update-appel-offre" method="post">
                <input type="hidden" id="idAppelOffre" name="idAppelOffre">
                <div class="modal-body">
                		
                    <label for="startDate">Date de début :</label>
                    <input type="date" id="startDate" name="startDate">
                    <br>
                    <br>
                    <label for="endDate">Date de fin :</label>
                    <input type="date" id="endDate" name="endDate">

                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary" id="confirmButton">Confirmer</button>
                    
                </div>
            </form>
</div></div>    </div></section></body>
</html>