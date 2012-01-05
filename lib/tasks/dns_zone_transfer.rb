	require 'dnsruby'

	def name
		"dns_zone_transfer"
	end

	## Returns a string which describes what this task does
	def description
		"DNS Zone Tranfer"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Host, Domain]
	end
	
	def setup(object, options={})
		super(object, options)
	end

	def run
		super

		# Get the authoritative nameservers & query each of them
		answer = Whois::Client.new.query(@object.name)
		resolved_list = nil

		# For each authoritive nameserver
		answer.nameservers.each do |nameserver|
			begin
		

				@task_logger.log "Attempting Zone Transfer on #{@object} against nameserver #{nameserver}"
				res = Dnsruby::Resolver.new(
					:nameserver => nameserver.to_s, 
					:recurse => true, 
					:use_tcp => true, 
					:query_timeout => 5)

				res_answer = res.query(@object.name, Dnsruby::Types.AXFR)

				# If we got a success to the AXFR query.
				if res_answer

					# Do the actual zone transfer
					zt = Dnsruby::ZoneTransfer.new
					zt.transfer_type = Dnsruby::Types.AXFR
					zt.server = nameserver
					zone = zt.transfer(@object.name)

					# Record keeping
					@task_logger.log_good "Zone Tranfer Succeeded on #{@object.name}"
					@object.records << Record.create({:name => "dns_zone_transfer", :content => {:server => nameserver, :zone => zone.to_s}})
				end

			rescue Dnsruby::Refused
				@task_logger.log "Zone Transfer against #{@object.name} refused."

			rescue Dnsruby::ResolvError
				@task_logger.log "Unable to resolve #{@object.name} while querying #{nameserver}."

			rescue Dnsruby::ResolvTimeout
				@task_logger.log "Timed out while querying #{nameserver} for #{@object.name}."

			rescue Exception => e
				@task_logger.log "Unknown exception: #{e}"

			end

		end
	end

	def cleanup
		super
	end
