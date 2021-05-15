---
layout: post
title:  "Recursion vs Iteration"
date:   2016-10-14 00:00:00 +0000
categories: [General]
tags: [recursion]
---

Technically, iterative loops fit typical computer systems better at the hardware level: at the machine code level, (a loop is just a test and a conditional jump, whereas recursion involves pushing a stack frame, jumping, returning, and popping back from the stack).  
On the other hand, many cases of recursion can be written so that the stack push/pop can be avoided; this is possible when the recursive function call is the last thing that happens in the function body before returning, and it's commonly known as a **tail call optimization** (or tail recursion optimization). A properly tail-call-optimized recursive function is mostly equivalent to an iterative loop at the machine code level.

Another consideration is that iterative loops require destructive state updates, which makes them incompatible with pure (side-effect free) language semantics. This is the reason why pure languages like Haskell do not have loop constructs at all, and many other functional-programming languages either lack them completely or avoid them as much as possible.
  > In a loop, each iteration is a 'refreshed' scope, all of the variables from the previous iteration are deleted (variables for iteration i-1 can't be accessed from iteration i, because the variables from i-1 are deleted on the transition from iteration i-1 to iteration i). In a recursive function, each new iteration is run in a subscope of the last iteration (the variables for iteration i-1 are still alive during iteration 1, they just exist in a different scope).

Recursion is used to express an algorithm that is naturally recursive in a form that is more easily understandable. A "naturally recursive" algorithm is one where the answer is built from the answers to smaller sub-problems which are in turn built from the answers to yet smaller sub-problems, etc. For example, computing a factorial.

Recursions usually require less code. In a programming language that is not functional, an iterative approach is nearly always faster and more efficient than a recursive approach, so **the reason to use recursion is clarity, not speed**. If a recursive implementation ends up being less clear than an iterative implementation, then by all means avoid it. Loops may achieve a performance gain for your program. Recursion may achieve a performance gain for the developer. 

I favor recursive solutions when:
- The implementation of the recursion is much simpler than the iterative solution
- I can be reasonably assured that the depth of the recursion will not cause a stack overflow (assuming we're talking about a language that implements recursion this way)


 > Stack overflow occurs when a program attempts to use more space than is available on the call stack. Stack size of C# is 1 MB for 32-bit processes and 4 MB for 64-bit processes. This is per thread. 


### Why is doing a function call sub-optimal in comparison to doing a loop and manually stacking variables. I would think the cost would be about the same?
Recursion uses the call stack to store function call returns. Function state is stored in between calls. For certain languages+compilers stack space is limited, eg. Python supports recursion, but by default there is a limit for the recursion depth (1000), embeded enviroments, C and Java have a lot less memory on the stack than they do on the heap, namely, doing a X times recursion can run outta stack memory while re-writing that code as a X-times looping iterative construct will work fine.

### Why recursion questions appear so much in interviews?
The reason why these questions appear so much in interviews, though, is because in order to answer them, you need a thorough understanding of many vital programming concepts - variables, function calls, scope, and of course loops and recursion -, and you have to bring the mental flexibility to the table that allows you to approach a problem from two radically different angles, and move between different manifestations of the same concept. Experience and research suggest that there is a line between people who have the ability to understand variables, pointers, and recursion, and those who don't. Almost everything else in programming, including frameworks, APIs, programming languages and their edge cases, can be acquired through studying and experience, but if you are unable to develop an intuition for these three core concepts, you are unfit to be a programmer. Translating a simple iterative loop into a recursive version is about the quickest possible way of filtering out the non-programmers - even a rather inexperienced programmer can usually do it in 15 minutes, and it's a very language-agnostic problem, so the candidate can pick a language of their choice instead of stumbling over idiosyncracies.



