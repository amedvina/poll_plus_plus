class PollChannel < ApplicationCable::Channel
  def subscribed
    stream_from "broadcast_stream"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
