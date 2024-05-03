
  
  <link rel="stylesheet" href="/styles/sidbar.css">
  <link rel="stylesheet" href="/styles/tableStyle.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
       

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- DataTables JavaScript -->
<script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>


   <script>
  
   $(document).ready(function () {
	    $('#myTable').DataTable({
	        info: false,
	        lengthMenu: false, // Ne pas afficher le choix du nombre d'�l�ments par page
	        paging: false, // Cacher la pagination
	        language: {
	            search: "",
	            emptyTable: "Aucun enregistrement trouvé",
	            zeroRecords: "Aucun résultat correspondant trouvé",
	            lengthMenu: 'Afficher MENU entrées',
	            paginate: {
	                previous: "Précédent",
	                next: "Suivant"
	            }
	        },
	        initComplete: function () {
	            var table = this.api();

	            // Ajouter la classe form-control � l'input de recherche
	            $('#myTable_filter input')
	                .addClass('form-control')
	                .attr('placeholder', 'Rechercher...')
	                .css('margin-bottom', '20px')
	                .css('margin-right', '20px') // Ajouter un espace � droite de l'input
	                .css('width', '90%');
	            // Placer l'input de recherche � droite
	            $('#myTable_filter')
	                .css('float', 'right');
	        },
	    });
	});

    </script>
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