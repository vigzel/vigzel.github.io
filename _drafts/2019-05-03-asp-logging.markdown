---
layout: post
title:  "ASP.NET Core Logging"
date:   2019-05-03 00:00:00 +0000
categories: [ASP.NET Core]
tags: [asp.net, logging]
---

`Microsoft.Extensions.Logging` includes the necessary classes and interfaces for logging. The most important are  
 * `ILogger` - includes methods for logging to the underlying storage
 * `ILoggerProvider` - manages and creates an appropriate logger, specified by the logging category.
    ```csharp
    public interface ILoggerProvider : IDisposable
    {
        ILogger CreateLogger(string categoryName);
    }
    ```
 * `ILoggerFactory` - factory interface for creating an appropriate ILogger type instance and also for adding the ILoggerProvider instance. The LoggerFactory can contain one or more logging providers, which can be used to log to multiple mediums concurrently.
    ```csharp
    public interface ILoggerFactory : IDisposable
    {
        ILogger CreateLogger(string categoryName);
        void AddProvider(ILoggerProvider provider);
    }
    ```
 * `LoggerFactory`

Microsoft provides various logging providers as NuGet packages.
 * Microsoft.Extensions.Logging.Console
 * Microsoft.Extensions.Logging.AzureAppServices  
 * Microsoft.Extensions.Logging.EventLog  

The default project template calls the CreateDefaultBuilder extension method, which adds the following logging providers:
 * Console
 * Debug
 * EventSource 

If you want to use other providers or any default provider, then you need to remove all the existing providers and add the provider of your choice. 

```csharp
WebHost.CreateDefaultBuilder(args)
  .ConfigureLogging((hostingContext, logging) =>
  {
    logging.ClearProviders();
    logging.AddConfiguration(hostingContext.Configuration.GetSection("Logging"));
    logging.AddConsole();            
    logging.AddDebug();            
    logging.AddEventSourceLogger();
  });
```

When an `ILogger` object is created, a category is specified for it (convention is to use the class name) 

```csharp
public class AboutModel : PageModel
{
    private readonly ILogger _logger;
    public AboutModel(ILogger<AboutModel> logger)
    {
        _logger = logger;
        string p1 = "parm1";
        string p2 = "parm2";
        _logger.LogInformation("Parameter values: {p2}, {p1}", p1, p2); 
    }
}
```

 > Structured logging is recomended, where a message template that can contain placeholders ({}) for which arguments are provided. *Use names for the placeholders, not numbers!* The order of placeholders, not their names, determines which parameters are used to provide their values. 


Logging configuration is commonly provided by the Logging section of app settings files. 

```console
Microsoft.AspNetCore.Hosting.Internal.WebHost:Information: Request starting HTTP/1.1 GET http://localhost:53104/api/todo/0  
Microsoft.AspNetCore.Mvc.Internal.ControllerActionInvoker:Information: Executing action method TodoApi.Controllers.TodoController.GetById (TodoApi) with arguments (0) - ModelState is Valid
TodoApi.Controllers.TodoController:Information: Getting item 0
```

The logs that begin with `Microsoft` categories are from ASP.NET Core framework code.

Here are some categories used by ASP.NET Core and Entity Framework Core, with notes about what logs to expect from them:

| Category | Notes |
| --- | --- |
| Microsoft.AspNetCore | General ASP.NET Core diagnostics. |
| Microsoft.AspNetCore.DataProtection | Which keys were considered, found, and used. |
| Microsoft.AspNetCore.HostFiltering | Hosts allowed. |
| Microsoft.AspNetCore.Hosting | How long HTTP requests took to complete and what time they started. Which hosting startup assemblies were loaded. |
| Microsoft.AspNetCore.Mvc | MVC and Razor diagnostics. Model binding, filter execution, view compilation, action selection. |
| Microsoft.AspNetCore.Routing | Route matching information. |
| Microsoft.AspNetCore.Server | Connection start, stop, and keep alive responses. HTTPS certificate information. |
| Microsoft.AspNetCore.StaticFiles | Files served. |
| Microsoft.EntityFrameworkCore | General Entity Framework Core diagnostics. Database activity and configuration, change detection, migrations. |

