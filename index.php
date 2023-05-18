<?php
include "database.php";
?>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@500;700&display=swap" rel="stylesheet">

</head>
<body>
    <header>
        
    </header>
    <h1>Планові вимкнення електроенергії</h1>
    <section class = "enter-data container">
        <div>
            <img src="img/queue.png" alt="queue">
            <select id = "queue">
                <optgroup label="Черга 1">
                    <option value="1">Підчерга 1</option>
                    <option value="2">Підчерга 2</option>
                    <option value="3">Підчерга 3</option>
                    <option value="4">Підчерга 4</option>
                </optgroup>
                <optgroup label="Черга 2">
                    <option value="5">Підчерга 1</option>
                    <option value="6">Підчерга 2</option>
                    <option value="7">Підчерга 3</option>
                    <option value="8">Підчерга 4</option>
                </optgroup>
                <optgroup label="Черга 3">
                    <option value="9">Підчерга 1</option>
                    <option value="10">Підчерга 2</option>
                    <option value="11">Підчерга 3</option>
                    <option value="12">Підчерга 4</option>
                </optgroup>
                <optgroup label="Черга 4">
                    <option value="13">Підчерга 1</option>
                    <option value="14">Підчерга 2</option>
                    <option value="15">Підчерга 3</option>
                </optgroup>
            </select>
        </div>
        <div>
            <img src="img/calendar.png" alt="calendar">
            <input type = "date" id = "date_">
        </div>
        <a id = "search">Шукати</a>
    </section>

    <section class = "clock-box container">
        <div class = 'error false'>
            <h1>Не знайдено даних за вашим запитом!</h1>
            <p>Оберіть іншу дату або чергу</p>
        </div>
        <div class = "clock-box__info">
            <span><div class = "red"></div> <span>- години без електроенергії</span></span>
            <span><div class = "green"></div> <span>- години з електроенергією</span></span>
        </div>
        <div class="clock">
            <canvas id="chart" width="250" height="250"></canvas>
            <div class="clock__image">
                <img src="img/clock.png" alt="clock">
            </div>
        </div>
        <div class = "clock-box__text">
            <div>
                <p>Увімкнення електроенергії:</p>
                <div class = "clock-box__on-time"></div>
            </div>
            <div>
                <p>Вимкнення електроенергії:</p>
                <div class = "clock-box__off-time"></div>
            </div>
        </div>
    </section>
    <script src ="script.js"></script>
</body>
</html>