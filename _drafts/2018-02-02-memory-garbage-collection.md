---
layout: post
title:  "Memory & Garbage collection"
date:   2018-02-02 00:00:00 +0000
categories: [General]
tags: [memory, virtual address space, garbage collection, performance]
---

# Virtual address space

`Paging` is a memory management scheme by which a computer stores and retrieves data from **secondary storage (hard disk)** for use in **main memory (RAM)**. Data from secondary storage is retrived in same-size blocks called `pages`. Paging is an important part of virtual memory implementations, using secondary storage to let programs exceed the size of available physical memory (physical / main / RAM).

When a program tries to reference a page not currently present in RAM, the processor treats this as a page fault and transfers control from the program to the operating system. The OS must:
 1. Determine the location of the data on disk.
 2. Obtain an empty page frame in RAM to use as a container for the data.
 3. Load the requested data into the available page frame.
 4. Update the page table to refer to the new page frame.
 5. Return control to the program, transparently retrying the instruction that caused the page fault.

When all page frames are in use, the OS must select a page frame to reuse for the page the program now needs. If the evicted page frame was dynamically allocated by a program to hold data, or if a program modified it since it was read into RAM (in other words, if it has become "dirty"), it must be written out to disk before being freed. If a program later references the evicted page, another page fault occurs and the page must be read back into RAM.


In computing, a **virtual address space (`VAS`)** is the set of ranges of virtual addresses that an OS makes available to a process. The range of virtual addresses depends on the OS pointer size implementation, which can be 4 bytes for 32-bit or 8 bytes for 64-bit OS versions. This provides several benefits, one of which is, if each process is given a separate address space, security through process isolation.


When a new application on a 32-bit OS is executed, the process has a 4 GB `VAS` (each one of the memory addresses in that space can have a single byte as a value). Initially, none of them have values ('-' represents no value). Using or setting values in such a VAS would cause a memory exception.

```
          0                                            4GB
VAS        |----------------------------------------------|

```

Then the application's executable file is mapped into the `VAS`. The OS manages the mapping:

```
          0                                            4GB
VAS        |---vvvvvvv------------------------------------|
mapping        |-----|
file bytes     app.exe
```

The v's are values from bytes in the mapped file. Then, required DLL files are mapped (this includes custom libraries as well as system ones such as kernel32.dll and user32.dll):

```
          0                                            4GB
VAS        |---vvvvvvv----vvvvvv---vvvv-------------------|
mapping        |||||||    ||||||   ||||
file bytes     app.exe    kernel   user
```

The process then starts executing bytes in the exe file. However, the only way the process can use or set '-' values in its `VAS` is to ask the OS to map them to bytes from a file. A common way to use `VAS` memory in this way is to map it to the page file. The page file is a single file, but multiple distinct sets of contiguous bytes can be mapped into a `VAS`:

```
          0                                            4GB
VAS        |---vvvvvvv----vvvvvv---vvvv----vv---v----vvv--|
mapping        |||||||    ||||||   ||||    ||   |    |||
file bytes     app.exe    kernel   user   system_page_file

```

And different parts of the page file can map into the VAS of different processes:

```
          0                                            4GB
VAS 1      |---vvvv-------vvvvvv---vvvv----vv---v----vvv--|
mapping        ||||       ||||||   ||||    ||   |    |||
file bytes     app1 app2  kernel   user   system_page_file
mapping             ||||  ||||||   ||||       ||   |
VAS 2      |--------vvvv--vvvvvv---vvvv-------vv---v------|
```

Many programs may be running concurrently. Together, they may require more than 4 GB, but not all of it will have to be in RAM at once. A paging system makes efficient decisions on which memory to relegate to secondary storage, leading to the best use of the installed RAM.




# Garbage collection

 * Each process has its own, separate virtual address space (you work only with virtual address space and never manipulate physical memory directly). The garbage collector allocates and frees virtual memory for you on the `managed heap`. Note that if you are writing native code, you use Win32 functions to work with the virtual address space. These functions allocate and free virtual memory for you on `native heaps`.
 * All processes on the same computer share the same physical memory, and share the page file if there is one.
 * `Pages`: Blocks used to retrieve data from disk to memory. Most of the time page size is 4kb.
 * `PageFile` - windows uses a page file to store data that can’t be held by your computer’s random-access memory when it fills up. Or if you’ve had a program minimized for a long time and it isn’t doing anything, its data may be moved from RAM to your page file. (PageFile it’s located at C:\pagefile.sys by default)
 * Virtual memory can be in three states:
   - Free. The block of memory has no references to it and is available for allocation.
   - Reserved. The block of memory is available for your use and cannot be used for any other allocation request. However, you cannot store data to this memory block until it is committed.
   - Committed. The block of memory is assigned to physical storage.
 * Virtual address space can get fragmented. When a virtual memory allocation is requested, the virtual memory manager has to find a single free block that is large enough to satisfy that allocation request. Even if you have 2 GB of free space, the allocation that requires 2 GB will be unsuccessful unless all of that free space is in a single address block.
 * By default, on 32-bit computers, each process has a 2-GB user-mode virtual address space. You can run out of memory if you run out of virtual address space to reserve or physical space to commit.


After the garbage collector is initialized by the CLR, it allocates two initial heap segments: one for small objects (the Small Object Heap, or SOH), and one for large objects (the Large Object Heap).  
There is a managed heap for each managed process. All threads in the process allocate memory for objects on the same heap.


Garbage collection utilizes one of three heaps to allocate space for objects:
 - **The Nursery (generation 0)** – This is where new small objects (usually short lived, like temporary variables) are allocated. When the nursery runs out of space, a minor garbage collection will occur. Any live objects will be moved to the major heap.
 - **Major Heap (generation 1)** – This is where long running objects are kept. If there is not enough memory in the major heap, then a major garbage collection will occur. If a major garbage collection fails to free up enough memory then it will ask the system for more memory.
 - **Large Object Space (generation 2)** – This is where objects that require more than 85000 bytes are kept. Large objects will not start out in the nursery, but instead will be allocated in this heap.

Collecting a generation means collecting objects in that generation and all its younger generations. Objects that are not reclaimed in a garbage collection are known as survivors, and are promoted to the next generation. When the garbage collector detects that the survival rate is high in a generation, it increases the threshold of allocations for that generation, so the next collection gets a substantial size of reclaimed memory. 

![Garbage collection](/assets/images/garbage-colletion.jpg)

The intrusiveness (frequency and duration) of garbage collections is the result of the volume of allocations and the amount of survived memory on the managed heap.
When a garbage collection is triggered, the garbage collector reclaims the memory that is occupied by dead objects. The reclaiming process compacts live objects so that they are moved together, and the dead space is removed, thereby making the heap smaller. Ordinarily, the large object heap is not compacted, because copying large objects imposes a performance penalty. However, starting with the .NET Framework 4.5.1, you can use the GCSettings.LargeObjectHeapCompactionMode property to compact the large object heap during the next full blocking GC. 


The garbage collector uses the following information to determine whether objects are live:
 - **Stack roots** Stack variables provided by the just-in-time (JIT) compiler and stack walker. Note that JIT optimizations can lengthen or shorten regions of code within which stack variables are reported to the garbage collector.
 - **Garbage collection handles** Handles that point to managed objects and that can be allocated by user code or by the common language runtime.
 - **Static data** Static objects in application domains that could be referencing other objects. Each application domain keeps track of its static objects.


Before a garbage collection starts, all managed threads are suspended except for the thread that triggered the garbage collection.

If your managed objects reference unmanaged objects by using their native file handles, you have to explicitly free the unmanaged objects, because the garbage collector tracks memory only on the managed heap.
To perform the cleanup, you can make your managed object finalizable. When your managed object dies, it performs cleanup actions that are specified in its finalizer method.
When a finalizable object is discovered to be dead, its finalizer is put in a queue so that its cleanup actions are executed, but the object itself is promoted to the next generation. Therefore, you have to wait until the next garbage collection that occurs on that generation (which is not necessarily the next garbage collection) to determine whether the object has been reclaimed.



## Workstation and server garbage collection

Both can be  concurrent (background) or non-concurrent.  Concurrent is performed on a dedicated thread and is applicable only to generation 2 collections.; generations 0 and 1 are always non-concurrent because they finish very fast. Essentially, concurrent garbage collection trades some CPU and memory for shorter pauses. 
 * Workstation garbage collection with concurrent garbage collection enabled is the default
   - The collection occurs on the user thread that triggered the garbage collection and remains at the same priority. Because user threads typically run at normal priority, the garbage collector (which runs on a normal priority thread) must compete with other threads for CPU time. Threads that are running native code are not suspended.
 * Server garbage collection is intended for server applications that need high throughput and scalability. 
  - The collection occurs on multiple dedicated threads that are running at THREAD_PRIORITY_HIGHEST priority level.
  - A heap and a dedicated thread to perform garbage collection are provided for each CPU, and the heaps are collected at the same time. 
  - Server garbage collection can be resource-intensive. For example, if you have 12 processes running on a computer that has 4 processors, there will be 48 dedicated garbage collection threads if they are all using server garbage collection. In a high memory load situation, if all the processes start doing garbage collection, the garbage collector will have 48 threads to schedule. 

If you are running hundreds of instances of an application, consider using workstation garbage collection with concurrent garbage collection disabled. This will result in less context switching, which can improve performance.


When an object allocation request is for 85,000 or more bytes, the runtime allocates it on the large object heap.
When a garbage collection is triggered, the GC traces through the live objects and compacts them. But because compaction is expensive, the GC sweeps the LOH; it makes a free list out of dead objects that can be reused later to satisfy large object allocation requests. Adjacent dead objects are made into one free object.

If there isn't enough free space to accommodate the large object allocation requests, the GC first attempts to acquire more segments from the OS. If that fails, it triggers a generation 2 GC in the hope of freeing up some space.


Garbage collection occurs when one of the following conditions is true:
 * The system has low physical memory. This is detected by either the low memory notification from the OS or low memory indicated by the host.
 * Allocation exceeds the generation 0 or large object threshold.
   - The threshold is a property of a generation. A threshold for a generation is set when the garbage collector allocates objects into it. When the threshold is exceeded, a GC is triggered on that generation. When you allocate small or large objects, you consume generation 0 and the LOH’s thresholds, respectively. When the garbage collector allocates into generation 1 and 2, it consumes their thresholds. These thresholds are dynamically tuned as the program runs. 
 * The GC.Collect method is called.
  - If the parameterless GC.Collect() method is called or another overload is passed GC.MaxGeneration as an argument, the LOH is collected along with the rest of the managed heap. 



LOH Performance Implications
 * Allocation cost.
   - The CLR makes the guarantee that the memory for every new object it gives out is cleared. If it takes 2 cycles to clear one byte, it takes 170,000 cycles to clear the smallest large object. Clearing the memory of a 16MB object on a 2GHz machine takes approximately 16ms. That's a rather large cost.
 * Collection cost.
   - Because the LOH and generation 2 are collected together, if either one's threshold is exceeded, a generation 2 collection is triggered. If generation 2 is large, it can cause performance problems if many generation 2 GCs are triggered. If many large objects are allocated on a very temporary basis and you have a large SOH, you could be spending too much time doing GCs. In addition, the allocation cost can really add up if you keep allocating and letting go of really large objects.
 * Array elements with reference types.
   - Very large objects on the LOH are usually arrays. If the elements of an array are reference-rich (e.g. array of objects that contain references to other objects...), it incurs a cost that is not present if the elements are not reference-rich. If the element doesn’t contain any references, the garbage collector doesn’t need to go through the array at all. 

Out of the three factors, the first two are usually more significant than the third. Because of this, we recommend that you allocate a pool of large objects that you reuse instead of allocating temporary ones.


# Performance analysis
 * .NET CLR memory performance counters (contains counters for various system values database, newtork, USB, RAM, number of active connections, error count...)
   - Start perfmon.exe and add desired counters. For GC relevant counters are:
     - Gen 2 Collections - displays the number of times generation 2 GCs have occurred since the process started. The counter is incremented at the end of a generation 2 collection. 
     - Large Object Heap size - displays the current size, in bytes, including free space, of the LOH. This counter is updated at the end of a garbage collection, not at each allocation.
 * Performance counters can also be queried programmatically. Many people collect them this way as part of their routine testing process. When they spot counters with values that are out of the ordinary, they use other means to get more detailed data to help with the investigation.
 * It't recomended to use ETW events because
   - they are newer and provide borader set of information
   - smaller overhead
   - perfmon has problems with precision. e.g. if counter `"% time in GC=99%"` (time spent in GC) shows a few minutes, this value could be misleading because that counter is updated at the end of GC, so if process was idle for some time after gen2 GC, that 99% value lasted until the next GC
 * ETW events (use PerfView)
 * A debugger


> One of the advantages of `SGen` is that the time it takes to perform a minor garbage collection is proportional to the number of new live objects that were created since the last minor garbage collection. This will reduce the impact of garbage collection on the performance of an application, as these minor garbage collections will take less time than a major garbage collection. Major garbage collections will still occur, but less frequently.
