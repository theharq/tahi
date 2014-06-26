require 'csv'

Thread.new do
  # Give app time to boot before collecting data.
  sleep 30
  # Execute a full GC before collecting data.
  GC.start
  file_name = "#{Time.now.iso8601}-object-space.csv"
  CSV.open(Rails.root.join(file_name), "wb") do |csv|
    # Write CSV headers.
    csv << [:TOTAL, :FREE, :T_OBJECT, :T_CLASS, :T_MODULE, :T_FLOAT,
            :T_STRING, :T_REGEXP, :T_ARRAY, :T_HASH, :T_STRUCT,
            :T_BIGNUM, :T_FILE, :T_DATA, :T_MATCH, :T_COMPLEX,
            :T_RATIONAL, :T_NODE, :T_ICLASS]
    100.times do
      # Write current values.
      values = ObjectSpace.count_objects.values
      puts "Writing current object space status:"
      puts values.to_s
      csv << values
      sleep 30
    end
    puts "Done collecting values."
  end
end
