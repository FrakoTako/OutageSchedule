const canvas = document.getElementById('chart');
const ctx = canvas.getContext('2d');
const centerX = canvas.width / 2;
const centerY = canvas.height / 2;
const radius = canvas.width / 2;

const search = document.querySelector('#search');//отримання доступу до елемента сторінки

var sendQueue = document.querySelector('#queue');
var sendDate = document.querySelector('#date_');

const onTime = document.querySelector('.clock-box__on-time');
const offTime = document.querySelector('.clock-box__off-time');

const error_ = document.querySelector('.error');


const startDate = "2023-05-16";

sendDate.value = startDate;

var sendData = {
    date: sendDate.value,
    id_subqueue: sendQueue.value
}


function drawDiagram(data) {//функція для малювання графіка
    let startAngle = -0.5 * Math.PI;
    // Малюємо кожний сектор діаграми
    data.forEach(item => {
        const sliceAngle = 2 * Math.PI * item.value / 100;
        const endAngle = startAngle + sliceAngle;

        ctx.beginPath();
        ctx.moveTo(centerX, centerY);
        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
        ctx.closePath();
        ctx.fillStyle = item.color;
        ctx.fill();

        startAngle = endAngle;
    });
}

//-------------------------------------------------------------------------------------

async function getDataFromServer() {//надсилає запит на сервер і витягає дані із сервера
    return new Promise(function (resolve, reject) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var jsonData = JSON.parse(xhr.responseText);
                    try {
                        var on_off_time = getOnOffTime(jsonData[0].on_time, jsonData[0].off_time);
                        error_.classList.add('false');
                        error_.classList.remove('true');
                    } catch {
                        console.log('error');
                        error_.classList.add('true');
                        error_.classList.remove('false');
                    }
                    resolve(on_off_time);
                } else {
                    reject(xhr.status);
                }
            }
        };

        xhr.open('GET', 'database.php', true);
        xhr.open('GET', 'database.php?date=' + sendDate.value + '&subqueue=' + sendQueue.value, true);//дані які відсилаються на сервер(database.php файл який обробляє даня на сервері)
        xhr.send();//відсилання запиту на сервер

        console.log(sendDate.value);
        console.log(sendQueue.value);
    });
}

async function getData() {//пряцює доки не буде результату і не зупиняє роботу програми
    try {
        var on_off_time = await getDataFromServer();
        console.log(on_off_time); // Обробка отриманих даних

        let interval = setInterval(function () {
            on_off_time_use = on_off_time;
            console.log(on_off_time_use);

            if (on_off_time_use != undefined) {
                clearInterval(interval);
                drawDiagram(showData());
                showInfo();
            }
        }, 500);

    } catch (error) {
        console.log('Помилка при отриманні даних з сервера:', error);
    }
}

// Дані для кільцевої діаграми

function getOnOffTime(on_time, off_time) {//перетворення даних про час відключення електроенергії отриманих з сервера у масив
    let on_time_arr = on_time.split(',').map(Number);
    on_time_use = on_time_arr;
    let off_time_arr = off_time.split(',').map(Number);
    off_time_use = off_time_arr;
    let on_and_off_time = (on_time_arr.concat(off_time_arr)).sort(function (a, b) {
        return a - b;
    });
    return on_and_off_time;
}

var data = [];

//-----------------------------------------------------------------------------------------------------------------------------

function showInfo() {//відображає дані на сайті у форматі години:хвилини
    let on_tm = '';
    let off_tm = '';
    on_time_use.forEach(element => {
        on_tm += `${element}:00; `;
    });
    console.log(on_time_use);
    console.log(off_time_use);
    off_time_use.forEach(element => {
        off_tm += `${element}:00; `;
    });
    onTime.textContent = on_tm;
    offTime.textContent = off_tm;
}

//-----------------------------------------------------------------------------------------------------------------------------

var on_off_time_use;
var on_time_use;
var off_time_use;

var on_first; //перевіряє чи опівночі світло увімкнене

function showData() {//визначає розмір і колір секцій на графіку

    data.length = 0;
    if (on_time_use[0] > off_time_use[0]) {
        on_first = true;
    } else on_first = false;

    for (let i = 0; i < on_off_time_use.length - 1; i++) {
        let col;
        if (i % 2 === 0) {
            col = '#3ad900';
        } else col = '#ff0000';
        let el = {
            value: ((on_off_time_use[i + 1] - on_off_time_use[i]) * 100) / 24,
            color: col
        }
        data.push(el);
    }
    if (data[data.length - 1].color === '#ff0000') {
        let el = {
            value: ((24 - on_off_time_use[on_off_time_use.length - 1]) * 100) / 24,
            color: '#3ad900'
        }
        data.push(el);
    } else {
        let el = {
            value: ((24 - on_off_time_use[on_off_time_use.length - 1]) * 100) / 24,
            color: '#ff0000'
        }
        data.push(el);
    }

    return data;

}

//-------------------------------------------------------------------------------------

search.addEventListener('click', function () {//відслітковування натискання на кнопку
    sendData.id_subqueue = sendQueue.value;
    getData().then(function (result) {
        console.log(result); // Отримані дані
    });
});