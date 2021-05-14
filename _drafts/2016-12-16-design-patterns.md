---
layout: post
title:  "Design patterns"
date:   2016-12-16 00:00:00 +0000
categories: [General]
tags: [design patterns, gof, singleton, ioc]
---

# Singleton

Problem with singletons is that they are generally used as a global instance. Why is that so bad? Because you hide the dependencies of your application in your code, instead of exposing them through the interfaces. Global state makes it so your objects can secretly get hold of things which are not declared in their APIs.  
Singletons are also a problem from a testing perspective. They tend to make isolated unit-tests difficult to write. Inversion of control (IoC) and dependency injection are patterns meant to overcome this problem in an object-oriented manner that lends itself to unit testing. 

Logging is a specific example of an "acceptable" Singleton because it doesn't affect the execution of your code. 
> The information flows one way: From your application into the logger. Even though loggers are global state, since no information flows from loggers into your application, loggers are acceptable.


# Inversion of Control, Dependency Injection, Service Locator

**IoC (inversion of control)** is any sort of programming style where an overall framework or runtime controls the program flow. It is a design principle where the control flow of a program is inverted:  from client code to the external framework which "Does something for the client".  Rather than having the application, call the methods in a framework, the framework calls implementations provided by the application. 

When you write ASP.NET application, you hook into the ASP.NET page life cycle, but you aren't in control - ASP.NET is. Event-driven programming is often implemented using IoC, so that the custom code is only concerned with handling of events, whereas the event loop and dispatching of events/messages is handled by the framework or the run-time environment. 

SL (Service Locator) and DI (Dependency Injection) are two design patterns stem off from IoC, 2 implementations of IoC. The important difference between the two patterns is about how that implementation is provided to the application class.  
With service locator the application class asks for it explicitly by a message to the locator.  
With injection there is no explicit request, the service appears in the application class.  

The key difference is that with a Service Locator every user of a service has a dependency to the locator. The locator can hide dependencies to other implementations, but you do need to see the locator. So the decision between locator and injector depends on whether that dependency is a problem.  

Using dependency injection can help make it easier to see what the component dependencies are. With dependency injector you can just look at the injection mechanism, such as the constructor, and see the dependencies. With the service locator you have to search the source code for calls to the locator. Modern IDEs with a find references feature make this easier, but it's still not as easy as looking at the constructor or setting methods.

A common reason people give for preferring dependency injection is that it makes testing easier. The point here is that to do testing, you need to easily replace real service implementations with stubs or mocks. However there is really no difference here between dependency injection and service locator: both are very amenable to stubbing. I suspect this observation comes from projects where people don't make the effort to ensure that their service locator can be easily substituted. 

So the primary issue is for people who are writing code that expects to be used in applications outside of the control of the writer. In these cases even a minimal assumption about a Service Locator is a problem.

# Builder pattern

Design pattern that aims to separate the construction of a complex object from its representation. 

![Image of builder pattern](/assets/images/patterns_builder.jpg)

 * Builder - Abstract interface for creating objects (product).
 * ConcreteBuilder - implementation for Builder. It is an object able to construct other objects. Constructs and assembles parts to build the objects.

```csharp
// Represents a product created by the builder
public class Car
{
  public string Make { get; set; }
  public string Model { get; set; }
  public int NumDoors { get; set; }
  public string Colour { get; set; }
  
  public Car(string make, string model, string colour, int numDoors)
  {
    Make = make;
    Model = model;
    Colour = colour;
    NumDoors = numDoors;
  }
}

// The builder abstraction
public interface ICarBuilder
{
  string Colour { get; set; }
  int NumDoors { get; set; }
  Car Build();
}

// Concrete builder implementation
public class FerrariBuilder : ICarBuilder
{
  public string Colour { get; set; }
  public int NumDoors { get; set; }
  
  public Car Build()
  {
    return NumDoors == 2 ? new Car("Ferrari", "488 Spider", Colour, NumDoors) : null; 
  }
}

// The director
public class SportsCarBuildDirector
{
  private ICarBuilder _builder;
  public SportsCarBuildDirector(ICarBuilder builder) 
  {
    _builder = builder;
  }
  
  public void Construct()
  {
    _builder.Colour = "Red";
    _builder.NumDoors = 2;
  }
}

public class Client
{
  public void DoSomethingWithCars()
  {
    var builder = new FerrariBuilder();
    var director = new SportsCarBuildDirector(builder);
    director.Construct();
    Car myRaceCar = builder.GetResult();
  }
}
```