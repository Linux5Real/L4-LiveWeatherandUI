[Ger] So änderst du die Anordnung im UI mit ein paar Schritten

1. Gehe in die Datei `ui.html` (sie ist im `html` Ordner).

2. Suche nach dem Text:

html
<body>
    <div id="ui">
        <div id="city" class="info"></div> 
        <div id="separator" class="info">|</div>
        <div id="time" class="info"></div>
        <div id="separator" class="info">|</div>
        <div id="weather" class="info">
            <i id="weather-icon" class="fas"></i>
            <span id="weather-text"></span>
        </div>
        <div id="separator" class="info">|</div>
        <div id="date" class="info"></div>
    </div>
    <script src="script.js"></script>
</body>
</html>

3. Als Beispiel ändern wir mal die Stadt mit der Uhrzeit. Dann schreibt ihr im city Feld time rein und im time Feld city rein. So sollte es aussehen

<body>
    <div id="ui">
        <div id="time" class="info"></div> 
        <div id="separator" class="info">|</div>
        <div id="city" class="info"></div>
        <div id="separator" class="info">|</div>
        <div id="weather" class="info">
            <i id="weather-icon" class="fas"></i>
            <span id="weather-text"></span>
        </div>
        <div id="separator" class="info">|</div>
        <div id="date" class="info"></div>
    </div>
    <script src="script.js"></script>
</body>
</html>

4. Das war's auch schon. Ihr startet nun einmal L4-RealWeatherandUI neu und fertig ist es. Ihr könnt das mit jedem Wert ändern, also time, city, weather und date. Zwei Dinge müsst ihr nur beachten: Wenn ihr das weather verschieben wollt, müsst ihr die drei Teile vom weather verschieben, damit alles passt. Das andere sind die separator Striche. Diese sind die Striche, um die jeweiligen Felder zu trennen, also an denen nichts ändern.

[ENG] How to change the arrangement in the UI with a few steps

1. Go to the file ui.html (it is in the html folder).

2. Look for the text

<body>
    <div id="ui">
        <div id="city" class="info"></div> 
        <div id="separator" class="info">|</div>
        <div id="time" class="info"></div>
        <div id="separator" class="info">|</div>
        <div id="weather" class="info">
            <i id="weather-icon" class="fas"></i>
            <span id="weather-text"></span>
        </div>
        <div id="separator" class="info">|</div>
        <div id="date" class="info"></div>
    </div>
    <script src="script.js"></script>
</body>
</html>

3. As an example, let's swap the city with the time. Then, write time in the city field and city in the time field. It should look like this:

<body>
    <div id="ui">
        <div id="time" class="info"></div> 
        <div id="separator" class="info">|</div>
        <div id="city" class="info"></div>
        <div id="separator" class="info">|</div>
        <div id="weather" class="info">
            <i id="weather-icon" class="fas"></i>
            <span id="weather-text"></span>
        </div>
        <div id="separator" class="info">|</div>
        <div id="date" class="info"></div>
    </div>
    <script src="script.js"></script>
</body>
</html>

4. That's it. Now restart L4-RealWeatherandUI once and it's done. You can change this with any value, such as time, city, weather, and date. Just keep two things in mind: If you want to move the weather, you need to move the three parts of the weather to make everything fit. The other thing is the separator lines. These are the lines to separate the respective fields, so don't change them.