---
layout: post
title:  "Asynchrony"
date:   2014-08-05 22:11:45 +0200
categories: [General]
tags: [async, task, concurency]
---

Asynchrony is concurrency (doing more than one thing) without threads.

`Async` is bad for CPU-bound tasks, because CPU work always requires a thread, but it excels at any concurrency that doesn’t involve CPU code (e.g., I/O).  
_In reality, all I/O is asynchronous (no threads), and existng synchronous API is just a wrapper around the inherently asynchronous I/O._


Why not just increase the threadpool?
 * Async scales further than blocking threads. Threads have ~1MB stack, plus kernel stack (unpageable).
 * Async scales faster than blocking threads. ThreadPool has a limited injection rate (1 every 0.5 seconds) to avoid constant thread creation/destruction.
 * Async does not replace the threadpool; rather, it ensures your code is making optimum use of the threadpool.

|  | Original code | Parallel eqivalents |
| ------------- |  ------------- | ------------- |
| **Data Parallelism** | LINQ, for, foreach  | PLINQ, Parallel.For, Parallel.ForEach |
| **Task Parallelism** | f1(); f2(); | Parallel.Invoke(f1, f2) | 

<sup>*_(f1/f2 can be, say “process the left branch of the binary tree” and “process the right branch of the binary tree”.)_</sup>

## Mathematics

Notes: 
 - Parallel server code is almost always a bad idea (though it can be useful in controlled environments - known # of users)
 - Avoid: Parallel/PLINQ, Task.Run, TaskFactory.StartNew, Task.ContinueWith
 - Task\<T\> represents a future for a single value of type T. Sometimes, you need to return a stream of values (see [Rx.NET][rxnet])
 > e.g. a function that reads a database table, and returns it. If you return task, you will have to return something like Task<List<Row>>, that means you will be buffering all the rows in memory, and complete the task when the whole table is buffered. A better option is to return IObservable<Row>. Each row, as it is read from the database, is pushed through the IObservable. The consumer can then process rows as they become available, and there is never more than one row in memory at the same time.



[rxnet]: https://jack-vanlightly.com/blog/2018/4/19/processing-pipelines-series-reactive-extensions-rxnet/
