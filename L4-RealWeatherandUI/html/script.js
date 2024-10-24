window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'updateUI') {
        const uiElement = document.getElementById('ui');
        uiElement.style.display = 'flex';

        uiElement.classList.remove('top-left', 'top-right', 'center');
        uiElement.classList.add(data.uiPosition);

        if (data.showTime) {
            const timeElement = document.getElementById('time');
            if (timeElement.innerText !== data.time) {
                timeElement.classList.add('time-update');
                setTimeout(() => {
                    timeElement.innerText = data.time;
                    timeElement.classList.remove('time-update');
                }, 250);
            }
        } else {
            document.getElementById('time').innerText = '';
        }

        if (data.showDate) {
            document.getElementById('date').innerText = data.date;
        } else {
            document.getElementById('date').innerText = '';
        }

        if (data.showWeather) {
            document.getElementById('weather-text').innerText = data.weather;
            let iconClass = '';
            switch (data.weather.toLowerCase()) {
                case 'klar':
                    iconClass = 'fas fa-sun';
                    break;
                case 'sehr sonnig':
                    iconClass = 'fas fa-sun';
                    break;
                case 'bewölkt':
                    iconClass = 'fas fa-cloud';
                    break;
                case 'regen':
                    iconClass = 'fas fa-cloud-showers-heavy';
                    break;
                case 'schnee':
                    iconClass = 'fas fa-snowflake';
                    break;
                case 'nebelig':
                    iconClass = 'fas fa-smog';
                    break;
                case 'gewitter':
                    iconClass = 'fas fa-bolt';
                    break;
                case 'smog':
                    iconClass = 'fas fa-smog';
                    break;
                case 'sandsturm':
                    iconClass = 'fas fa-wind';
                    break;
                case 'asche':
                    iconClass = 'fas fa-volcano';
                    break;
                case 'schneeregen':
                    iconClass = 'fas fa-cloud-meatball';
                    break;
                case 'schneesturm':
                    iconClass = 'fas fa-snowflake';
                    break;
                case 'aufklarend':
                    iconClass = 'fas fa-cloud-sun';
                    break;
                case 'stark bewölkt':
                    iconClass = 'fas fa-cloud';
                    break;
                case 'halloween':
                    iconClass = 'fas fa-ghost';
                    break;
                default:
                    const hours = parseInt(data.time.split(':')[0]);
                    if (hours >= 6 && hours < 18) {
                        iconClass = 'fas fa-sun';
                    } else {
                        iconClass = 'fas fa-moon';
                    }
                    break;
            }
            document.getElementById('weather-icon').className = iconClass;
        } else {
            document.getElementById('weather-text').innerText = '';
            document.getElementById('weather-icon').className = '';
        }

        if (data.draggable) {
            makeDraggable(uiElement);
        }
    } else if (data.action === 'hideUI') {
        document.getElementById('ui').style.display = 'none';
    } else if (data.action === 'enableDrag') {
        enableDraggable(document.getElementById('ui'));
    } else if (data.action === 'disableDrag') {
        disableDraggable(document.getElementById('ui'));
    } else if (data.action === 'setPosition') {
        const uiElement = document.getElementById('ui');
        uiElement.style.left = data.left;
        uiElement.style.top = data.top;
    }
});

function makeDraggable(element) {
    let isDragging = false;
    let offsetX, offsetY;

    function onMouseDown(e) {
        isDragging = true;
        offsetX = e.clientX - element.getBoundingClientRect().left;
        offsetY = e.clientY - element.getBoundingClientRect().top;
        document.addEventListener('mousemove', onMouseMove);
        document.addEventListener('mouseup', onMouseUp);
        document.addEventListener('keydown', onKeyDown);
        document.body.style.userSelect = 'none'; 
        fetch(`https://${GetParentResourceName()}/setOriginalPosition`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                left: element.style.left,
                top: element.style.top
            })
        });
    }

    function onMouseMove(e) {
        if (isDragging) {
            let newLeft = e.clientX - offsetX;
            let newTop = e.clientY - offsetY;

            const minTop = 0;
            const maxTop = window.innerHeight - element.offsetHeight;

            if (newTop < minTop) newTop = minTop;
            if (newTop > maxTop) newTop = maxTop;

            element.style.left = `${newLeft}px`;
            element.style.top = `${newTop}px`;
        }
    }

    function onMouseUp() {
        isDragging = false;
        document.removeEventListener('mousemove', onMouseMove);
        document.removeEventListener('mouseup', onMouseUp);
        document.body.style.userSelect = ''; // 
    }

    function onKeyDown(e) {
        if (e.key === 'Enter') {
            isDragging = false;
            document.removeEventListener('mousemove', onMouseMove);
            document.removeEventListener('mouseup', onMouseUp);
            document.removeEventListener('keydown', onKeyDown);
            document.body.style.userSelect = ''; 
            fetch(`https://${GetParentResourceName()}/savePosition`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    left: element.style.left,
                    top: element.style.top
                })
            });
            fetch(`https://${GetParentResourceName()}/nuiFocusOff`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        } else if (e.key === 'Escape') {
            isDragging = false;
            document.removeEventListener('mousemove', onMouseMove);
            document.removeEventListener('mouseup', onMouseUp);
            document.removeEventListener('keydown', onKeyDown);
            document.body.style.userSelect = ''; //
            fetch(`https://${GetParentResourceName()}/resetPosition`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        }
    }

    element.addEventListener('mousedown', onMouseDown);

    element.onMouseDown = onMouseDown;
    element.onMouseMove = onMouseMove;
    element.onMouseUp = onMouseUp;
    element.onKeyDown = onKeyDown;
}

function enableDraggable(element) {
    element.addEventListener('mousedown', element.onMouseDown);
}

function disableDraggable(element) {
    element.removeEventListener('mousedown', element.onMouseDown);
}