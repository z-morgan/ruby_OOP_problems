class Banner

  def initialize(message, set_width = nil)
    @message = message
    @set_width = set_width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :message, :set_width

  def width
    message.size + 2
  end

  def horizontal_rule
    "+#{add_filler('-')}+"
  end

  def empty_line
    "|#{add_filler(' ')}|"
  end

  def message_line
    if set_width == nil
      "| #{message} |"
    else
      "|" + add_spaces + "#{message}" + add_spaces + "|"
    end
  end

  def add_filler(character)
    if set_width == nil
      character * width
    else
      character * set_width
    end
  end

  def add_spaces
    ' ' * ((set_width - message.size) / 2)
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 46)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+