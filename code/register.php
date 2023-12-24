<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Registracija</title>
        <link rel="stylesheet" type="text/css" href="st.css">
    </head>
    <body>
        <div class="main-div">
            <h1>Registracija</h1>
            <form method="POST" action="registerUser.php">
                <label for="username">Up. ime:</label>
                <input type="text" id="username" name="username" maxlength="25" style="margin-bottom: 0"><br><br>
                <label for="username">E-mail:</label>
                <input type="text" id="email" name="email" maxlength="25" style="margin-bottom: 0"><br><br>
                <label for="password">Geslo:</label>
                <input type="password" id="password" name="password" maxlength="25" style="margin-bottom: 0"><br><br>
                <p style="margin-top: 0">Spol:</p>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="gender" id="genderM" value="M" checked>
                    <label class="form-check-label" for="genderM">
                        M
                    </label>
                </div>
                <div class="form-check" style="margin-bottom: 20px">
                    <input class="form-check-input" type="radio" name="gender" id="genderZ" value="Z">
                    <label class="form-check-label" for="genderZ">
                        Z
                    </label>
                </div>
                <label for="weight">Teža(kg):</label>
                <input type="number" id="weight" name="weight" maxlength="3" style="padding: 10px"><br><br>
                <button type="submit">REGISTRACIJA</button>
            </form>
            <form action="index.php">
                <button type="submit" style="margin-top: 10px">NAZAJ</button>
            </form>
            <?php if (isset($_GET['error'])): ?>
                <p><?php echo $_GET['error']; ?></p>
            <?php endif; ?>
        </div>
    </body>
</html>