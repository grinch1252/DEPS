json.array!(@events) do |event|
  json.extract! event, :id, :title, :body
  json.start event.start
  json.url event_url(event, :format => :html)
end