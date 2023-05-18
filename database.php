<?php
    $servername ="localhost";
    $username ="vlasid_admin";
    $password = "vlasid_admin_password";
    $dbname ="outagescheduledb";
    
    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);//підключення до бази даних
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        // Відкриття файлу SQL
        $sqlFile = file_get_contents('database/outagescheduledb.sql');//вказуємо шлях до бази даних
    
        // Виконання SQL-запиту
        $conn->exec($sqlFile);
    
    } catch(PDOException $e) {
    }
    

//-----------------------------------------------------------------------------------------------------
$timeData = array();


if($_GET['subqueue'] == null) {
    $subqueue = 1;
}
else {
    $subqueue = $_GET['subqueue'];
}
if($_GET['date'] == null) {//перевіряє дані отримані від клієнта(комп користувача)
    $date = '2023-02-01';//якщо дані не були передані задає 2023-02-01
}
else {
    $date = $_GET['date'];// отримання даних з клієнта
}

$sql = "SELECT * FROM power_outages JOIN dates ON power_outages.id_date = dates.id WHERE dates.date = '$date' AND power_outages.id_subqueue = '$subqueue'";// запит до бази даних на вибірку даних
$result = $conn->query($sql);


while ($row = $result->fetch(PDO::FETCH_ASSOC)) {//запис даних до масиву
    $timeData[] = $row;
}

$jsonData = json_encode($timeData);//створення json файлу для передачі даних на клієнт(комп користувача)

echo $jsonData;


//-------------------------------------------------------------------------------------------------
?>