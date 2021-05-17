---
layout: post
title:  "Http Client"
date:   2019-05-02 00:00:00 +0000
categories: [ASP.NET Core]
tags: [asp.net, HttpClient]
---

An `IHttpClientFactory` can be used to configure and create `HttpClient` instances in an app. It offers the following benefits:
 * Provides a central location for naming and configuring logical `HttpClient` instances. For example, a github client can be registered and configured to access GitHub. A default client can be registered for other purposes.
 * Manages the pooling and lifetime of underlying HttpClientMessageHandler instances to avoid common DNS problems that occur when manually managing HttpClient lifetimes.
 * Adds a configurable logging experience (via ILogger) for all requests sent through clients created by the factory.


There are several ways `IHttpClientFactory` can be used in an app:
 * Basic usage
 * Named clients
 * Typed clients
 * Generated clients


The `IHttpClientFactory` can be registered by calling the `AddHttpClient` extension method on the `IServiceCollection`, inside `the Startup.ConfigureServices` method.


## Basic usage

Registration:

```csharp
services.AddHttpClient();
```

Usage: 

```csharp
public class BasicUsageModel : PageModel
{
  private readonly IHttpClientFactory _clientFactory;
  
  public BasicUsageModel(IHttpClientFactory clientFactory)
  {
    _clientFactory = clientFactory;
  }
  
  
  public async Task OnGet()
  {
    var client = _clientFactory.CreateClient();
    var response = await client.SendAsync(request);
    ....                       
  }
}
```

## Named clients

If an app requires many distinct uses of HttpClient, each with a different configuration, an option is to use named clients.

```csharp
services.AddHttpClient("github", c =>
{
    c.BaseAddress = new Uri("https://api.github.com/");
    c.DefaultRequestHeaders.Add("Accept", "application/vnd.github.v3+json"); 
    c.DefaultRequestHeaders.Add("User-Agent", "HttpClientFactory-Sample");
});
```

Use:

```csharp
  ...
  var client = _clientFactory.CreateClient("github");
  ...
```
 > Note: Each time CreateClient is called, a new instance of HttpClient is created and the configuration action is called.




## Typed clients
Typed clients provide the same capabilities as named clients without the need to use strings as keys. For example, a single typed client might be used for a single backend endpoint and encapsulate all logic dealing with that endpoint. Another advantage is that they work with DI and can be injected where required in your app.
A typed client accepts a HttpClient parameter in its constructor:

```csharp
public class GitHubService
{
  public HttpClient Client { get; }
  public GitHubService(HttpClient client)
  {
    client.BaseAddress = new Uri("https://api.github.com/");
    ....
  }
  public async Task<IEnumerable<GitHubIssue>> GetAspNetDocsIssues()
  {
    var response = await Client.GetAsync("/repos/docs/issues?state=open");
    ....
  }
}
```

To register a typed client use `services.AddHttpClient<GitHubService>();`  and just inject it as any other dependancy:

``` csharp
public class TypedClientModel : PageModel
{
  private readonly GitHubService _gitHubService;
  public TypedClientModel(GitHubService gitHubService)
  {
    _gitHubService = gitHubService;
  }
}
```

## Generated clients

IHttpClientFactory can be used in combination with other third-party libraries such as Refit. 


# Reguest processing

## Outgoing request middleware

HttpClient already has the concept of delegating handlers that can be linked together for outgoing HTTP requests. It supports registration and chaining of multiple handlers to build an outgoing request middleware pipeline. Each of these handlers is able to perform work before and after the outgoing request. This pattern is similar to the inbound middleware pipeline in ASP.NET Core. The pattern provides a mechanism to manage cross-cutting concerns around HTTP requests, including caching, error handling, serialization, and logging.

```csharp
public class ValidateHeaderHandler : DelegatingHandler
{
    ...
}
```

During registration, one or more handlers can be added to the configuration for a HttpClient. 

```csharp
services.AddTransient<ValidateHeaderHandler>();
services.AddHttpClient<GitHubService>()
        .AddHttpMessageHandler<ValidateHeaderHandler>();
```


## Use Polly-based handlers
IHttpClientFactory integrates with a popular third-party library called `Polly`.  
`Polly` allows developers to express policies such as Retry, Circuit Breaker, Timeout, Bulkhead Isolation, and Fallback in a fluent and thread-safe manner.


## Handle transient faults
A convenient extension method called `AddTransientHttpErrorPolicy` is included which allows a policy to be defined to handle transient errors like `HttpRequestException`, `HTTP 5xx` responses, and `HTTP 408` responses.

```csharp
// Failed requests are retried up to three times 
// with a delay of 600 ms between attempts.
services.AddHttpClient<UnreliableEndpointCallerService>()
    .AddTransientHttpErrorPolicy(p => 
        p.WaitAndRetryAsync(3, _ => TimeSpan.FromMilliseconds(600))); 
```

Clients created via IHttpClientFactory record log messages for all requests. Additional logging, such as the logging of request headers, is only included at trace level.
The log category used for each client includes the name of the client. Including the name of the client in the log category enables log filtering for specific named clients where necessary.



