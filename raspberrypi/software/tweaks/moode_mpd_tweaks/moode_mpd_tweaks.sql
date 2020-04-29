-- Add database suport for Moode MPD tweaks
-- Use:
--   sqlite3 /var/local/www/db/moode-sqlite3.db < mpd_tweaks.sql

-- If don't exist already, add configuration parameter to the database. All default values are safe and will no change anything
-- INSERT OR IGNORE INTO cfg_mpd  VALUES ((select id from cfg_mpd where param="auto_format"),"auto_format", "0");
-- INSERT OR IGNORE INTO cfg_mpd  VALUES ((select id from cfg_mpd where param="auto_resample"),"auto_resample", "0");
INSERT OR IGNORE INTO cfg_mpd  VALUES ((select id from cfg_mpd where param="mpd_tweaks"),"mpd_tweaks", "0");
INSERT OR IGNORE INTO cfg_mpd  VALUES ((select id from cfg_mpd where param="mpd_tweaks_unlock"),"mpd_tweaks_unlock", "0");
INSERT OR IGNORE INTO cfg_mpd  VALUES ((select id from cfg_mpd where param="mpd_extra_params"),"mpd_extra_params", "");
INSERT OR IGNORE INTO cfg_mpd  VALUES ((select id from cfg_mpd where param="mpd_dev_extra_params"),"mpd_dev_extra_params", "");

-- To enable the user interface to support mpd_tweaks we have to unlock it, by the following query:
-- UPDATE cfg_mpd  SET value="1" where param="mpd_tweaks_unlock";
-- from command line
-- sqlite3 /var/local/www/db/moode-sqlite3.db 'UPDATE cfg_mpd  SET value="1" where param="mpd_tweaks_unlock";'

