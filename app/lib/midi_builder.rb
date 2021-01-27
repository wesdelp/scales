require 'midilib/sequence'
require 'midilib/consts'
include MIDI

class MidiBuilder
  DEFAULT_NOTE_LENGTH = 'whole'
  DEFAULT_BPM = 120
  BASE_NOTE = 60 # MIDI value for middle C

  def self.build_progression(root, type, progression)
    new(root, type).build_progression(progression)
  end

  def initialize(root, type)
    @root = root
    @type = type
  end

  def build_progression(progression)
    progression = scale_progressions[progression]
    chords_notes = progression.map { |chord| chord[:notes] }

    generate_midi(chords_notes)
  end

  private

  def scale_progressions
    @scale_progressions ||= ScaleBuilder.build(@root, @type)[:progressions]
  end

  def generate_midi(chords_notes)
    track = create_track

    note_length = sequence.note_to_delta(DEFAULT_NOTE_LENGTH)

    chords_notes.each do |chord|
      chord.each_with_index do |offset, i|
        track.events << NoteOn.new(0, BASE_NOTE + offset, 127, 0)
      end

      chord.each_with_index do |offset, i|
        track.events << NoteOff.new(
          0,
          BASE_NOTE + offset,
          127, note_length - (note_length * i)
        )
      end
    end

    midi_data = StringIO.new
    sequence.write(midi_data)

    midi_data.string
  end

  def sequence
    @sequence ||= Sequence.new
  end

  def create_track
    track = Track.new(sequence)
    sequence.tracks << track

    track.events << Tempo.new(Tempo.bpm_to_mpq(DEFAULT_BPM))
    track.events << MetaEvent.new(META_SEQ_NAME, 'Scales')

    track.instrument = GM_PATCH_NAMES[0]
    track.events << Controller.new(0, CC_VOLUME, 127)

    track
  end
end
