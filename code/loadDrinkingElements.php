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
$id = isset($_GET['id']) ? $_GET['id'] : null;

if(isset($id) && $id != ""){
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

    $intid = intval($id);
    $stmt = $conn->prepare("SELECT * FROM `spil` WHERE `zur_id` = ? AND `id_pijanca` = ?");

    // Preveri, ali je priprava poizvedbe uspela
    if ($stmt === false) {
        $_SESSION["error"] = "Priprava poizvedbe ni uspela.";
        header("Location: err.php");
        exit();
    }

    // Bind parameters (assuming $intid and $_SESSION['id'] are integers)
    $stmt->bind_param("ii", $intid, $_SESSION["id"]);
    $stmt->execute();

    // Get the result
    $result = $stmt->get_result();

    // Fetch data from the result set and store it in an array
    $podatki = [];
    while ($row = $result->fetch_assoc()) {
        $podatki[] = $row;
    }

    // Close statement and connection
    $stmt->close();
    $conn->close();

    // Send the data back to JavaScript as JSON
    header('Content-Type: application/json');
    echo json_encode($podatki);
} else {
    $_SESSION['error'] = "Vneseni niso vsi podatki!";
}

?>
