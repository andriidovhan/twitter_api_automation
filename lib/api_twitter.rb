require './lib/helpers/api_client'

class ApiTwitter
  include ApiClient

  attr_reader :interface, :id, :id_str, :text, :truncated, :in_reply_to_status_id, :in_reply_to_status_id_str,
              :in_reply_to_user_id, :in_reply_to_user_id_str, :in_reply_to_screen_name, :source, :created_at,
              :retweet_count

  def attrs_update(id)
    attrs ||= conn.status("#{id}").attrs
    attrs.each { |k,v| instance_variable_set("@#{k}", v) }

    self
  end

  def update(text)
    attrs_update(conn.update(text).id)
  end
end

