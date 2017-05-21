module Herd
  class Cluster
    # The current thread
    @@thread = 0

    # The number of threads to run
    @threads : Int32 = 1

    # Return the current thread
    def self.thread
      @@thread
    end

    # Create the cluster
    def initialize(@threads : Int32)
    end

    # Specify a block to execute `@threads` times
    def execute(&block)
      if @threads > 1 && is_master
        # Fork the current process to create the required number of threads
        @threads.times do |i|
          fork({"i" => i.to_s})
        end
        sleep
      else
        @@thread = ENV["i"].to_i32

        # Since we are not on the master thread, execute the block
        block.call
      end
    end

    # Fork the current process
    def fork(env : Hash)
      env["FORKED"] = "1"
      return Process.fork { Process.run(PROGRAM_NAME, nil, env, true, false, true, true, true, nil) }
    end

    # Check if the current process is the master
    def is_master
      (ENV["FORKED"] ||= "0") == "0"
    end

    # Check if the current process is a slave
    def is_slave
      (ENV["FORKED"] ||= "0") == "1"
    end
  end
end
