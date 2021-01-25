class X

  def do_stuff
    # code here
  end
end

class Formats
  def self.log_for_file(msg)
    "#{Time.now}: #{System}-#{Module} ERROR #{truncate(msg, 80)}"
  end
end

class DiagError < StandardError
  def initialize(msg="")
    super
  end
end

class TargetClass
  def ugly_method
    # stuff a
    # ...

    # stuff b
    # ...

    # some smaller behavior
    x = X.new
    x.do_stuff

    # stuff c
    # ...
  end

  def do_diag_op
    raise DiagError.new("because")
  end

  def log(msg)
    puts(msg)
  end

  System = "ABC-Orders"
  Module = "PrintMod"

  def handle_something
    begin
      do_diag_op
    rescue DiagError => e
      errMsg = "#{Time.now}: #{System}-#{Module} ERROR #{e.msg.truncate(80)}"
      log(errMsg)
      raise StandardError.new(errMsg)
    end
  end

  def handle_something_else
    begin
      do_diag_op
    rescue DiagError => e
      errMsg = formatted_error_message(e)
      log(errMsg)
      raise StandardError.new(errMsg)
    end
  end

  def handle_with_function_argument
    begin
      do_diag_op
    rescue DiagError => e
      log_and_reraise(e.message, Formats.method(:log_for_file))
    end
  end

  def log_and_reraise(message, format_fn)
    err_msg = format_fn.call(message)
    log(err_msg)
    raise StandardError.new(err_msg)
  end


  def log_to_console(msg)
    "#{Time.now}: #{System}-#{Module} ERROR #{msg}"
  end

  private

  def truncate(string, max)
    string.length > max ? "#{string[0...max]}..." : string
  end

  def formatted_error_message(e)
    "#{Time.now}: #{System}-#{Module} ERROR #{e.msg.truncate(80)}"
  end
end

class TargetClassRefactored
  def ugly_method
    # stuff a
    # ...

    # stuff b
    # ...

    do_some_smaller_behavior

    # stuff c
    # ...
  end

  def do_some_smaller_behavior
    x = X.new
    x.do_stuff
  end
end

class ProductionAuditor
  def log(msg)
    raise NotImplementedError
  end
end

class Dictionary
  attr_accessor :auditor
  def initialize
    @definitions = Hash.new
    @auditor = ProductionAuditor.new
  end

  def add(word, definition)
    @definitions[word] = definition
    @auditor.log("added to dictionary")

  end
  def definition(word)
    @definitions[word]
  end
end