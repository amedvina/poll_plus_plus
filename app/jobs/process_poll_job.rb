class ProcessPollJob < ApplicationJob
  queue_as :default

  def perform(poll_id)
    poll = Poll.find(poll_id)
    return if poll.processed

    poll.update(processed: true)
  end
end
