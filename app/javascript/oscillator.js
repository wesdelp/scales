import * as Tone from 'tone'

var monoSynth = null
var polySynth = null
var sequence = null
var bpm = 80

function getMonoSynth() {
    if (!monoSynth) {
        monoSynth = new Tone.Synth().toDestination()
    }

    return monoSynth
}

function getPolySynth() {
    if (!polySynth) {
        polySynth = new Tone.PolySynth().toDestination()
    }

    return polySynth
}

function playScale(notes) {
    const now = Tone.now()

    if (sequence) {
        sequence.dispose()
    }

    var measures = Math.ceil(notes.length / 8)

    sequence = new Tone.Sequence(((time, note) => {
        getMonoSynth().triggerAttackRelease(note, 0.1, time)
    }), notes, "8n").start(0)

    startPlaying(measures)
}

function playChords(chords) {
    const now = Tone.now()

    if (sequence) {
        sequence.dispose()
    }

    var measures = Math.ceil(chords.length / 2)

    var progression = chords.map(function (chord, i) {
        var measure = Math.floor(i / 2)
        var beat = (i % 2) * 2
        var time = `${measure}:${beat}`

        return [time, chord]
    })

    sequence = new Tone.Part(((time, chord) => {
        getPolySynth().triggerAttackRelease(chord, "2n", time);
    }), progression).start(0)

    startPlaying(measures)
}

function startPlaying(measures) {
    if (!sequence) {
        return
    }

    sequence.loop = false
    Tone.Transport.bpm.value = bpm

    Tone.Transport.start("+0.1")
    Tone.Transport.stop(`+${measures}m`)
}

function stopPlaying() {
    Tone.Transport.stop()
    Tone.Transport.cancel(0)
}

function handlePlayScalePressed(notes) {
    if (Tone.Transport.state == 'started') {
        stopPlaying()
    } else {
        playScale(notes)
    }
}

function handlePlayChordsPressed(chords) {
    if (Tone.Transport.state == 'started') {
        stopPlaying()
    } else {
        playChords(chords)
    }
}

function setUp() {
    var scaleButton = document.querySelector('.scaleButton')

    scaleButton.addEventListener('click', async (e) => {
        var notes = JSON.parse(scaleButton.dataset.notes)

        await Tone.start()
        handlePlayScalePressed(notes)
    })

    var chordsButtons = document.querySelectorAll('.chordsButton')

    chordsButtons.forEach(function(chordsButton) {
        chordsButton.addEventListener('click', async (e) => {
            var chords = JSON.parse(chordsButton.dataset.chords)

            await Tone.start()
            handlePlayChordsPressed(chords)
        })
    })
}

async function tearDown() {
    stopPlaying()

    if (monoSynth) {
        monoSynth.dispose()
        monoSynth = null
    }

    if (polySynth) {
        polySynth.dispose()
        polySynth = null
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
