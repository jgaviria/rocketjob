require_relative '../../test_helper'

module Plugins
  module Job
    # Unit Test for RocketJob::Job
    class ModelTest < Minitest::Test
      class SimpleJob < RocketJob::Job
        def perform
          10
        end
      end

      class TwoArgumentJob < RocketJob::Job
        rocket_job do |job|
          job.priority = 53
        end

        def perform(a, b)
          a + b
        end
      end

      describe RocketJob::Plugins::Job::Model do
        after do
          @job.destroy if @job && !@job.new_record?
          @job2.destroy if @job2 && !@job2.new_record?
          @job3.destroy if @job3 && !@job3.new_record?
        end

        describe '#scheduled?' do
          it 'returns true if job is queued to run in the future' do
            @job = SimpleJob.new(run_at: 1.day.from_now)
            assert @job.queued?
            assert @job.scheduled?
            @job.start
            assert @job.running?
            refute @job.scheduled?
          end

          it 'returns false if job is queued and can be run now' do
            @job = SimpleJob.new
            assert @job.queued?
            refute @job.scheduled?
          end

          it 'returns false if job is running' do
            @job = SimpleJob.new
            @job.start
            assert @job.running?
            refute @job.scheduled?
          end
        end

        describe 'with queued jobs' do
          before do
            @job  = SimpleJob.create!(description: 'first')
            @job2 = SimpleJob.create!(description: 'second', run_at: 1.day.from_now)
            @job3 = SimpleJob.create!(description: 'third', run_at: 2.days.from_now)
          end

          describe '#scheduled' do
            it 'returns only scheduled jobs' do
              count = 0
              RocketJob::Job.scheduled.each do |job|
                count += 1
                assert job.scheduled?
              end
              assert 2, count
            end
          end

          describe '#queued_now' do
            it 'returns only queued jobs, not scheduled ones' do
              count = 0
              RocketJob::Job.queued_now.each do |job|
                count += 1
                refute job.scheduled?
              end
              assert 1, count
            end
          end

          describe '#queued' do
            it 'returns all queued jobs' do
              count = 0
              RocketJob::Job.queued.each do |job|
                count += 1
              end
              assert 3, count
            end
          end
        end

      end
    end
  end
end