<?php
if(isset($_SESSION["error"]))unset($_SESSION["error"]);
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

// Reset the session expiration time on user activity
$_SESSION['expire_time'] = time() + $sess_expiration;
?>

<!DOCTYPE html>
<head>
    <title>Parti-zan</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="style.css" rel="stylesheet">
    <style>
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #bf2126;
            padding: 10px;
            color: white;
            text-decoration: none;
            text-align: center;
            }
        a.footer:hover{
            background-color: #d8a528;
        }
    </style>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
</head>

<div id="myDIV" class="header">
    <?php if($_SESSION['username'] != "guest"): ?>
        <img id = "options-button"
        src="images/sickIkonca.svg"
        alt="|||"
        height="60"
        width="70" />
        <div id="options-window">
            <h2 id="options">NASTAVITVE</h2>
            <hr/>
            <a href="dodajSkupino.php"><p id="skupina" class="nastavitve">Ustvari skupino</p></a>
            <a href="dodajvskupino.php"><p id="dodajskupina" class="nastavitve">Dodaj v skupino</p></a>
            <a href="changePass.php"><p id="spremenigeslo" class="nastavitve">Spremeni geslo</p></a>
        </div>
    <?php endif; ?>
    <div id="shopping-window">
        <h2 id="shopping-title" style="vertical-align: baseline">SHOPPING</h2><img src="images/shopping-cart.png" style="height:50px">
        <input type="text" id="shopping" placeholder="Izdelki..." maxlength="60" style="width: 100%" onkeypress="handleKeyPressShop(event)">
        <span onclick="newShoppingElement()" class="addBtn" style="width: 100%">Dodaj</span>
        <ul id="shoppingUl">
        </ul>
    </div>

    <div id="drink-window">
        <h2 id="drink-title">DRINK</h2>
        <input type="text" id="drinking" placeholder="Pijače..." maxlength="60" style="width: 100%" onkeypress="handleKeyPressDrink(event)">
        <span onclick="newDrinkElement()" class="addBtn" style="width: 100%">Dodaj</span>
        <ul id="drinkingUl" style="color:black">
        </ul>
        <?php
        //if (isset($_SESSION["data"]) && $_SESSION["data"] != NULL){
        //    echo ($_SESSION["data"]);
        //}
        ?>
    </div>
    <img id = "logo"
    src="images/Parti-zan_logo.svg"
    alt="|||"
    height="90"
    width="100" />
</div>
<div id = "taskDiv" class = "container-fluid">
    <h2 style="margin:5px;">Moji Žuri</h2>
        <?php if($_SESSION['username'] != "guest"): ?>
            <div class="row">
                <div class = "col-sm-8">
                    <input type="text" id="todo" placeholder="Naslov..." maxlength="60">
                    <input type="datetime-local" id="date" name="datetime" placeholder="deadline">
                </div>
                <div id = "groups2" class = "col-sm-4">
                    <select id="groups" class = "addSelect">
                        <?php

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
                            $id = $_SESSION['id'];
                            /*
                            $sql = "SELECT `group_id`, `name` FROM `todo_group` inner join pripada on (pripada.group_id = todo_group.id) where user_id = $id;";
                            $result = $conn->query($sql);*/
                            $stmt = $conn->prepare("SELECT `group_id`, `name` FROM `todo_group` inner join pripada on (pripada.group_id = todo_group.id) where user_id = ?");
                            $stmt->bind_param("i", $id);
                            $stmt->execute();
                            $result = $stmt->get_result();
                            if($result->num_rows > 0){
                                while($row = $result->fetch_assoc()) {
                                    foreach($_SESSION['groupIds'] as $group){
                                        if($group == $row['group_id']){
                                            echo "<option value=\"" . $group . "\" id=\"" . $group . "\">" . $row['name'] . "</option>";
                                        }
                                    }
                                }
                            }
                            $stmt->close();
                            $conn->close();
                            //echo "<option value=" . $value1 . " id=" . $value1 . ">" . $groups['name'] . "</option>";

                        ?>

                    </select>
                    
                <span onclick="newElement()" class="addBtn">Dodaj</span>
                <?php
                    
                    if(isset($_SESSION['error'])){
                        echo("<p style=\"color: red; background-color: white; width: max-content; margin-left: 40px\">Vnesi vse podatke!</p>");
                        echo $_SESSION["error"];
                        unset($_SESSION['error']);
                    }
                    ?>
            </div>
            <?php endif; ?>
        </div>
    
</div>

<ul id="myUL">

    <?php

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
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()) {
            //var_dump($_SESSION['groupIds']);
            foreach($_SESSION['groupIds'] as $group){
                $rowDate = str_replace("T", " ", $row['deadline']);
                if(true == $row['finished'] && $group == $row['groupid']){
                    echo "<li id=\"" . $row['id'] . "\" class=checked><b style=\"text-transform: uppercase;\">" . $row['todo'] . "</b>&nbsp&nbspSkupina: " . $row['name'] . "&nbsp&nbspKončaj do: " . $rowDate . "</li>";
                }
                else if(false == $row['finished'] && $group == $row['groupid']){
                    echo "<li id=\"" . $row['id'] . "\"><b style=\"text-transform: uppercase;\">" . $row['todo'] . "</b>&nbsp&nbspSkupina: " . $row['name'] . "&nbsp&nbspKončaj do: " . $rowDate . "</li>";
                }
            }
        }
    }
    $conn->close();
    //SELECT todo_group.name, todo.todo, todo.finished, todo.deadline FROM `pripada` inner join todo_group on (pripada.group_id = todo_group.id) inner join vsebuje on (vsebuje.group_id = todo_group.id) inner join todo on (vsebuje.todo_id = todo.id) where user_id = 1;

    ?>
</ul>
<?php
        if(isset($_SESSION["error"])){
            echo $_SESSION["error"];
        }
        ?>
<div id = "calendarDiv" class = "container-fluid">
    <div id = "calendar"></div>
</div>
<!-- odstrani ta div če bo preveč praznga placa -->
<div id ="foot" class = "container-fluid">
    <h7 class="footer" style="margin-bottom: 35px" name="<?= $_SESSION['username'] ?>">Prijavljen kot: <?= $_SESSION['username'] ?></h7>
    <a class="footer" href="logout.php">ODJAVA</a>
</div>
<script src="script.js"></script>