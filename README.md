SplitLogger
===========

SplitLogger is a simple subclass of the ruby Logger class designed to allow you to split certain log levels off to their own output.

Usage
-----------

Simply require SplitLogger, initialize a new SplitLogger object as you would for Logger, set one additional option, and watch your multiple logs grow.

** Your ruby file **
	require 'split_logger'
	log = SplitLogger.new("mylog.log")
	log.level = Logger::ERROR
	log.logs = {
		"debug.log" => Logger::DEBUG
	}

Logging for all log levels not explicitly defined falls back to the default log level setting and output destination.

The logs attribute is a hash of output => level(s)

You can set multiple log levels to write to the same output simply by passing an array of levels as the value...
	
	log.logs = {
		"info.log" => [Logger::DEBUG, Logger::INFO]
	}
	
Please, if you can clean up my code in any way fork it, mess with it, show me patches. I don't plan on maintaining this one much unless there are obvious flaws. Hope you enjoy!