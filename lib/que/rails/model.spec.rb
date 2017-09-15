# frozen_string_literal: true

require 'spec_helper'

if defined?(::ActiveRecord)
  describe Que::ActiveRecord::Model do
    it "should be able to load, modify and update jobs" do
      job_attrs = Que::Job.enqueue.que_attrs

      job = Que::ActiveRecord::Model.find(job_attrs[:id])

      assert_instance_of Que::ActiveRecord::Model, job
      assert_equal job_attrs[:id], job.id

      assert_equal "default", job.queue
      job.update queue: "custom_queue"

      assert_equal "custom_queue", DB[:que_jobs].get(:queue)
    end
  end
end
