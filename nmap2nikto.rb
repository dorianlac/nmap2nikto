#!/usr/bin/env ruby

require 'nokogiri'

@doc = Nokogiri::XML(File.open(ARGV[0]));

nmap = @doc.xpath("//host");

puts "#!/bin/sh"

a=1
nmap.each {|x|

x.xpath('address').each { |host|
	x.xpath('./ports/port').each { |port|
			
	if port['protocol'].eql? "tcp";

		port.xpath('./state').each {|state|

		if state['state'].eql? "open";
			
			port.xpath('./service').each {|service|
			if service['name'].eql? 'http';
				if service['tunnel'].eql? 'ssl';
				print "nikto -h https://";
				print host['addr'];
				print ":";
				print port['portid'];
				print " -C all -o "
				puts "https_" + host['addr'] + "_" + port['portid']+".txt";
				
				else
				print "nikto -h http://";
                                print host['addr'];
                                print ":";
                                print port['portid'];
                                print " -C all -o "
                                puts "http_" + host['addr'] + "_" + port['portid']+".txt";
				
			end
 
			elsif service['name'].eql? 'https';
				print "nikto -h https://";
                                print host['addr'];
                                print ":";
                                print port['portid'];
                                print " -C all -o "
                                puts "https_" + host['addr'] + "_" + port['portid']+".txt";

			end
			}		
		end
		}
	end
	}
#end
}

a=a+1
}
