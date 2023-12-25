<?php

// Start the session
$sess_expiration = 900;
session_set_cookie_params($sess_expiration);
ini_set('session.gc_maxlifetime', $sess_expiration);
session_start();

// Check if the user is logged in
if (!isset($_SESSION['id'])) {
    //header("Location: view.php?error=Error:%20User%20not%20logged%20in");
    exit();
}

// Access the data fields using $_GET
$zur_id = isset($_GET['zur_id']) ? $_GET['zur_id'] : null;

if(isset($zur_id) && $zur_id != ""){
    // Create a new MySQLi object
    $servername = "localhost";
    $user = "root";
    $pass = "";
    $dbname = "todolist";
    $conn = new mysqli($servername, $user, $pass, $dbname);

    // Check connection
    if ($conn->connect_error) {
        $_SESSION["error"] = "conn: $conn";
        header("Location: err.php");
        exit();
    }

    // Prepare and bind the insert query
    //echo "Sesija: ".$_SESSION["id"];
    $stmt = $conn->prepare("SELECT MIN(drink_date) as min_date FROM `spil` WHERE `zur_id` = ? AND `id_pijanca` = ?");
    $stmt->bind_param("ii", $zur_id, $_SESSION["id"]);
    $stmt->execute();
    $minResult = $stmt->get_result();
    $minData = $minResult->fetch_assoc();
    $min = $minData['min_date'];
    
    $stmt = $conn->prepare("SELECT MAX(drink_date) as max_date FROM `spil` WHERE `zur_id` = ? AND `id_pijanca` = ?");
    $stmt->bind_param("ii", $zur_id, $_SESSION["id"]);
    $stmt->execute();
    $maxResult = $stmt->get_result();
    $maxData = $maxResult->fetch_assoc();
    $max = $maxData['max_date'];
    
    // Close statement and connection
    $stmt->close();
    $conn->close();
    
    $min_max = ['min' => $min, 'max' => $max];
    
    // Send the data back to JavaScript as JSON
    header('Content-Type: application/json');
    echo json_encode($min_max);
} 
else {
    $_SESSION['error'] = "Vneseni niso vsi podatki!";
}
?>