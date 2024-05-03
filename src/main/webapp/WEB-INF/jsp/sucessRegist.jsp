<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription réussie</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f0f5ff; /* Couleur de fond bleu clair */
            color: #333; /* Couleur de texte foncée */
            font-family: Arial, sans-serif; /* Style de police */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 800px;
            padding: 20px;
            border-radius: 8px;
            background-color: #fff; /* Fond blanc pour le contenu */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Effet d'ombre douce */
            text-align: center;
        }
        h1 {
            color: #007bff; /* Couleur de titre bleue */
        }
        p {
            margin-bottom: 20px;
        }
        .icon {
            font-size: 48px;
            margin-bottom: 20px;
            color: #28a745; /* Couleur verte pour l'icône */
        }
        .registration-link {
            color: #007bff; /* Couleur verte pour le lien d'inscription */
            text-decoration: none; /* Supprimer la soulignement du lien */
        }
        .registration-link:hover {
            text-decoration: underline; /* Soulignement lorsqu'on survole le lien */
        }
    </style>
</head>
<body>
    <div class="container">
        <i class="fas fa-check-circle icon"></i>
        <h1 style="color: #28a745;">Inscription réussie !</h1>
        <p>Votre inscription a été effectuée avec succès. Vous pouvez maintenant vous connecter à votre compte.</p>
        <p><a href="/connexion" class="registration-link">Accéder à la page de connexion</a></p>
    </div>
</body>
</html>
