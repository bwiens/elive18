# elive18

Some files for the presentation "Developing and Auditing Web Applications that Feed into Banner Finance" 

Files:

BANNER_UTIL.sql       -- collection of functions + source code that return Banner data (package spec and body)

XMCGURF_PROCESS.sql   -- Emails the contents of xmcgurf, processes the records, archives them, and emails any records that would not                                process. Processing is accomplished by calling xmcgurfeed

XMCGURFEED.sql	      -- Processes records in the XMCGURF table and depending on hyphen "-" puts them into AR system (when charging a                              person, 7-digit ID) or GURFEED: Banner Finance (when containing a hyphen)

XMCGURF_TABLE.sql     -- Staging table for the XMCGURF process, which sweeps into the GURFEED table (Banner Finance)
