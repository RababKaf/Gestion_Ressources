<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.example.demo.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <meta charset="UTF-8">
      <link rel="stylesheet" type="text/css" href="/styles/NavBar.css">
        <link rel="stylesheet" type="text/css" href="css/cssJEE/modal.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">     
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
       <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
       
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.min.css">
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.min.js"></script>
  

 
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
color:#06456F;}

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
                <a href="/affecterPanne">
                    <i class="fas fa-home"></i> Accueil
                </a>
            </li>
            <li class="menu-item">
                <a href="/affecterPanne">
                    <i class="fas fa-plus"></i> Consulter Pannes
                </a>
            </li>
         
        </ul>
        </nav>
 <section>
 
 <h1>Liste des Ressources en Panne</h1>
<h2>Imprimantes</h2>
    <input type="text" id="searchImprimantes" placeholder="Rechercher dans les imprimantes">


<table id="tableImprimantes" border="1">
        <thead>
            <tr>
                <th>idPanne</th>
                <th>Code-Barre</th>
                <th>Marque</th>
                <th>Résolution</th>        
                <th>Vitesse d'impression</th>
                <th>Expliquation Panne</th>
                 <th>Date Panne</th>
                <th>Actions</th>
               
                
            </tr>
        </thead>
        <tbody>
            <% List<Panne> pannes = (List<Panne>) request.getAttribute("pannes");
            if ( pannes != null && !pannes.isEmpty()) 
            for (Panne im: pannes) { if ( im.getRessource().getImprimante() != null){%>
                <tr>
                    <td><%= im.getId() %></td>
                    <td><%= im.getRessource().getCodeBarre()%></td>
                    <td><%= im.getRessource().getMarque() %></td>
                    <td><%= im.getRessource().getImprimante().getResolution() %></td>
                    <td><%= im.getRessource().getImprimante().getVitesseImpression() %></td>
                    <td><%=im.getExplicationPanne() %></td>
                    <td><%= im.getDatePanne() %></td>
                    <td id="select-container">
    <select name="technicienId" id="technicienId" onchange="fetchPannes('<%= im.getId() %>', '<%= im.getRessource().getId() %>')">
        <option value="">Sélectionnez un technicien</option>
        <% List<Technicien> tech = (List<Technicien>) request.getAttribute("tech");
        for (Technicien technicien : tech) { %>
            <option value="<%= technicien.getId() %>"><%= technicien.getUser().getNom_complet() %></option>
        <% } %>
    </select>
</td>
                </tr>
            <% }} %>
        </tbody>
    </table>
<h2>Ordinateurs</h2>
<input type="text" id="searchOrdinateurs" placeholder="Rechercher dans les ordinateurs">

<table id="tableOrdinateurs" border="1">
        <thead>
            <tr>
              <th>idPanne</th>
                <th>Code-Barre</th>
                <th>Marque</th>
                <th>CPU</th>
                <th>Disque Dur</th>
                <th>Écran</th>
                <th>RAM</th>
                  <th>Expliquation Panne</th>
                 
                 <th>Date Panne</th>
                 
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
           <% List<Panne> pannes2 = (List<Panne>) request.getAttribute("pannes");
            if ( pannes != null && !pannes.isEmpty()) 
            
            for (Panne ordi: pannes2) {  if ( ordi.getRessource().getOrdinateur() != null){%>
                <tr> 
                      <td><%=ordi.getId() %></td>
                    <td><%= ordi.getRessource().getCodeBarre() %></td>
                    <td><%= ordi.getRessource().getMarque() %></td>
                    <td><%= ordi.getRessource().getOrdinateur().getCPU() %></td>
                    <td><%= ordi.getRessource().getOrdinateur().getDisqueDur() %></td>
                    <td><%= ordi.getRessource().getOrdinateur().getEcran() %></td>
                    <td><%= ordi.getRessource().getOrdinateur().getRAM() %></td>
                     <td><%=ordi.getExplicationPanne() %></td>
                    
                      <td><%= ordi.getDatePanne() %></td>
                                <td id="select-container">
                                
    <select name="technicienId" id="technicienId1" onchange="fetchPannes1('<%= ordi.getId() %>', '<%= ordi.getRessource().getId() %>')">
    
        <option value="">Sélectionnez un technicien</option>
           <% List<Technicien> tech = (List<Technicien>) request.getAttribute("tech");
        for (Technicien technicien : tech) { %>
            <option value="<%= technicien.getId() %>"><%= technicien.getUser().getNom_complet() %></option>
        <% } %>
    </select>
</td></tr>
            <% }} %>
        </tbody>
    </table>

 </section>


</body>

<script>
function toggleNotifications() {
    var notifications = document.getElementById("notificationMessages");
    notifications.style.display = (notifications.style.display === "none") ? "block" : "none";
}

function markAsRead(notificationId) {
    // Check if the notification has already been marked as read
var shortMessage = document.getElementById(notificationId).getElementsByClassName('short-message')[0];
var fullMessage = document.getElementById(notificationId).getElementsByClassName('full-message')[0];

if (fullMessage.style.display === 'none') {
    shortMessage.style.display = 'none';
    fullMessage.style.display = 'block';
} else {
    shortMessage.style.display = 'block';
    fullMessage.style.display = 'none';
}
    var notificationCard = document.getElementById(notificationId);
    if (notificationCard.classList.contains("read-notification")) {
        return; // Do nothing if already read
    }

    MODIFYDataBase(notificationId);


    

    // Update the notification count (you may want to fetch it from the server)
    var notificationCount = parseInt(document.getElementById("notificationCount").innerHTML);
    if (notificationCount > 0) {
        notificationCount--;
        document.getElementById("notificationCount").innerHTML = notificationCount;

        // Hide the badge if there are no more notifications
        document.getElementById("notificationCount").style.display = (notificationCount > 0) ? "block" : "none";
    }

    // Toggle background color to indicate the notification has been read
    notificationCard.classList.add("read-notification");
}
function MODIFYDataBase(notificationId) {
    $.ajax({
        type: 'POST',
        url: '/notifications/markAsRead',
        data: {
            notificationId: notificationId
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

function fetchPannes1(panneId,ressourceId) {
	
	 var technicienId = document.getElementById('technicienId1').value;

	
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