<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>Erreur d'Authentification</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #D5B7B7;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-container {
            text-align: center;
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h1 {
            color: #e44d26;
        }

        p {
            color: #333;
        }

        .error-code {
            font-size: 2em;
            margin-bottom: 20px;
        }

        .error-message {
            font-size: 1.2em;
            margin-top: 0;
        }

        a {
            color: #e44d26;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Erreur d'Authentification</h1>
        <div class="error-code">404 - Accès Non Autorisé</div>
        <p class="error-message">Vos informations d'identification sont incorrectes ou vous n'avez pas les autorisations nécessaires pour accéder à cette ressource.</p>
        <p>Que faire ensuite?</p>
        <ul>
            <li>Vérifiez que votre nom d'utilisateur et votre mot de passe sont corrects.</li>

            <li><a href="#">Contactez le support technique</a> si le problème persiste.</li>
            <br>
            <p><a href="/connexion"><i class="fas fa-arrow-left"></i> Back to Login Page</a></p>
            
        </ul>
    </div>
</body>
</html>
