= Ruby Binding of Kyoto Cabinet

Kyoto Cabinet: a straightforward implementation of DBM

== Introduction

Kyoto Cabinet is a library of routines for managing a database.  The database is a simple data file containing records, each is a pair of a key and a value.  Every key and value is serial bytes with variable length.  Both binary data and character string can be used as a key and a value.  Each key must be unique within a database.  There is neither concept of data tables nor data types.  Records are organized in hash table or B+ tree.

The following access methods are provided to the database: storing a record with a key and a value, deleting a record by a key, retrieving a record by a key.  Moreover, traversal access to every key are provided.  These access methods are similar to ones of the original DBM (and its followers: NDBM and GDBM) library defined in the UNIX standard.  Kyoto Cabinet is an alternative for the DBM because of its higher performance.

Each operation of the hash database has the time complexity of "O(1)".  Therefore, in theory, the performance is constant regardless of the scale of the database.  In practice, the performance is determined by the speed of the main memory or the storage device.  If the size of the database is less than the capacity of the main memory, the performance will seem on-memory speed, which is faster than std::map of STL.  Of course, the database size can be greater than the capacity of the main memory and the upper limit is 8 exabytes.  Even in that case, each operation needs only one or two seeking of the storage device.

Each operation of the B+ tree database has the time complexity of "O(log N)".  Therefore, in theory, the performance is logarithmic to the scale of the database.  Although the performance of random access of the B+ tree database is slower than that of the hash database, the B+ tree database supports sequential access in order of the keys, which realizes forward matching search for strings and range search for integers.  The performance of sequential access is much faster than that of random access.

This library wraps the polymorphic database of the C++ API.  So, you can select the internal data structure by specifying the database name in runtime.  This library is thread-safe on Ruby 1.9.x (YARV) though it is not thread-safe on Ruby 1.8.x.

== Installation

Install the latest version of Kyoto Cabinet beforehand and get the package of the Ruby binding of Kyoto Cabinet.

Enter the directory of the extracted package then perform installation.

 ruby extconf.rb
 make
 ruby test.rb
 su
 make install

The package `kyotocabinet' should be loaded in each source file of application programs.

 require 'kyotocabinet'

All symbols of Kyoto Cabinet are defined in the module `KyotoCabinet'.  You can access them without any prefix by including the module.

 include KyotoCabinet

An instance of the class `DB' is used in order to handle a database.  You can store, delete, and retrieve records with the instance.

== Example

The following code is a typical example to use a database.

 require 'kyotocabinet'
 include KyotoCabinet
 
 # create the database object
 db = DB::new
 
 # open the database
 unless db.open('casket.kch', DB::OWRITER | DB::OCREATE)
   STDERR.printf("open error: %s\n", db.error)
 end
 
 # store records
 unless db.set('foo', 'hop') and
     db.set('bar', 'step') and
     db.set('baz', 'jump')
   STDERR.printf("set error: %s\n", db.error)
 end
 
 # retrieve records
 value = db.get('foo')
 if value
   printf("%s\n", value)
 else
   STDERR.printf("get error: %s\n", db.error)
 end
 
 # traverse records
 cur = db.cursor
 cur.jump
 while rec = cur.get(true)
   printf("%s:%s\n", rec[0], rec[1])
 end
 cur.disable
 
 # close the database
 unless db.close
   STDERR.printf("close error: %s\n", db.error)
 end

The following code is a more complex example, which uses the Visitor pattern.

 require 'kyotocabinet'
 include KyotoCabinet
 
 # create the database object
 db = DB::new
 
 # open the database
 unless db.open('casket.kch', DB::OREADER)
   STDERR.printf("open error: %s\n", db.error)
 end
 
 # define the visitor
 class VisitorImpl < Visitor
   # call back function for an existing record
   def visit_full(key, value)
     printf("%s:%s\n", key, value)
     return NOP
   end
   # call back function for an empty record space
   def visit_empty(key)
     STDERR.printf("%s is missing\n", key)
     return NOP
   end
 end
 visitor = VisitorImpl::new
 
 # retrieve a record with visitor
 unless db.accept("foo", visitor, false) and
     db.accept("dummy", visitor, false)
   STDERR.printf("accept error: %s\n", db.error)
 end
 
 # traverse records with visitor
 unless db.iterate(visitor, false)
   STDERR.printf("iterate error: %s\n", db.error)
 end
 
 # close the database
 unless db.close
   STDERR.printf("close error: %s\n", db.error)
 end

The following code is also a complex example, which is suited to the Ruby style.

 require 'kyotocabinet'
 include KyotoCabinet
 
 # process the database by iterator
 DB::process('casket.kch') { |db|
 
   # set the encoding of external strings
   db.set_encoding('utf-8')
 
   # store records
   db['foo'] = 'hop';  # string is fundamental
   db[:bar] = 'step';  # symbol is also ok
   db[3] = 'jump';     # number is also ok
 
   # retrieve a record value
   printf("%s\n", db['foo'])
 
   # update records in transaction
   db.transaction {
     db['foo'] = 2.71828
     true
   }
 
   # multiply a record value
   db.accept('foo') { |key, value|
     value.to_f * 2
   }
 
   # traverse records by iterator
   db.each { |key, value|
     printf("%s:%s\n", key, value)
   }
 
   # upcase values by iterator
   db.iterate { |key, value|
     value.upcase
   }
 
   # traverse records by cursor
   db.cursor_process { |cur|
     cur.jump
     while cur.accept { |key, value|
         printf("%s:%s\n", key, value)
         Visitor::NOP
       }
       cur.step
     end
   }
 
 }

== License

 Copyright (C) 2009-2010 FAL Labs
 All rights reserved.

Kyoto Cabinet is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

Kyoto Cabinet is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
