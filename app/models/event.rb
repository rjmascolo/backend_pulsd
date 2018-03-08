class Event < ApplicationRecord

  EVENTBRITE_URL = 'https://www.eventbriteapi.com/v3/events/'

  def self.syndicate_events
    current_time = Time.now.in_time_zone
    recently_added_events = Event.where('created_at BETWEEN ? AND ?', (current_time - 1.hour), current_time)
    recently_added_events.each{ |event| Event.eventbrite_post_event(event) }
  end

  def self.eventbrite_post_event(event)
      payload = {
        'event.name.html' => event.name,
        'event.description.html' => event.description,
        'event.start.utc' => event.start_date.iso8601,
        'event.start.timezone' => "America/New_York",
        'event.end.utc' => event.end_date.iso8601,
        'event.end.timezone' => "America/New_York",
        'event.currency' => 'USD'
      }
      begin
        response = RestClient.post(
          EVENTBRITE_URL,
          payload,
          headers = { Authorization: "Bearer " + ENV["Eventbrite_Personal_Outh"] }
        )
      rescue RestClient::ExceptionWithResponse => err
        puts err.response
      end
      event["eventbrite_url"] = JSON.parse(response.body)['url']
  end

end
