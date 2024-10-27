window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'updateUI') {
        const uiElement = document.getElementById('ui');
        uiElement.style.display = 'flex';

        uiElement.classList.remove('top-left', 'top-right', 'center');
        uiElement.classList.add(data.uiPosition);

        const cityElement = document.getElementById('city');
        const timeElement = document.getElementById('time');
        const dateElement = document.getElementById('date');
        const weatherElement = document.getElementById('weather');
        const weatherIcon = document.getElementById('weather-icon'); 
        const weatherText = document.getElementById('weather-text'); 
        const separators = document.querySelectorAll('#separator');

        if (data.showCity) {
            cityElement.innerText = data.city;
            cityElement.style.display = 'block';
        } else {
            cityElement.innerText = '';
            cityElement.style.display = 'none';
        }

        if (data.showTime) {
            if (timeElement.innerText !== data.time) {
                timeElement.classList.add('time-update');
                setTimeout(() => {
                    timeElement.innerText = data.time;
                    timeElement.classList.remove('time-update');
                }, 250);
            }
            timeElement.style.display = 'block';
        } else {
            timeElement.innerText = '';
            timeElement.style.display = 'none';
        }

        if (data.showDate) {
            dateElement.innerText = data.date;
            dateElement.style.display = 'block';
        } else {
            dateElement.innerText = '';
            dateElement.style.display = 'none';
        }

        
        if (data.showWeather) {
            weatherIcon.classList.add('fade-out');
            weatherText.classList.add('fade-out');

            setTimeout(() => {
                document.getElementById('weather-text').innerText = data.weather;
                let iconClass = '';
                const currentHour = new Date().getHours();
                const isDayTime = currentHour >= 6 && currentHour < 18; 

                switch (data.weather.toLowerCase()) {
                    case 'klar':
                        iconClass = isDayTime ? 'fas fa-sun' : 'fas fa-moon';
                        break;
                    case 'sehr sonnig':
                        iconClass = isDayTime ? 'fas fa-sun' : 'fas fa-moon';
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
                        iconClass = isDayTime ? 'fas fa-sun' : 'fas fa-moon';
                        break;
                }
                document.getElementById('weather-icon').className = iconClass;

                weatherIcon.classList.remove('fade-out');
                weatherText.classList.remove('fade-out');
                weatherIcon.classList.add('fade-in');
                weatherText.classList.add('fade-in');
            }, 500); 
        } else {
            document.getElementById('weather-text').innerText = '';
            document.getElementById('weather-icon').className = '';
        }

        separators.forEach(separator => separator.style.display = 'none');
        const visibleElements = [cityElement, timeElement, weatherElement, dateElement].filter(el => el.style.display !== 'none');
        visibleElements.forEach((el, index) => {
            if (index < visibleElements.length - 1) {
                el.nextElementSibling.style.display = 'block';
            }
        });

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
    } else if (data.action === 'showAdminUI') {
        const adminUI = document.getElementById('admin-ui');
        adminUI.classList.remove('fade-out');
        adminUI.classList.add('fade-in');
        adminUI.style.display = 'block';
        document.addEventListener('keydown', onKeyDown);
    }
});

document.getElementById('full-blackout').addEventListener('change', function() {
    const fullBlackout = document.getElementById('full-blackout').checked;

    fetch(`https://${GetParentResourceName()}/updateBlackout`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            fullBlackout: fullBlackout
        })
    });
});

function onKeyDown(e) {
    if (e.key === 'Escape') {
        const adminUI = document.getElementById('admin-ui');
        adminUI.classList.remove('fade-in');
        adminUI.classList.add('fade-out');
        setTimeout(() => {
            adminUI.style.display = 'none';
            fetch(`https://${GetParentResourceName()}/closeAdminUI`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        }, 500); 
        document.removeEventListener('keydown', onKeyDown);
    }
}


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