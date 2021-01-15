class MinorScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Minor'
  end

  def pentatonic_steps
    [0, 2, 3, 4, 6]
  end

  def intervals
    [
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      # whole step back to root
    ]
  end

  def scale_chords
    {
      'i' => CHORD_QUALITIES[:minor],
      'ii°' => CHORD_QUALITIES[:diminished],
      'III' => CHORD_QUALITIES[:major],
      'iv' => CHORD_QUALITIES[:minor],
      'v' => CHORD_QUALITIES[:minor],
      'VI' => CHORD_QUALITIES[:major],
      'VII' => CHORD_QUALITIES[:major]
    }
  end

  def common_progressions
    [
      [ 0, 5, 6 ],
      [ 0, 3, 6 ],
      [ 0, 3, 4 ],
      [ 0, 5, 2, 6 ],
      [ 0, 3, 4, 0 ],
      [ 5, 6, 0, 0 ],
      [ 0, 6, 5, 6 ],
      [ 0, 3, 0 ]
    ]
  end
end
