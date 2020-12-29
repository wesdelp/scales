import * as Tone from 'tone'

var synth = null
var sequence = null
var bpm = 60

function getOrCreateSynth() {
    if (!synth) {
        synth = new Tone.Synth().toDestination()
    }

    return synth
}

function playScale(notes) {
    const now = Tone.now()

    if (sequence) {
        sequence.dispose()
    }

    sequence = new Tone.Sequence(((time, note) => {
        getOrCreateSynth().triggerAttackRelease(note, 0.1, time)
    }), notes, "8n").start(0)

    sequence.loop = false
    Tone.Transport.bpm.value = bpm

    Tone.Transport.start("+0.1")
    Tone.Transport.stop("+1m")
}

function stopPlaying() {
    Tone.Transport.stop()
    Tone.Transport.cancel(0)
}

function handleButtonPressed(notes) {
    if (Tone.Transport.state == 'started') {
        stopPlaying()
    } else {
        playScale(notes)
    }
}

function setUp() {
    var scaleButton = document.getElementById('scaleButton')

    scaleButton.addEventListener('click', async (e) => {
        var notes = JSON.parse(scaleButton.dataset.notes)

        await Tone.start()
        handleButtonPressed(notes)
    })
}

async function tearDown() {
    stopPlaying()

    if (synth) {
        synth.dispose()
        synth = null
    }

    if (sequence) {
        sequence.dispose()
        sequence = null
    }
}

document.addEventListener('turbolinks:before-render', () => {
    tearDown();
});

document.addEventListener('turbolinks:load', () =>
    setUp(),
    {
        once: true,
    },
);

document.addEventListener('turbolinks:render', () =>
    setUp(),
);
