class ScaleBuilder
  def self.build(root, type)
    case type.to_sym
    when :major
      MajorScale.for(root)
    when :minor
      MinorScale.for(root)
    else
      raise 'Scale type not implemented'
    end
  end
end
