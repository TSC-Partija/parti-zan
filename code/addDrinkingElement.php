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

// Read the request data from the input stream
$input = file_get_contents('php://input');

// Convert the JSON string to a PHP object
$data = json_decode($input);

// Check if the JSON decoding was successful
if ($data === null) {
    $_SESSION["error"] = "data: $data";
    header("Location: view.php?error=Error:%20Invalid%20input%20data");
    //header("Location: err.php");
    exit();
}

// Access the data fields
$name = $data->name;
$id = $data->id;
$alc = $data->alc;
$size = $data->size;
$alcG = $data->alcG;

if(isset($name) && $name != "" && isset($id) && $id != ""){
    // Create a new MySQLi object
    $servername = "localhost";
    $user = "root";
    $pass = "";
    $dbname = "todolist";
    $conn = new mysqli($servername, $user, $pass, $dbname);

    // Check connection
    if ($conn->connect_error) {
        $_SESSION["error"] = "conn: $conn";
        //header("Location: view.php?error=Error:%20Connection%20failed:%20" . $conn->connect_error);
        header("Location: err.php");
        exit();
    }

    // Prepare and bind the insert query

    $intid = intval($id);
    $finished = 0;
    $stmt = $conn->prepare("INSERT INTO `spil` (`id_pijanca`, `zur_id`, `datum`, `seznam`, `kolicina`, `procenti`, `alkoholG`, `drink_date`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

    // date('Y-m-d H:i:s') --> potrebujemo čas, ko je uporabnik spil pijačo --> to je za izračun količine alkohola v krvi
    $current_time = date('Y-m-d H:i:s');
    $stmt->bind_param("iiisdiis", $_SESSION["id"], $intid, $finished, $name, $size, $alc, $alcG, $current_time);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        // Insertion successful
        echo"juhuhu";
    } else {
        // Insertion failed
        $_SESSION['error'] = "Failed to insert data.";
    }

    // Close the statement and connection
    $conn->close();
}
else{
    $_SESSION['error'] = "Vneseni niso vsi podatki!";
}

?>
