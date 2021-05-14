---
layout: post
title:  "Dependency Injection"
date:   2017-04-02 00:00:00 +0000
categories: [General]
tags: [DI, dependency-injection, service-locator,]
---

Excerpt from "Dependency Injection in .NET by Seemann Mark"

**Dependency Injection** is a set of software design principles and patterns that enable us to develop loosely coupled code.
The basic purpose of DI is maintainability. One of many ways to make code maintainable is through loose coupling. Loose coupling makes code extensible, and extensibility makes it maintainable. DI is nothing more than a technique that enables loose coupling.

Do you want you applications to be "Cloud ready"? You will benefit from DI, because it enables you to easily replace relational data access component with e.g. Azure. The benefits we can reap from loose coupling aren't always immediately apparent, but they become visible over time, as the complexity of a code base grows. Small code bases, like a classic Hello World example, are inherently maintainable because of their size; this is why DI tends to look like over-engineering in simple examples.

Through loose coupling, DI also enables late binding (refers to ability to replace parts of an application code without recompiling the code), unit testing, and parallel development.

**DI is not same as service locator**. Service locator is a general purpose Factory, DI is a way to structure code so that we newer have to imperatively ask for dependency, rather we force consumer to supply it.


**Liskov substitution principle** states that we should be able to replace one implementation of an interface with another without breaking eater client or implementation.


**Decorator design pattern** - intercepts one implementation with another implementation of the same interface. It gives us the ability to incrementally introduce new features without having to rewrite or change a lot of our existing code.
This `SecureMessageWriter` class implements `IMessageWriter` while also consuming it. This is a standard implementation of decorator design pattern.

```csharp
public class SecurreMessageWriter : IMessageWriter
{
  private readonly IMessageWriter writer;

  public SecurreMessageWriter(IMessageWriter writer)
  {
    if(writer == null) throw new ArgumentNullException("writer");
    this.writer = writer;

  }

  public void Write(string message)
  {
    if(Thread.CurrentPrincipal.Identity.IsAuthenticated) writer.Write(message);
  }
}
```

> Always program to interfaces, dependencies must always be abstractions.


**OBJECT COMPOSITION, INTERCEPTION, and LIFETIME MANAGEMENT are three dimensions of DI.** 
Interception is an application of decorator design pattern. Interception allows us to modify objects before passing them to the classes that consume them. We can apply cross-cutting concerns such as logging, auditing, access control, validation, and so forth in a well structured manner that lets us maintain separation of concerns.

A consumer can have dependencies injected into it and use them for as long as it wants. When it's done, the dependencies go out of scope and if no other class references them, they're eligible for garbage collection. In some cases, we may choose to share a single instance of some dependency across several consumers. From the perspective of the consumer there is no difference, but because dependency may be shared, a single consumer cant possibly control it's lifetime.
Giving up control of dependency also means giving up control of its lifetime; something else higher up in call stack must manage the lifetime of the dependency. 


When I write software, I prefer to start in the most significant place. This is often the user interface. From there, I work my way in, adding more functionality until the feature is done and I can move on to the next.  This outside-in technique helps me to focus on the requested functionality without over-engineering the solution. Also, because I know that the project stakeholders will mainly be interested in the visual result, the user interface sounds like a good place to start.


The Domain Model is a plan vanilla C# library that I add to the solution. This library will contain POCOs and abstract types. The POCOs will model the Domain while the abstract types provide abstractions that will serve as my main external entry point into Domain Model. 
If for some reason I would require different implementations of POCOs (e.g. data access library like SQLite needs to decorate objects, or WCF service needs to decorate objects, or WPF applications needs to call property notifiers when object property changes), I would then add another level of indirection and extract interface from POCOs (e.g. IProduct instead of Product). These abstractions can that be moved to a separate library and shared by both Domain Model and Data Access Library. It would require more work because I'd need to write code to map between IProduct and Product, but it's certainly possible.


In an n-layer application we can push the burden of dependencies all the way to the top of the application, into the COMPOSITION ROOT. This is a centralized place where the different modules of the application can be composed. This can be done manually or delegated to DI CONTAINER.
