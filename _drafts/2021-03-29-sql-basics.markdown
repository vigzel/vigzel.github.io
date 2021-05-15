---
layout: post
title:  "SQL"
date:   2021-03-29 00:00:00 +0000
categories: [Database]
tags: [heap, logical-read, index]
---

A `heap` is a table without a clustered index. 
 - When a table is stored as a heap, individual rows are identified by reference to a row identifier (RID) consisting of the file number, data page number, and slot on the page. 
 - The row id is a small and efficient structure. The RID (row ID) is included in a non-clustered index. 
 - Sometimes data architects use heaps when data is always accessed through nonclustered indexes and the RID is smaller than a clustered index key (rowid size is 10-byte)


A `logical read` is when the query engine needs to read data, but it finds it already in SQL Server's memory. It doesn't need to go to the disk. If it does need to go retrieve the data from the disk, that is called a `physical read`. A logical read is a "cache hit," basically.


## Why Non-Clustered Indexes are just ignored!

Because SQL optimizes for fewer I/Os and reduced CPU consumption.

Bookmark Lookups are getting really expensive (regarding I/O costs, and also regarding CPU costs!), when you retrieve a huge amount of records through a Bookmark Lookup. Your logical reads would just explode, and therefore SQL Server implements the Tipping Point
 - bookmark lookup is the process of finding the actual data in the SQL table, based on an entry found in a non-clustered index.

Example: We can see the number of logical and physical reads with the option "SET STATISTICS IO ON"
 - Assume we have a table with 80.000 records, where every record is 400 bytes long, therefore 20 records can be stored on 1 page of 8kb, meaning the table consists of 4.000 data pages in the leaf level of the Clustered Index. 
 - The "Tipping Point" is somewhere between 1/4 - 1/3 of the pages that we are reading for that specific table (1000 - 1333 pages). This means you can read about 1,25% – 1,67% (1000/80000 - 1333/80000) of the records from the table before the Query Optimizer decides to do a full scan of the table instead of using a non-clustered index.
 - Moral of the story: a Non-Clustered Index, which isn’t a Covering Non-Clustered Index has a very, very, very, very, very selective Use Case in SQL Server! Think about that the next time when you are working on your indexing strategy.
