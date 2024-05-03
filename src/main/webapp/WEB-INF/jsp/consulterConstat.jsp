<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.example.demo.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <%@  include file="links.jsp"%>
 
<style>

/* Style for tables */
table {
    width: 100%;
    border-collapse: collapse;
}

/* Style for table headers */
th {
    background-color: #f2f2f2;
    text-align: left;
    padding: 8px;
}

/* Style for table rows */
tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* Style for table cells */
td {
    padding: 8px;
    border-bottom: 1px solid #ddd;
}

/* Hover effect on table rows */
tr:hover {
    background-color: #f1f1f1;
}

/* Style for h2 headings */
h2 {
    margin-top: 20px;
    margin-bottom: 10px;
}

input[type="text"] {
    padding: 8px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

/* Style pour les champs de recherche lorsqu'ils sont focus */
input[type="text"]:focus {
    border-color: #66afe9;
    outline: none;
}
#select-container select {
    width: 70%;
    padding: 10px;
    font-size: 16px;
    border-radius: 5px;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

#select-container select:focus {
    border-color: #007bff; /* Highlight when focused */
}


h1{
color:#06456F;
}
/* Style pour le modal */
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
  background-color: #45a049; /* Couleur de fond au survol */
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
        swal("Succès!", "Le constat a été enregistré avec succès!", "success");
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
            <li class="menu-item">
                <a href="/consulterPanneTechnicien">
                    <i class="fas fa-home"></i> Accueil
                </a>
            </li>
            <li class="menu-item">
                <a href="/consulterPanneTechnicien">
                    <i class="fas fa-plus"></i> Consulter Pannes
                </a>
            </li>
            <li class="menu-item">
                <a href="/consulterConstat">
                    <i class="fas fa-folder-open"></i>Consulter Constats
                </a>
            </li>
        </ul>
        </nav>
 <section>
 
 <h1>Liste des Constats</h1>

    <input type="text" id="searchImprimantes" placeholder="Rechercher dans les Constats">


<table id="tableImprimantes" border="1">
        <thead>
            <tr>
                <th>idConstat</th>
                <th>idPanne</th>  
                <th>Expliquation Panne</th>
                <th>Ordre</th>
                <th>Fréquence</th>      
                <th>Code-Barre</th>
                <th>Actions</th>
               
                
            </tr>
        </thead>
        <tbody>
            <% List<Constat> constats = (List<Constat>) request.getAttribute("constats");
            if ( constats != null && !constats.isEmpty()) 
            for (Constat con: constats) {%>
                <tr>
                    <td><%= con.getId() %></td>
                    <td><%= con.getPanne().getId() %></td>
                    <td><%= con.getExplication_Panne()%></td>
                    <td><%= con.getOrdre() %></td>
                    <td><%= con.getFrequence_Panne() %></td>
                    <td><%= con.getPanne().getRessource().getCodeBarre()%></td>
                   
                    <td >
                    <i class="fas fa-pencil-alt " style="color :#06456F; cursor: pointer;" onclick="openModal('<%=con.getId()%>','<%=con.getExplication_Panne()%>','<%= con.getOrdre() %>','<%= con.getFrequence_Panne() %>')"></i>
  
</td>
                </tr>
            <% } %>
        </tbody>
  </table>

 </section>


<div id="myModal1" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2 style="text-align: center;" >Rédiger un constat</h2>
    <form id="constatForm" action="/modifier-constat" method="post" >
        <input type="hidden" id="panneIdModal1" name="panneIdModal">
      <div class="form-group">
        <label for="explicationPanne">Explication de la panne :</label>
        <textarea id="explicationPanne" name="explicationPanne" rows="4" cols="50" required></textarea>
      </div>

  

      <div class="form-group">
        <label for="frequencePanne">Fréquence de la panne :</label>
        <select id="frequencePanne" name="frequencePanne" required>
          <option value="rare">Rare</option>
          <option value="fréquente">Fréquente</option>
          <option value="permanente">Permanente</option>
        </select>
      </div>

      <div class="form-group">
        <label for="ordreLogiciel">Ordre logiciel ou matériel :</label>
            <select id="ordreLogiciel" name="ordreLogiciel" required>
          <option value="défaut_système">défaut_système</option>
          <option value="défaut_logiciel">défaut_logiciel</option>
          <option value="défaut_matériel">défaut_matériel</option>
        </select>
      </div>

      <input type="submit" value="Enregistrer">
    </form>
  </div>
</div>


</body>





<script>
    function openModal(constatId,expliquation,ordre,frequence) {

        document.getElementById("panneIdModal1").value = constatId;
        document.getElementById("myModal1").style.display = "block";
        document.getElementById("explicationPanne").value =expliquation;
        document.getElementById("ordreLogiciel").value =ordre;
        document.getElementById("frequencePanne").value=frequence;
 
    }

    document.addEventListener("DOMContentLoaded", function() {
        var closeBtn = document.querySelector(".close");
        closeBtn.addEventListener("click", function() {
            document.getElementById("myModal1").style.display = "none";
        });

        window.addEventListener("click", function(event) {
            var modal = document.getElementById("myModal1");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        });
    });
</script>




<script>
//Function to handle table filtering based on user input
function filterTable(inputElement, tableId) {
    const filterValue = inputElement.value.toUpperCase();
    const table = document.getElementById(tableId);
    const rows = table.getElementsByTagName('tr');

    // Loop through all table rows, hide those that don't match the search input
    for (let i = 0; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName('td');
        let found = false;

        // Loop through the cells in the current row to check for a match
        for (let j = 0; j < cells.length; j++) {
            const cell = cells[j];
            if (cell) {
                const textValue = cell.textContent || cell.innerText;
                if (textValue.toUpperCase().indexOf(filterValue) > -1) {
                    found = true;
                    break; // Found a match, no need to check other cells
                }
            }
        }

        // Toggle row display based on whether a match was found
        rows[i].style.display = found ? '' : 'none';
    }
}

// Add event listeners to the search inputs
document.getElementById('searchImprimantes').addEventListener('input', function () {
    filterTable(this, 'tableImprimantes');
});

document.getElementById('searchOrdinateurs').addEventListener('input', function () {
    filterTable(this, 'tableOrdinateurs');
});


// Function to fetch Pannes via AJAX based on selected Technicien and Resource
function fetchPannes(panneId,ressourceId) {
	
	 var technicienId = document.getElementById('technicienId').value;

	
	 var ressourceId= String(ressourceId);


	  $.ajax({
	        type: 'POST',
	        url: '/savePanne',
	        data: {
	            ressourceId: ressourceId,
	            technicienId: technicienId,
	            panneId: panneId
	        },
	        success: function(response) {
	            console.log('Notification marked as read successfully');
	            // Optionally, update the UI to reflect the change
	        },
	        error: function(xhr, status, error) {
	            console.error('Error marking notification as read:', error);
	            // Handle error scenario
	        }
	    });
}
</script>
</html>