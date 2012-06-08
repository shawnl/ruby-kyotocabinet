#--
# Ruby binding of Kyoto Cabinet
#                                                                 Copyright (C) 2009-2010 FAL Labs
#  This file is part of Kyoto Cabinet.
#  This program is free software: you can redistribute it and/or modify it under the terms of
#  the GNU General Public License as published by the Free Software Foundation, either version
#  3 of the License, or any later version.
#  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
#  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  See the GNU General Public License for more details.
#  You should have received a copy of the GNU General Public License along with this program.
#  If not, see <http://www.gnu.org/licenses/>.
#++
#:include:overview.rd


# Namespace of Kyoto Cabinet.
module KyotoCabinet
  # The version information
  VERSION = "x.y.z"
  # Convert any object to a string.
  # @param obj the object.
  # @return the result string.
  def conv_str(obj)
    # (native code)
  end
  # Convert a string to an integer.
  # @param str the string.
  # @return the integer.  If the string does not contain numeric expression, 0 is returned.
  def atoi(str)
    # (native code)
  end
  # Convert a string with a metric prefix to an integer.
  # @param str the string, which can be trailed by a binary metric prefix.  "K", "M", "G", "T", "P", and "E" are supported.  They are case-insensitive.
  # @return the integer.  If the string does not contain numeric expression, 0 is returned.  If the integer overflows the domain, INT64_MAX or INT64_MIN is returned according to the sign.
  def atoix(str)
    # (native code)
  end
  # Convert a string to a real number.
  # @param str the string.
  # @return the real number.  If the string does not contain numeric expression, 0.0 is returned.
  def atof(str)
    # (native code)
  end
  # Get the hash value of a string by MurMur hashing.
  # @param str the string.
  # @return the hash value.
  def hash_murmur(str)
    # (native code)
  end
  # Get the hash value of a string by FNV hashing.
  # @param str the string.
  # @return the hash value.
  def hash_fnv(str)
    # (native code)
  end
  # Calculate the levenshtein distance of two strings.
  # @param a one string.
  # @param b the other string.
  # @param utf flag to treat keys as UTF-8 strings.
  # @return the levenshtein distance.
  def levdist(a, b, utf)
    # (native code)
  end
  #
  # Error data.
  #
  class Error < RuntimeError
    # error code: success
    SUCCESS = 0
    # error code: not implemented
    NOIMPL = 1
    # error code: invalid operation
    INVALID = 2
    # error code: no repository
    NOREPOS = 3
    # error code: no permission
    NOPERM = 4
    # error code: broken file
    BROKEN = 5
    # error code: record duplication
    DUPREC = 6
    # error code: no record
    NOREC = 7
    # error code: logical inconsistency
    LOGIC = 8
    # error code: system error
    SYSTEM = 9
    # error code: miscellaneous error
    MISC = 15
    # Create an error object.
    # @param code the error code.
    # @param message the supplement message.
    # @return the error object.
    def initialize(code, message)
      # (native code)
    end
    # Set the error information.
    # @param code the error code.
    # @param message the supplement message.
    # @return always nil.
    def set(code, message)
      # (native code)
    end
    # Get the error code.
    # @return the error code.
    def code()
      # (native code)
    end
    # Get the readable string of the code.
    # @return the readable string of the code.
    def name()
      # (native code)
    end
    # Get the supplement message.
    # @return the supplement message.
    def message()
      # (native code)
    end
    # Get the string expression.
    # @return the string expression.
    def to_s()
      # (native code)
    end
    # Get the inspection string.
    # @return the inspection string.
    def inspect()
      # (native code)
    end
    # Equality operator.
    # @param right an error object or an error code.
    # @return true for the both operands are equal, or false if not.
    def ==(right)
      # (native code)
    end
    # Negation equality operator.
    # @param right an error object or an error code.
    # @return false for the both operands are equal, or true if not.
    def !=(right)
      # (native code)
    end
  end
  #
  # Interface to access a record.
  #
  class Visitor
    # magic data: no operation
    NOP = "(magic data)"
    # magic data: remove the record
    REMOVE = "(magic data)"
    # Visit a record.
    # @param key the key.
    # @param value the value.
    # @return If it is a string, the value is replaced by the content.  If it is Visitor::NOP, nothing is modified.  If it is Visitor::REMOVE, the record is removed.
    def visit_full(key, value)
      # (native code)
    end
    # Visit a empty record space.
    # @param key the key.
    # @return If it is a string, the value is replaced by the content.  If it is Visitor::NOP or Visitor::REMOVE, nothing is modified.
    def visit_empty(key)
      # (native code)
    end
  end
  #
  # Interface to process the database file.
  #
  class FileProcessor
    # Process the database file.
    # @param path the path of the database file.
    # @param count the number of records.
    # @param size the size of the available region.
    # @return true on success, or false on failure.
    def process(path, count, size)
      # (native code)
    end
  end
  #
  # Interface of cursor to indicate a record.
  #
  class Cursor
    # Disable the cursor.
    # @return always nil.
    # @note This method should be called explicitly when the cursor is no longer in use.
    def disable()
      # (native code)
    end
    # Accept a visitor to the current record.
    # @param visitor a visitor object which implements the Visitor interface.  If it is omitted, the block parameter is evaluated.
    # @param writable true for writable operation, or false for read-only operation.
    # @param step true to move the cursor to the next record, or false for no move.
    # @block If it is specified, the block is called as the visitor.
    # @return true on success, or false on failure.
    # @note The operation for each record is performed atomically and other threads accessing the same record are blocked.  To avoid deadlock, any explicit database operation must not be performed in this method.
    def accept(visitor, writable = true, step = false)
      # (native code)
    end
    # Set the value of the current record.
    # @param value the value.
    # @param step true to move the cursor to the next record, or false for no move.
    # @return true on success, or false on failure.
    def set_value(value, step = false)
      # (native code)
    end
    # Remove the current record.
    # @return true on success, or false on failure.
    # @note If no record corresponds to the key, false is returned.  The cursor is moved to the next record implicitly.
    def remove()
      # (native code)
    end
    # Get the key of the current record.
    # @param step true to move the cursor to the next record, or false for no move.
    # @return the key of the current record, or nil on failure.
    # @note If the cursor is invalidated, nil is returned.
    def get_key(step = false)
      # (native code)
    end
    # Get the value of the current record.
    # @param step true to move the cursor to the next record, or false for no move.
    # @return the value of the current record, or nil on failure.
    # @note If the cursor is invalidated, nil is returned.
    def get_value(step = false)
      # (native code)
    end
    # Get a pair of the key and the value of the current record.
    # @param step true to move the cursor to the next record, or false for no move.
    # @return a pair of the key and the value of the current record, or nil on failure.
    # @note If the cursor is invalidated, nil is returned.
    def get(step = false)
      # (native code)
    end
    # Get a pair of the key and the value of the current record and remove it atomically.
    # @return a pair of the key and the value of the current record, or nil on failure.
    # @note If the cursor is invalidated, nil is returned.  The cursor is moved to the next record implicitly.
    def seize()
      # (native code)
    end
    # Jump the cursor to a record for forward scan.
    # @param key the key of the destination record.  If it is nil, the destination is the first record.
    # @return true on success, or false on failure.
    def jump(key = nil)
      # (native code)
    end
    # Jump the cursor to a record for backward scan.
    # @param key the key of the destination record.  If it is nil, the destination is the last record.
    # @return true on success, or false on failure.
    # @note This method is dedicated to tree databases.  Some database types, especially hash databases, will provide a dummy implementation.
    def jump_back(key = nil)
      # (native code)
    end
    # Step the cursor to the next record.
    # @return true on success, or false on failure.
    def step()
      # (native code)
    end
    # Step the cursor to the previous record.
    # @return true on success, or false on failure.
    # @note This method is dedicated to tree databases.  Some database types, especially hash databases, may provide a dummy implementation.
    def step_back()
      # (native code)
    end
    # Get the database object.
    # @return the database object.
    def db()
      # (native code)
    end
    # Get the last happened error.
    # @return the last happened error.
    def error()
      # (native code)
    end
    # Get the string expression.
    # @return the string expression.
    def to_s()
      # (native code)
    end
    # Get the inspection string.
    # @return the inspection string.
    def inspect()
      # (native code)
    end
  end
  #
  # Interface of database abstraction.
  #
  class DB
    # generic mode: exceptional mode
    GEXCEPTIONAL = 1 << 0
    # generic mode: concurrent mode
    GCONCURRENT = 1 << 1
    # open mode: open as a reader
    OREADER = 1 << 0
    # open mode: open as a writer
    OWRITER = 1 << 1
    # open mode: writer creating
    OCREATE = 1 << 2
    # open mode: writer truncating
    OTRUNCATE = 1 << 3
    # open mode: auto transaction
    OAUTOTRAN = 1 << 4
    # open mode: auto synchronization
    OAUTOSYNC = 1 << 5
    # open mode: open without locking
    ONOLOCK = 1 << 6
    # open mode: lock without blocking
    OTRYLOCK = 1 << 7
    # open mode: open without auto repair
    ONOREPAIR = 1 << 8
    # merge mode: overwrite the existing value
    MSET = 0
    # merge mode: keep the existing value
    MADD = 1
    # merge mode: modify the existing record only
    MREPLACE = 2
    # merge mode: append the new value
    MAPPEND = 3
    # Create a database object.
    # @param opts the optional features by bitwise-or: DB::GEXCEPTIONAL for the exceptional mode, DB::GCONCURRENT for the concurrent mode.
    # @return the database object.
    # @note The exceptional mode means that fatal errors caused by methods are reported by exceptions raised.  The concurrent mode means that database operations by multiple threads are performed concurrently without the giant VM lock.  However, it has a side effect that such methods with call back of Ruby code as DB#accept, DB#accept_bulk, DB#iterate, DB#each, DB#each_key, DB#each_value, Cursor#accept are disabled.
    def initialize(opts = 0)
      # (native code)
    end
    # Get the last happened error.
    # @return the last happened error.
    def error()
      # (native code)
    end
    # Open a database file.
    # @param path the path of a database file.  If it is "-", the database will be a prototype hash database.  If it is "+", the database will be a prototype tree database.  If it is ":", the database will be a stash database.  If it is "*", the database will be a cache hash database.  If it is "%", the database will be a cache tree database.  If its suffix is ".kch", the database will be a file hash database.  If its suffix is ".kct", the database will be a file tree database.  If its suffix is ".kcd", the database will be a directory hash database.  If its suffix is ".kcf", the database will be a directory tree database.  If its suffix is ".kcx", the database will be a plain text database.  Otherwise, this function fails.  Tuning parameters can trail the name, separated by "#".  Each parameter is composed of the name and the value, separated by "=".  If the "type" parameter is specified, the database type is determined by the value in "-", "+", ":", "*", "%", "kch", "kct", "kcd", kcf", and "kcx".  All database types support the logging parameters of "log", "logkinds", and "logpx".  The prototype hash database and the prototype tree database do not support any other tuning parameter.  The stash database supports "bnum".  The cache hash database supports "opts", "bnum", "zcomp", "capcnt", "capsiz", and "zkey".  The cache tree database supports all parameters of the cache hash database except for capacity limitation, and supports "psiz", "rcomp", "pccap" in addition.  The file hash database supports "apow", "fpow", "opts", "bnum", "msiz", "dfunit", "zcomp", and "zkey".  The file tree database supports all parameters of the file hash database and "psiz", "rcomp", "pccap" in addition.  The directory hash database supports "opts", "zcomp", and "zkey".  The directory tree database supports all parameters of the directory hash database and "psiz", "rcomp", "pccap" in addition.  The plain text database does not support any other tuning parameter.
    # @param mode the connection mode.  DB::OWRITER as a writer, DB::OREADER as a reader.  The following may be added to the writer mode by bitwise-or: DB::OCREATE, which means it creates a new database if the file does not exist, DB::OTRUNCATE, which means it creates a new database regardless if the file exists, DB::OAUTOTRAN, which means each updating operation is performed in implicit transaction, DB::OAUTOSYNC, which means each updating operation is followed by implicit synchronization with the file system.  The following may be added to both of the reader mode and the writer mode by bitwise-or: DB::ONOLOCK, which means it opens the database file without file locking, DB::OTRYLOCK, which means locking is performed without blocking, DB::ONOREPAIR, which means the database file is not repaired implicitly even if file destruction is detected.
    # @return true on success, or false on failure.
    # @note The tuning parameter "log" is for the original "tune_logger" and the value specifies the path of the log file, or "-" for the standard output, or "+" for the standard error.  "logkinds" specifies kinds of logged messages and the value can be "debug", "info", "warn", or "error".  "logpx" specifies the prefix of each log message.  "opts" is for "tune_options" and the value can contain "s" for the small option, "l" for the linear option, and "c" for the compress option.  "bnum" corresponds to "tune_bucket".  "zcomp" is for "tune_compressor" and the value can be "zlib" for the ZLIB raw compressor, "def" for the ZLIB deflate compressor, "gz" for the ZLIB gzip compressor, "lzo" for the LZO compressor, "lzma" for the LZMA compressor, or "arc" for the Arcfour cipher.  "zkey" specifies the cipher key of the compressor.  "capcnt" is for "cap_count".  "capsiz" is for "cap_size".  "psiz" is for "tune_page".  "rcomp" is for "tune_comparator" and the value can be "lex" for the lexical comparator, "dec" for the decimal comparator, "lexdesc" for the lexical descending comparator, or "decdesc" for the decimal descending comparator.  "pccap" is for "tune_page_cache".  "apow" is for "tune_alignment".  "fpow" is for "tune_fbp".  "msiz" is for "tune_map".  "dfunit" is for "tune_defrag".  Every opened database must be closed by the PolyDB::close method when it is no longer in use.  It is not allowed for two or more database objects in the same process to keep their connections to the same database file at the same time.
    def open(path = ":", mode = DB::OWRITER | DB::OCREATE)
      # (native code)
    end
    # Close the database file.
    # @return true on success, or false on failure.
    def close()
      # (native code)
    end
    # Accept a visitor to a record.
    # @param key the key.
    # @param visitor a visitor object which implements the Visitor interface.  If it is omitted, the block parameter is evaluated.
    # @param writable true for writable operation, or false for read-only operation.
    # @block If it is specified, the block is called as the visitor.
    # @return true on success, or false on failure.
    # @note The operation for each record is performed atomically and other threads accessing the same record are blocked.  To avoid deadlock, any explicit database operation must not be performed in this method.
    def accept(key, visitor = nil, writable = true)
      # (native code)
    end
    # Accept a visitor to multiple records at once.
    # @param keys specifies an array of the keys.
    # @param visitor a visitor object which implements the Visitor interface, or a function object which receives the key and the value.
    # @param writable true for writable operation, or false for read-only operation.
    # @return true on success, or false on failure.
    # @note The operations for specified records are performed atomically and other threads accessing the same records are blocked.  To avoid deadlock, any explicit database operation must not be performed in this method.
    def accept_bulk(keys, visitor = nil, writable = true)
      # (native code)
    end
    # Iterate to accept a visitor for each record.
    # @param visitor a visitor object which implements the Visitor interface.  If it is omitted, the block parameter is evaluated.
    # @param writable true for writable operation, or false for read-only operation.
    # @block If it is specified, the block is called as the visitor.
    # @return true on success, or false on failure.
    # @note The whole iteration is performed atomically and other threads are blocked.  To avoid deadlock, any explicit database operation must not be performed in this method.
    def iterate(visitor, writable = true)
      # (native code)
    end
    # Set the value of a record.
    # @param key the key.
    # @param value the value.
    # @return true on success, or false on failure.
    # @note If no record corresponds to the key, a new record is created.  If the corresponding record exists, the value is overwritten.
    def set(key, value)
      # (native code)
    end
    # Add a record.
    # @param key the key.
    # @param value the value.
    # @return true on success, or false on failure.
    # @note If no record corresponds to the key, a new record is created.  If the corresponding record exists, the record is not modified and false is returned.
    def add(key, value)
      # (native code)
    end
    # Replace the value of a record.
    # @param key the key.
    # @param value the value.
    # @return true on success, or false on failure.
    # @note If no record corresponds to the key, no new record is created and false is returned.  If the corresponding record exists, the value is modified.
    def replace(key, value)
      # (native code)
    end
    # Append the value of a record.
    # @param key the key.
    # @param value the value.
    # @return true on success, or false on failure.
    # @note If no record corresponds to the key, a new record is created.  If the corresponding record exists, the given value is appended at the end of the existing value.
    def append(key, value)
      # (native code)
    end
    # Add a number to the numeric integer value of a record.
    # @param key the key.
    # @param num the additional number.
    # @param orig the origin number if no record corresponds to the key.  If it is negative infinity and no record corresponds, this method fails.  If it is positive infinity, the value is set as the additional number regardless of the current value.
    # @return the result value, or nil on failure.
    # @note The value is serialized as an 8-byte binary integer in big-endian order, not a decimal string.  If existing value is not 8-byte, this method fails.
    def increment(key, num = 0, orig = 0)
      # (native code)
    end
    # Add a number to the numeric double value of a record.
    # @param key the key.
    # @param num the additional number.
    # @param orig the origin number if no record corresponds to the key.  If it is negative infinity and no record corresponds, this method fails.  If it is positive infinity, the value is set as the additional number regardless of the current value.
    # @return the result value, or nil on failure.
    # @note The value is serialized as an 16-byte binary fixed-point number in big-endian order, not a decimal string.  If existing value is not 16-byte, this method fails.
    def increment_double(key, num = 0, orig = 0)
      # (native code)
    end
    # Perform compare-and-swap.
    # @param key the key.
    # @param oval the old value.  nil means that no record corresponds.
    # @param nval the new value.  nil means that the record is removed.
    # @return true on success, or false on failure.
    def cas(key, oval, nval)
      # (native code)
    end
    # Remove a record.
    # @param key the key.
    # @return true on success, or false on failure.
    # @note If no record corresponds to the key, false is returned.
    def remove(key)
      # (native code)
    end
    # Retrieve the value of a record.
    # @param key the key.
    # @return the value of the corresponding record, or nil on failure.
    def get(key)
      # (native code)
    end
    # Check the existence of a record.
    # @param key the key.
    # @return the size of the value, or -1 on failure.
    def check(key)
      # (native code)
    end
    # Retrieve the value of a record and remove it atomically.
    # @param key the key.
    # @return the value of the corresponding record, or nil on failure.
    def seize(key)
      # (native code)
    end
    # Store records at once.
    # @param recs a hash of the records to store.
    # @param atomic true to perform all operations atomically, or false for non-atomic operations.
    # @return the number of stored records, or -1 on failure.
    def set_bulk(recs, atomic = true)
      # (native code)
    end
    # Remove records at once.
    # @param keys an array of the keys of the records to remove.
    # @param atomic true to perform all operations atomically, or false for non-atomic operations.
    # @return the number of removed records, or -1 on failure.
    def remove_bulk(keys, atomic = true)
      # (native code)
    end
    # Retrieve records at once.
    # @param keys an array of the keys of the records to retrieve.
    # @param atomic true to perform all operations atomically, or false for non-atomic operations.
    # @return a hash of retrieved records, or nil on failure.
    def get_bulk(keys, atomic = true)
      # (native code)
    end
    # Remove all records.
    # @return true on success, or false on failure.
    def clear()
      # (native code)
    end
    # Synchronize updated contents with the file and the device.
    # @param hard true for physical synchronization with the device, or false for logical synchronization with the file system.
    # @param proc a postprocessor object which implements the FileProcessor interface.  If it is nil, no postprocessing is performed.
    # @block If it is specified, the block is called for postprocessing.
    # @return true on success, or false on failure.
    # @note The operation of the processor is performed atomically and other threads accessing the same record are blocked.  To avoid deadlock, any explicit database operation must not be performed in this method.
    def synchronize(hard = false, proc = nil)
      # (native code)
    end
    # Occupy database by locking and do something meanwhile.
    # @param writable true to use writer lock, or false to use reader lock.
    # @param proc a processor object which implements the FileProcessor interface.  If it is nil, no processing is performed.
    # @return true on success, or false on failure.
    # @note The operation of the processor is performed atomically and other threads accessing the same record are blocked.  To avoid deadlock, any explicit database operation must not be performed in this method.
    def occupy(writable = false, proc = nil)
      # (native code)
    end
    # Create a copy of the database file.
    # @param dest the path of the destination file.
    # @return true on success, or false on failure.
    def copy(dest)
      # (native code)
    end
    # Begin transaction.
    # @param hard true for physical synchronization with the device, or false for logical synchronization with the file system.
    # @return true on success, or false on failure.
    def begin_transaction(hard = false)
      # (native code)
    end
    # End transaction.
    # @param commit true to commit the transaction, or false to abort the transaction.
    # @return true on success, or false on failure.
    def end_transaction(commit = true)
      # (native code)
    end
    # Perform entire transaction by the block parameter.
    # @param hard true for physical synchronization with the device, or false for logical synchronization with the file system.
    # @block a block including operations during transaction.  If the block returns true, the transaction is committed.  If the block returns false or an exception is thrown, the transaction is aborted.
    # @return true on success, or false on failure.
    def transaction(hard = false)
      # (native code)
    end
    # Dump records into a snapshot file.
    # @param dest the name of the destination file.
    # @return true on success, or false on failure.
    def dump_snapshot(dest)
      # (native code)
    end
    # Load records from a snapshot file.
    # @param src the name of the source file.
    # @return true on success, or false on failure.
    def load_snapshot(src)
      # (native code)
    end
    # Get the number of records.
    # @return the number of records, or -1 on failure.
    def count()
      # (native code)
    end
    # Get the size of the database file.
    # @return the size of the database file in bytes, or -1 on failure.
    def size()
      # (native code)
    end
    # Get the path of the database file.
    # @return the path of the database file, or nil on failure.
    def path()
      # (native code)
    end
    # Get the miscellaneous status information.
    # @return a hash of the status information, or nil on failure.
    def status()
      # (native code)
    end
    # Get keys matching a prefix string.
    # @param prefix the prefix string.
    # @param max the maximum number to retrieve.  If it is negative, no limit is specified.
    # @return an array of matching keys, or nil on failure.
    def match_prefix(prefix, max = -1)
      # (native code)
    end
    # Get keys matching a regular expression string.
    # @param regex the regular expression string.
    # @param max the maximum number to retrieve.  If it is negative, no limit is specified.
    # @return an array of matching keys, or nil on failure.
    def match_regex(regex, max = -1)
      # (native code)
    end
    # Get keys similar to a string in terms of the levenshtein distance.
    # @param origin the origin string.
    # @param range the maximum distance of keys to adopt.
    # @param utf flag to treat keys as UTF-8 strings.
    # @param max the maximum number to retrieve.  If it is negative, no limit is specified.
    # @return an array of matching keys, or nil on failure.
    def match_similar(origin, range = 1, utf = false, max = -1)
      # (native code)
    end
    # Merge records from other databases.
    # @param srcary an array of the source detabase objects.
    # @param mode the merge mode.  DB::MSET to overwrite the existing value, DB::MADD to keep the existing value, DB::MAPPEND to append the new value.
    # @return true on success, or false on failure.
    def merge(srcary, mode = DB::MSET)
      # (native code)
    end
    # Create a cursor object.
    # @return the return value is the created cursor object.  Each cursor should be disabled with the Cursor#disable method when it is no longer in use.
    def cursor()
      # (native code)
    end
    # Process a cursor by the block parameter.
    # @block a block including operations for the cursor.  The cursor is disabled implicitly after the block.
    # @return always nil.
    def cursor_process()
      # (native code)
    end
    # Set the rule about throwing exception.
    # @param codes an array of error codes.  If each method occurs an error corresponding to one of the specified codes, the error is thrown as an exception.
    # @return true on success, or false on failure.
    def tune_exception_rule(codes)
      # (native code)
    end
    # Set the encoding of external strings.
    # @param enc the name of the encoding or its encoding object.
    # @note The default encoding of external strings is Encoding::ASCII_8BIT.
    # @return true on success, or false on failure.
    def tune_encoding(enc)
      # (native code)
    end
    # Get the string expression.
    # @return the string expression.
    def to_s()
      # (native code)
    end
    # Get the inspection string.
    # @return the inspection string.
    def inspect()
      # (native code)
    end
    # An alias of DB#get.
    def [](key)
      # (native code)
    end
    # An alias of DB#store.
    def []=(key, value)
      # (native code)
    end
    # An alias of DB#store.
    def store(key, value)
      # (native code)
    end
    # An alias of DB#remove.
    def delete(key, value)
      # (native code)
    end
    # An alias of DB#get.
    def fetch(key, value)
      # (native code)
    end
    # Remove the first record.
    # @return a pair of the key and the value of the removed record, or nil on failure.
    def shift()
      # (native code)
    end
    # An alias of DB#count.
    def length()
      # (native code)
    end
    # Process each records with a iterator block.
    # @block the iterator to receive the key and the value of each record.
    # @return true on success, or false on failure.
    def each()
      # (native code)
    end
    # Process the key of each record with a iterator block.
    # @block the iterator to receive the key of each record.
    # @return true on success, or false on failure.
    def each_key()
      # (native code)
    end
    # Process the value of each record with a iterator block.
    # @block the iterator to receive the value of each record.
    # @return true on success, or false on failure.
    def each_value()
      # (native code)
    end
    # Process a database by the block parameter.
    # @param path the same to the one of the open method.
    # @param mode the same to the one of the open method.
    # @param opts the optional features by bitwise-or: DB::GCONCURRENT for the concurrent mode.
    # @block a block including operations for the database.  The block receives the database object.  The database is opened with the given parameters before the block and is closed implicitly after the block.
    # @return nil on success, or an error object on failure.
    def DB.process(path = "*", mode = DB::OWRITER | DB::OCREATE, opts = 0)
      # (native code)
    end
  end
end
