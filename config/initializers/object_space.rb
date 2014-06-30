require 'csv'

class CSVMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def test(file_path)
    file = File.read file_path
    attachments[file_path.to_s] = file
    mail(to: 'stuart@neo.com', subject: "Data: #{file_path.to_s}") do |f|
      f.text { render text: 'DATA WAT' }
    end.deliver
  end
end

class GatherDatar
  def initialize
    gather_data
  end

  def gather_data
    Thread.new do
      # Give app time to boot before collecting data.
      sleep 30
      # Execute a full GC before collecting data.
      GC.start
      file_name = "#{Time.now.iso8601}-object-space.csv"
      CSV.open(Rails.root.join(file_name), "wb") do |csv|
        # Write CSV headers.
        csv << [:TIME, :TOTAL, :FREE, :T_OBJECT, :T_CLASS, :T_MODULE, :T_FLOAT,
                :T_STRING, :T_REGEXP, :T_ARRAY, :T_HASH, :T_STRUCT,
                :T_BIGNUM, :T_FILE, :T_DATA, :T_MATCH, :T_COMPLEX,
                :T_RATIONAL, :T_NODE, :T_ICLASS]
        time = 0
        time_increment = 30
        100.times do
          # Write current values.
          values = [time] + ObjectSpace.count_objects.values
          time += time_increment
          puts "Writing current object space status:"
          puts values.to_s
          csv << values
          sleep time_increment
        end
        puts "Done collecting values."
      end
      CSVMailer.test(Rails.root.join(file_name))
    end

    Thread.new do
      # Give app time to boot before collecting data.
      sleep 30
      # Execute a full GC before collecting data.
      GC.start
      file_name = "#{Time.now.iso8601}-gc-stat.csv"
      CSV.open(Rails.root.join(file_name), "wb") do |csv|
        # Write CSV headers.
        csv << [:time, :count, :heap_used, :heap_length, :heap_increment, :heap_live_slot,
                :heap_free_slot, :heap_final_slot, :heap_swept_slot,
                :heap_eden_page_length, :heap_tomb_page_length,
                :total_allocated_object, :total_freed_object, :malloc_increase,
                :malloc_limit, :minor_gc_count, :major_gc_count,
                :remembered_shady_object, :remembered_shady_object_limit,
                :old_object, :old_object_limit, :oldmalloc_increase,
                :oldmalloc_limit]

        time = 0
        time_increment = 30
        100.times do
          # Write current values.
          values = [time] + GC.stat.values
          time += time_increment
          puts "Writing current GC.stat status:"
          puts values.to_s
          csv << values
          sleep time_increment
        end
        puts "Done collecting values."
      end
      CSVMailer.test(Rails.root.join(file_name))
    end
  end
end
