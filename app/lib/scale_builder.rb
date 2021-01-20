class ScaleBuilder
  def self.build(root, type)
    case type.to_sym
    when :major
      MajorScale.for(root)
    when :minor
      MinorScale.for(root)
    when :melodic_minor
      MelodicMinorScale.for(root)
    when :harmonic_minor
      HarmonicMinorScale.for(root)
    when :major_locrian
      MajorLocrianScale.for(root)
    when :major_double_harmonic
      MajorDoubleHarmonicScale.for(root)
    else
      raise 'Scale type not implemented'
    end
  end
end
