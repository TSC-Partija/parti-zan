<?php

// Start the session
$sess_expiration = 900;
session_set_cookie_params($sess_expiration);
ini_set('session.gc_maxlifetime', $sess_expiration);
session_start();

// Check if the user is logged in
if (!isset($_SESSION['id'])) {
    header("Location: view.php?error=Error:%20User%20not%20logged%20in");
    exit();
}
$owner = intval($_SESSION['id']);


$todo = isset($_GET['toDo']) ? $_GET['toDo'] : null;
$groupId = isset($_GET['groupId']) ? $_GET['groupId'] : null;
$deadline = isset($_GET['deadline']) ? $_GET['deadline'] : null;

$finished = 0;

if(isset($todo) && $todo != "" && isset($groupId) && $groupId != "" && isset($deadline) && $deadline != "" && $owner != 0){
    // Create a new MySQLi object
    $servername = "localhost";
    $user = "root";
    $pass = "";
    $dbname = "todolist";
    $conn = new mysqli($servername, $user, $pass, $dbname);

    // Check connection
    if ($conn->connect_error) {
        header("Location: view.php?error=Error:%20Connection%20failed:%20" . $conn->connect_error);
        exit();
    }

    // Prepare and bind the insert query
    $groupId = intval($groupId);
    
    echo "test";

        // Predpostavljamo, da so spremenljivke $owner, $todo, $finished, $deadline, $groupId že definirane
    $stmt = $conn->prepare("INSERT INTO todo (owner, todo, finished, deadline, group_id) VALUES (?, ?, ?, ?, ?)");

    // Preverite, ali je priprava poizvedbe uspela
    if ($stmt === false) {
        $_SESSION["error"] = "Priprava poizvedbe ni uspela.";
        header("Location: err.php");
        exit();
    }

    // Bind parameters
    $stmt->bind_param("isisi", $owner, $todo, $finished, $deadline, $groupId);

    // Izvrši poizvedbo
    $stmt->execute();
    echo "jajajajasjdakdjlsadlsk";
    // Preveri, ali je bilo vstavljanje uspešno
    if ($stmt->affected_rows > 0) {
        echo "dela";
        // Vstavljanje je bilo uspešno
        $_SESSION['error'] = "Podatki so bili uspešno vstavljeni.";
    } else {
        // Vstavljanje ni uspelo
        echo "blabla";
        $_SESSION['error'] = "Vstavljanje podatkov ni uspelo.";
    }

    // Close the statement and connection
    $conn->close();
}
else{
    echo "bruh";
    $_SESSION['error'] = "Vneseni niso vsi podatki!";
}

?>
