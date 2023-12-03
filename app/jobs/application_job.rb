class ApplicationJob < ActiveJob::Base
  # Automatically retry poll_winners that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most poll_winners are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
