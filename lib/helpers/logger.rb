module Log
  extend self

  ERR = "\e[1;31m"
  CLEAR = "\e[0m"

  def error(message)
    write formatted_message(message, "ERR")
    raise message
  end

  def info(message)
    write formatted_message(message, "INFO")
  end

  private

  def write(formatted_message)
    log_file = ENV['LOG_FILE'] || 'autotests'
    File.open("log/#{log_file}.log", "a") { |f| f << formatted_message }
    formatted_message
  end

  def formatted_message(message, message_type)
    output = if message_type == "ERR"
               "#{Time.now} | #{message_type}: #{message}\n".red
             else
               "#{Time.now} | #{message_type}: #{message}\n".green
             end
    puts output

    if message_type == "ERR"
      ERR + output + CLEAR
    else
      output
    end
  end
end
