<?php
$sess_expiration = 900;
session_set_cookie_params($sess_expiration);
ini_set('session.gc_maxlifetime', $sess_expiration);
session_start();
if (!isset($_SESSION['authenticated']) || $_SESSION['authenticated'] !== true) {
    header("Location: index.php");
    exit;
}
if (isset($_SESSION['expire_time']) && time() > $_SESSION['expire_time']) {
    // If the session has expired, destroy the session and redirect to login page
    session_unset();
    session_destroy();
    header("Location: index.php");
    exit;
}

class EventData {
    // Properties
    public $title;
    public $start;
    public $allDay;
  }

$servername = "localhost";
    $user = "root";
    $pass = "";
    $dbname = "todolist";

    $conn = new mysqli($servername, $user, $pass, $dbname);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
        echo mysqli_error($conn);
        exit;
    }
    /*
    $sql = "SELECT todo_group.name, todo_group.id as groupid, todo.id, todo.todo, todo.finished, todo.deadline FROM `pripada` inner join todo_group on (pripada.group_id = todo_group.id) inner join todo on (todo_group.id = todo.group_id) where user_id = \"" . $_SESSION['id'] . "\"";
    $result = $conn->query($sql);*/
    $sql = "SELECT todo_group.name, todo_group.id as groupid, todo.id, todo.todo, todo.finished, todo.deadline FROM `pripada` inner join todo_group on (pripada.group_id = todo_group.id) inner join todo on (todo_group.id = todo.group_id) where user_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $_SESSION['id']);
    $stmt->execute();
    $result = $stmt->get_result();
    $results = array();
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()) {
            //var_dump($_SESSION['groupIds']);
            foreach($_SESSION['groupIds'] as $group){
                $eventObj = new EventData();
                $eventObj->title = $row["todo"];
                $eventObj->start = $row["deadline"];
                $eventObj->allDay = false;
                if(true == $row['finished'] && $group == $row['groupid']){
                    array_push($results, $eventObj);
                    //echo json_encode($eventObj);
                    //echo "/"; // zatu, da se pole splita po /
                }
                else if(false == $row['finished'] && $group == $row['groupid']){
                    array_push($results, $eventObj);
                    //echo json_encode($eventObj);
                    //echo "/";
                }
            }
        }
    }
    $conn->close();
    $stmt->close();
    echo json_encode($results);
?>