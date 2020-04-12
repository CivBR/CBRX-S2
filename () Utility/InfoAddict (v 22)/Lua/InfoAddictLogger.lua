-- Event Logger
-- Author: Thalassicus
--   (with modifications by robk adding TRACE level and logging
--    to a database table)
------------------------------------------------------------

TRACE = "TRACE"
DEBUG = "DEBUG"
INFO = "INFO"
WARN = "WARN"
ERROR = "ERROR"
FATAL = "FATAL"

local LEVEL = {
  [TRACE] = 1,
	[DEBUG] = 2,
	[INFO]  = 3,
	[WARN]  = 4,
	[ERROR] = 5,
	[FATAL] = 6,
}

LoggerType = {};

function LoggerType:new()
	local logger = {};
	setmetatable(logger, self);
	self.__index = self;

	logger.level = LEVEL.INFO;
  logger.db = Modding.OpenSaveData();

	logger.setLevel = function (self, level)
		self.level = level;
	end

	logger.log = function (self, level, message)

		-- INFO gets logged to the table regardless of the console log level but only if the
    -- Logging table is ready.

    if (LEVEL[level] >= LEVEL[INFO] and 
        MapModData.InfoAddict.LogTableExists == true and
        logger.db ~= nil)
    then
      local insert = 'INSERT INTO InfoAddictLog("Timestamp", "Level", "Message") ' .. 
                     'VALUES(' .. os.time() ..',"' .. level .. '","' .. message .. '")';
      for row in logger.db.Query(insert) do end;
    end

    if LEVEL[level] < LEVEL[self.level] then
			return false;
		end
		print(level .. ":  " .. message);
		return true;
	end

  logger.trace = function (logger, message) return logger:log(TRACE, message) end
	logger.debug = function (logger, message) return logger:log(DEBUG, message) end
	logger.info  = function (logger, message) return logger:log(INFO,  message) end
	logger.warn  = function (logger, message) return logger:log(WARN,  message) end
	logger.error = function (logger, message) return logger:log(ERROR, message) end
	logger.fatal = function (logger, message) return logger:log(FATAL, message) end
	return logger;
end