var context = null;
var oscillator = null;
function getOrCreateContext() {
    if (!context) {
        context = new webkitAudioContext();
        oscillator = context.createOscillator();
        oscillator.connect(context.destination);
    }
    return context;

}

var isStarted = false;
function playSound(frequency, type) {
    console.log(frequency)
    getOrCreateContext();
    oscillator.frequency.setTargetAtTime(frequency, context.currentTime, 0);
    if (!isStarted) {
        oscillator.start(0);
        isStarted = true;
    } else {
        context.resume();
    }
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function playScale(notes) {

    for (var index = 0; index < notes.length; index++) {
        playSound(notes[index], 'square');
        await sleep(500);
    }

    stopSound();
}

function stopSound() {
    context.suspend();
}

document.addEventListener("DOMContentLoaded", function(){
    var scaleButton = document.getElementById('scaleButton');
    scaleButton.addEventListener('click', (e) => {
      var notes = JSON.parse(scaleButton.dataset.notes);
      console.log(notes);
      playScale(notes);
    })
});
