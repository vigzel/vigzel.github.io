---
layout: post
title:  "The Pragmatic Programmer"
date:   2021-05-12 16:54:25 +0200
categories: [Book Excerpts]
tags: [book]
---

Excerpts from ***The Pragmatic Programmer by David Thomas, Andrew Hunt***


#### Think! About Your Work
Think about what you're doing while you're doing it. This isn't a one-time audit of current practices—it's an ongoing critical appraisal of every decision you make, every day, and on every development. Never run on auto-pilot. Constantly be thinking, critiquing your work in real time.

#### Every day, work to refine the skills you have and to add new tools to your repertoire
Management consultants like to drop the word kaizen in conversations. "Kaizen" is a Japanese term that captures the concept of continuously making many small improvements. It was considered to be one of the main reasons for the dramatic gains in productivity and quality in Japanese manufacturing and was widely copied throughout the world. Kaizen applies to individuals, too. Over the years, you'll be amazed at how your experience has blossomed and your skills have grown.

#### Provide Options, Don't Make Lame Excuses
Run through the conversation in your mind. What is the other person likely to say? Will they ask, "Have you tried this…" or "Didn't you consider that?" How will you respond? Before you go and tell them the bad news, is there anything else you can try? Sometimes, you just know what they are going to say, so save them the trouble. Instead of excuses, provide options. Don't say it can't be done; explain what can be done to salvage the situation.

#### Don't Live with Broken Windows
Don't leave bad designs, wrong decisions, or poor code unrepaired. Fix each one as soon as it is discovered. If there is insufficient time to fix it properly, then board it up. Perhaps you can comment out the offending code, or display a "Not Implemented" message, or substitute dummy data instead. Take some action to prevent further damage and to show that you're on top of the situation.  

#### Be a Catalyst for Change
You may be in a situation where you know exactly what needs doing and how to do it. The entire system just appears before your eyes—you know it's right. But ask permission to tackle the whole thing and you'll be met with delays and blank stares. People will form committees, budgets will need approval, and things will get complicated. Everyone will guard their own resources.  
Work out what you can reasonably ask for. Develop it well. Once you've got it, show people, and let them marvel. Then say "of course, it would be better if we added…." Pretend it's not important. Sit back and wait for them to start asking you to add the functionality you originally wanted. People find it easier to join an ongoing success. Show them a glimpse of the future and you'll get them to rally around.  

#### Write good-enough software and involve users in trade off
Discipline yourself to write software that's good enough—good enough for your users, for future maintainers, for your own peace of mind. You'll find that you are more productive and your users are happier. The phrase "good enough" does not imply sloppy or poorly produced code. All systems must meet their users' requirements to be successful. We are simply advocating that users be given an opportunity to participate in the process of deciding when what you've produced is good enough  
**Great software today is often preferable to perfect software tomorrow.** If you give your users something to play with early, their feedback will often lead you to a better eventual solution. It would be unprofessional to ignore users' requirements simply to add new features to the program, or to polish up the code just one more time. Don't spoil a perfectly good program by over embellishment and over-refinement. Move on, and let your code stand in its own right for a while. It may not be perfect. Don't worry: it could never be perfect. 

#### Invest regularly in your knowledge portfolio
 * Read a technical book each month
 * Read nontechnical books too (don't forget the human side of the equation)
 * Participate in local user groups. Don't just go and listen, but actively participate. Isolation can be deadly to your career; find out what people are working on outside of your company.
 * Stay current. Subscribe to trade magazines and other journals
 * Always have something to read in an otherwise dead moment. Time spent waiting for doctors and dentists can be a great opportunity to catch up on your reading
 * Critically Analyze What You Read and Hear


#### Communicate - It's Both What You Say and the Way You Say It
Having the best ideas, the finest code, or the most pragmatic thinking is ultimately sterile unless you can communicate with other people. A good idea is an orphan without effective communication.  

**Know What You Want to Say:** Plan what you want to say. Write an outline. Then ask yourself, "Does this get across whatever I'm trying to say?" Refine it until it does.  

**Know Your Audience:** You're communicating only if you're conveying information. To do that, you need to understand the needs, interests, and capabilities of your audience. Say you want to suggest a Web-based system to allow your end users to submit bug reports. You can present this system in many different ways, depending on your audience. End users will appreciate that they can submit bug reports 24 hours a day without waiting on the phone. Managers in the support department will have two reasons to be happy: fewer staff will be needed, and problem reporting will be automated. Finally, developers may enjoy getting experience with Web-based client-server technologies and a new database engine. By making the appropriate pitch to each group, you'll get them all excited about your project.

 > What do you want them to learn? How can you motivate them to listen to you? How much detail do the want, sophisticated are they?

**Choose Your Moment:** Make what you're saying relevant in time, as well as in content. Sometimes all it takes is the simple question "Is this a good time to talk about…?"

**Choose a Style:** Adjust the style of your delivery to suit your audience. Some people want a formal "just the facts" briefing. Others like a long, wide-ranging chat before getting down to business. When it comes to written documents, some like to receive large bound reports, while others expect a simple memo or e-mail. If in doubt, ask. Remember, however, that you are half of the communication transaction. If someone says they need a paragraph describing something and you can't see any way of doing it in less than several pages, tell them so. Remember, that kind of feedback is a form of communication, too.

**Be a Listener:** There's one technique that you must use if you want people to listen to you: listen to them. Even if this is a situation where you have all the information, even if this is a formal meeting with you standing in front of 20 suits—if you don't listen to them, they won't listen to you. Encourage people to talk by asking questions, or have them summarize what you tell them. Turn the meeting into a dialog, and you'll make your point more effectively. Who knows, you might even learn something.

**Get back to people:** Always respond to e-mails and voice mails, even if the response is simply "I'll get back to you later." Keeping people informed makes them far more forgiving of the occasional slip, and makes them feel that you haven't forgotten them.


**Simple e-mail tips:***
 * Proofread before you hit SEND.  
 * Check the spelling.
 * Try to keep quoting to a minimum. No one likes to recieve back their own 100-line e-mail with "I agree" tacked on.
 * If you're quoting other people's e-mail, be sure to attribute it, and quote it inline (rather than as an attachment).
 * Don't flame unless you want it to come back and haunt you later.
 * Check your list of recipients before sending. A recent Wall Street Journal article described an employee who took to distributing criticisms of his boss over departmental e-mail. Without realizing that his boss was included on the distribution list.
 * Archive and organize your e-mail–both the import stuff you receive and the mail you send.

#### Make It Easy to Reuse
What you're trying to do is foster an environment where it's easier to find and reuse existing stuff than to write it yourself. If it isn't easy, people won't do it. And if you fail to reuse, you risk duplicating knowledge.


#### Prototype to Learn
 * What sorts of things might you choose to investigate with a prototype? Anything that carries risk. Anything that hasn't been tried before, or that is absolutely critical to the final system. Anything unproven, experimental, or doubtful. Anything you aren't comfortable with. You can prototype
   -  Architecture
   -  New functionality in an existing system
   -  Structure or contents of external data
   -  Third-party tools or components
   -  Performance issues
   -  User interface design 
 * Prototyping is a learning experience. Its value lies not in the code produced, but in the lessons learned. That's really the point of prototyping.
 * You may not even need to code in order to prototype architecture—you can prototype on a whiteboard, with Post-it notes or index cards. What you are looking for is how the system hangs together as a whole.
 * You must make it very clear that this code is disposable, incomplete, and unable to be completed. Remind them that you can build a great prototype of a new car out of wood and duct tape, but you wouldn't try to drive it in rush-hour traffic!
 * When used properly, a prototype can save you huge amounts of time, money, pain, and suffering by identifying and correcting potential problem spots early in the development cycle—the time when fixing mistakes is both cheap and easy.


#### Estimate
We recommend that you scale time estimates as follows:

| Duration | Quote estimate in |
| --- | --- |
| 1-15 days | days |
| 3-8 weeks | weeks |
| 8-30 weeks | months |
| 30+ weeks | think hard before giving an estimate |

So, if after doing all the necessary work, you decide that a project will take 125 working days (25 weeks), you might want to deliver an estimate of "about six months."

_What to Say When Asked for an Estimate?_ **You say "I'll get back to you."**  
You almost always get better results if you slow the process down and spend some time going through the steps we describe in this section. Estimates given at the coffee machine will (like the coffee) come back to haunt you.


#### Basic tools
 * Always use a Source Code Control system—even for things such as our personal address book!
 * Just as woodworkers sometimes build jigs to guide the construction of complex pieces, programmers can write code that itself writes code.


#### When possible store metadata about the raw data in plain text
Some developers may worry that by putting metadata or configuration files in plain text, they're exposing it to the system's users. This fear is misplaced. Binary data may be more obscure than plain text, but it is no more secure. If you worry about users seeing passwords, encrypt them. If you don't want them changing configuration parameters, include a secure hash of all the parameter values in the file as a checksum (MD5 is often used for this purpose).  
Suppose you have a production deployment of a large application with a complex site-specific configuration file. If this file is in plain text, you could place it under a source code control system, so that you automatically keep a history of all changes.

#### GUI vs. CMD
GUI interfaces are wonderful, and they can be faster and more convenient for some simple operations. Moving files, reading MIME-encoded e-mail, and typing letters are all things that you might want to do in a graphical environment. But if you do all your work using GUIs, you are missing out on the full capabilities of your environment. You won't be able to automate common tasks, or use the full power of the tools available to you. The shell commands may be obscure or terse, but they are powerful and concise. And, because shell commands can be combined into script files (or command files under Windows systems), you can build sequences of commands to automate things you do often.
 
  > Cygwin - provides a Unix compatibility layer for Windows. It comes with a collection of more than 120 Unix utilities, including such favorites as 1s, grep, and find. 

#### Use a single editor well
 * It should be configurable, extensible and programmable
 * Notepad++ or Sublime are good choices
 * As one of the new languages you are going to learn this year, learn the language your editor uses. For anything you find yourself doing repeatedly, develop a set of macros (or equivalent) to handle it.

#### Use source code control system
 * A good SCCS will let you track changes, answering questions such as: Who made changes in this line of code? What's the difference between the current version and last week's? How many lines of code did we change in this release? Which files get changed most often? This kind of information is invaluable for bug-tracking, audit, performance, and quality purposes
 * Always use source code control. Even if you are a single-person team on a one-week project. Make sure that everything is under source code control—documentation, phone number lists, memos to vendors, makefiles, build and release procedures, that little shell script that burns the CD master—everything

#### Write Code That Writes Code
You can build a code generator. Once built, it can be used throughout the life of the project at virtually no cost.  

If you're developing a database application, you're dealing with two environments—the database and the programming language you are using to access it. When the schema changes, you need to remember to change the corresponding code. If a column is removed from a table, but the code base is not changed, you might not even get a compilation error. The first you'll know about it is when your tests start failing (or when the user calls). An alternative is to use an active code generator—take the schema and use it to generate the source code for the structures. Now, whenever the schema changes, the code used to access it also changes, automatically. If a column is removed, then its corresponding field in the structure will disappear, and any higher-level code that uses that column will fail to compile. You've caught the error at compile time, not in production. Of course, this scheme works only if you make the code generation part of the build process itself.

e.g. Generating code from a language-neutral representation. In the input file, lines starting with 'M' flag the start of a message definition, 'F' lines define fields, and 'E' is the end of the message.

![Code Generation](/assets/images/pp-code-gen.jpg)

Besides code generators that produce program source, you can also use code generators to write just about any output: HTML, XML, plain text—any text that might be an input somewhere else in your project.

Sample applications:
 * Database schema maintenance. A set of scripts took a plain text file containing a database schema definition and from it generated:
   - The SQL statements to create the database
   - Flat data files to populate a data dictionary
   - C code libraries to access the database
   - Scripts to check database integrity
   - Web pages containing schema descriptions and diagrams
   - An XML version of the schema
 * Test data generation 
 * Web documentation - programs that analyze database schemas, C# source files, makefiles, and other project sources to produce the required HTML documentation.


#### You Can't Write Perfect Software 
Accept it as an axiom of life. Embrace it. Celebrate it. Because perfect software doesn't exist. No one in the brief history of computing has ever written a piece of perfect software. It's unlikely that you'll be the first. And unless you accept this as a fact, you'll end up wasting time and energy chasing an impossible dream.

#### Make your systems highly configurable

Use metadata to describe configuration options for an application: tuning parameters, user preferences, the installation directory, and so on. Go beyond using metadata for simple preferences. Configure and drive the application via metadata as much as possible. Think declaratively (specifying what is to be done, not how) and create highly dynamic and adaptable programs. Do this by adopting a general rule: program for the general case, and put the specifics somewhere else—outside the compiled code base.

There are several benefits to this approach:
 * It forces you to decouple your design, which results in a more flexible and adaptable program.
 * It forces you to create a more robust, abstract design by deferring details—deferring them all the way out of the program.
 * You can customize the application without recompiling it. You can also use this level of customization to provide easy work-arounds for critical bugs in live production systems.
 * Metadata can be expressed in a manner that's much closer to the problem domain than a general-purpose programming language might be (see Domain Languages). 
 * You may even be able to implement several different projects using the same application engine, but with different metadata.
 * Because business policy and rules are more likely to change than any other aspect of the project, it makes sense to maintain them in a very flexible format.
 * Without metadata, your code is not as adaptable or flexible as it could be. Is this a bad thing? Well, out here in the real world, species that don't adapt die.

Tips
 * Don't code blindfolded. Attempting to build an application you don't fully understand, or to use a technology you aren't familiar with, is an invitation to be misled by coincidences. Proceed from a plan, whether that plan is in your head, on the back of a cocktail napkin, or on a wall-sized printout from a CASE tool.
 * Document your assumptions.
 * Don't be a slave to history. Don't let existing code dictate future code. All code can be replaced if it is no longer appropriate. Even within one program, don't let what you've already done constrain what you do next—be ready to refactor. This decision may impact the project schedule. The assumption is that the impact will be less than the cost of not making the change.



#### The O() Notation
The O() notation is a mathematical way of dealing with approximations. When we write that a particular sort routine sorts n records in O(n^2) time, we are simply saying that the worst-case time taken will vary as the square of n. Double the number of records, and the time will increase roughly fourfold. Think of the O as meaning on the order of. The O() notation puts an upper bound on the value of the thing we're measuring (time, memory, and so on). 

O(n^2/2 + 3n) is the same as O(n^2/2), which is equivalent to O(n^2). This is actually a weakness of the O() notation — one O(n^2) algorithm may be 1,000 times faster than another O(n^2) algorithm, but you won't know it from the notation.

For example, suppose you've got a routine that takes 1 s to process 100 records. How long will it take to process 1,000? If your code is O(1), then it will still take 1 s. If it's O(lg(n)), then you'll probably be waiting about 3 s. O(n) will show a linear increase to 10 s, while an O(n lg(n)) will take some 33 s. If you're unlucky enough to have an O(n^2) routine, then sit back for 100 s while it does its stuff. And if you're using an exponential algorithm O(2^n), you might want to make a cup of coffee—your routine should finish in about 10263 years. Let us know how the universe ends.

The O() notation doesn't apply just to time; you can use it to represent any other resources used by an algorithm. For example, it is often useful to be able to model memory consumption.

**Estimate the Order of Your Algorithms**
You can estimate the order of many basic algorithms using common sense.
 - **Simple loops.** If a simple loop runs from 1 to n, then the algorithm is likely to be O(n) — time increases linearly with n. Examples include exhaustive searches, finding the maximum value in an array, and generating checksums.
 - **Nested loops.** If you nest a loop inside another, then your algorithm becomes O(m × n), where m and n are the two loops limits. This commonly occurs in simple sorting algorithms, such as bubble sort, where the outer loop scans each element in the array in turn, and the inner loop works out where to place that element in the sorted result. Such sorting algorithms tend to be O(n^2).
 - **Binary chop.** If your algorithm halves the set of things it considers each time around the loop, then it is likely to be logarithmic, O(lg(n)). A binary search of a sorted list, traversing a binary tree, and finding the first set bit in a machine word can all be O(lg(n)).
 - **Divide and conquer.** Algorithms that partition their input, work on the two halves independently, and then combine the result can be O(n lg(n)). The classic example is quicksort, which works by partitioning the data into two halves and recursively sorting each. Although technically O(n^2),  because its behavior degrades when it is fed sorted input, the average runtime of quicksort is O(n lg(n)).
 - **Combinatoric.** Whenever algorithms start looking at the permutations of things, their running times may get out of hand. This is because permutations involve factorials (there are 5! = 5 × 4 × 3 × 2 × 1 = 120 permutations of the digits from 1 to 5). Time a combinatoric algorithm for five elements: it will take six times longer to run it for six, and 42 times longer for seven. Examples include algorithms for many of the acknowledged hard problems — the traveling salesman problem, optimally packing things into a container, partitioning a set of numbers so that each set has the same total, and so on. Often, heuristics are used to reduce the running times of these types of algorithms in particular problem domains.


#### Work with a User to Think Like a User
There's a simple technique for getting inside your users' requirements that isn't used often enough: become a user. As well as giving you insight into how the system will used, you'd be amazed at how the request "May I sit in for a week while you do your job?" helps build trust and establishes a basis for communication with your users. Just remember not to get in the way!

Does a week sound like a long time? It really isn't, particularly when you're looking at processes in which management and workers occupy different worlds. Management will give you one view of how things operate, but when you get down on the floor, you'll find a very different reality—one that will take time to assimilate.

#### Pragmatic Teams
Pragmatic techniques that help an individual be a better programmer work for teams as well. There are advantages to being a pragmatic individual, but these advantages are multiplied manyfold if the individual is working on a pragmatic team.

There is a simple marketing trick that helps teams communicate as one: generate a brand. When you start a project, come up with a name for it, ideally something off-the-wall. (In the past, we've named projects after things such as killer parrots that prey on sheep, optical illusions, and mythical cities.) Spend 30 minutes coming up with a zany logo, and use it on your memos and reports. Use your team's name liberally when talking with people. It sounds silly, but it gives your team an identity to build on, and the world something memorable to associate with your work.

Organize Around Functionality, Not Job Functions. Divide your people into small teams, each responsible for a particular functional aspect of the final system.


#### Documentation
Pragmatic Programmers embrace documentation as an integral part of the overall development process. Writing documentation can be made easier by not duplicating effort or wasting time, and by keeping documentation close at hand—in the code itself, if possible. There are basically two kinds of documentation produced for a project: internal and external. Internal documentation includes source code comments, design and test documents, and so on. External documentation is anything shipped or published to the outside world, such as user manuals. 

Producing formatted documents from the comments and declarations in source code is fairly straightforward, but first we have to ensure that we actually have comments in the code. Code should have comments, but too many comments can be just as bad as too few. In general, comments should discuss why something is done, its purpose and its goal. The code already shows how it is done, so commenting on this is redundant—and is a violation of the DRY principle. Commenting source code gives you the perfect opportunity to document those elusive bits of a project that can't be documented anywhere else: engineering trade-offs, why decisions were made, what other alternatives were discarded, and so on. We like to see a simple module-level header comment, comments for significant data and type declarations, and a brief per-class and per-method header, describing how the function is used and anything that it does that is not obvious.

Try to produce all documentation in a form that can be published online, on the Web, complete with hyperlinks. It's easier to keep this view of the documentation up to date than to track down every existing paper copy. Remember, though, to put a date stamp or version number on each Web page. This way the reader can get a good idea of what's up to date, what's changed recently, and what hasn't

One of the most important pieces of information that should appear in the source file is the author's name—not necessarily who edited the file last, but the owner. Attaching responsibility and accountability to source code does wonders in keeping people honest (see Pride and Prejudice).

#### Gently Exceed Your Users' Expectations
A company announces record profits, and its share price drops 20%. The financial news that night explains that the company failed to meet analysts' expectations. A child opens an expensive Christmas present and bursts into tears—it wasn't the cheap doll the child was hoping for. A project team works miracles to implement a phenomenally complex application, only to have it shunned by its users because it doesn't have a help system.

Success is in the eye of the beholder—the sponsor of the project. The perception of success is what counts. In reality, the success of a project is measured by how well it meets the expectations of its users. A project that falls below their expectations is deemed a failure, no matter how good the deliverable is in absolute terms.

Some things you can add relatively easily that look good to the average user include:
 - Balloon or ToolTip help
 - Keyboard shortcuts
 - A quick reference guide as a supplement to the user's manual
 - Colorization
 - Log file analyzers
 - Automated installation
 - Tools for checking the integrity of the system
 - The ability to run multiple versions of the system for training
 - A splash screen customized for their organization
 - Just remember not to break the system adding these new features…



 > The GNU General Public License is a kind of legal virus that Open Source developers use to protect their (and your) rights. You should spend some time reading it. In essence, it says that you can use and modify GPL'd software, but if you distribute any modifications they must be licensed according to the GPL (and marked as such), and you must make source available. That's the virus part—whenever you derive a work from a GPL'd work, your derived work must also be GPL'd. However, it does not limit you in any way when simply using the tools—the ownership and licensing of software developed using the tools are up to you.