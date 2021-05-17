---
layout: post
title:  "ASP.NET Core Configuration"
date:   2019-05-02 00:00:00 +0000
categories: [ASP.NET Core]
tags: [asp.net, configuration]
---

# Enviroment

ASP.NET Core reads the environment variable ASPNETCORE_ENVIRONMENT at app startup and stores the value in `IHostingEnvironment.EnvironmentName`. You can set ASPNETCORE_ENVIRONMENT to any value, but three values are supported by the framework: Development, Staging, and Production. If ASPNETCORE_ENVIRONMENT isn't set, it *defaults to Production*.

> On Windows and macOS, environment variables and values aren't case sensitive. Linux environment variables and values are case sensitive by default. 

When the app is launched the first profile with `"commandName":"Project"` is used.  
`commandName` can be any one of the following:
 * IISExpress
 * IIS
 * Project (which launches Kestrel)

The production environment should be configured to maximize security, performance, and app robustness. Some common settings that differ from development include:
 * Caching.
 * Client-side resources are bundled, minified, and potentially served from a CDN.
 * Diagnostic error pages disabled.
 * Friendly error pages enabled.
 * Production logging and monitoring enabled. For example, Application Insights.


# Host configuration values
 * Application Key (Name)
   * The IHostingEnvironment.ApplicationName property is automatically set to the name of the assembly containing the app's entry point. 
   *  .UseSetting(WebHostDefaults.ApplicationKey, "CustomApplicationName")
   * Environment variable: ASPNETCORE_APPLICATIONNAME
 * Environment
   * Default: Production. The environment can be set to any value. Framework-defined values include Development, Staging, and Production. Values aren't case sensitive. When using Visual Studio, environment variables may be set in the launchSettings.json file. 
   * Environment variable: ASPNETCORE_ENVIRONMENT
 * Content Root
   * Defaults to the folder where the app assembly resides. . Determines where ASP.NET Core begins searching for content files, such as MVC views.  The content root is also used as the base path for the Web Root setting. 
   *  Environment variable: ASPNETCORE_CONTENTROOT
 * Web Root
   * Sets the relative path to the app's static assets. Default: If not specified, the default is "(Content Root)/wwwroot", if the path exists. If the path doesn't exist, then a no-op file provider is used.
   * Environment variable: ASPNETCORE_WEBROOT
 * Server URLs
   * Default: http://localhost:5000. Indicates the IP addresses or host addresses with ports and protocols that the server should listen on for requests. Use "*" to indicate that the server should listen for requests on any IP address or hostname using the specified port and protocol (for example, http://*:5000). The protocol (http:// or https://) must be included with each URL. Supported formats vary among servers.
   * Environment variable: ASPNETCORE_URLS
 * HTTPS Port (ASPNETCORE_HTTPS_PORT)
 * Capture Startup Errors (ASPNETCORE_CAPTURESTARTUPERRORS)
 * Detailed Errors (ASPNETCORE_DETAILEDERRORS)


# App configuration

`IConfiguration` is available in the app's Dependency Injection (DI) container. 
App configuration in ASP.NET Core is based on key-value pairs established by configuration providers. At app startup, configuration sources are read in the order that their configuration providers are specified. A typical sequence of configuration providers (the one put into place when you initialize a new WebHostBuilder with CreateDefaultBuilder) is:
 1. Files (appsettings.json, appsettings.{Environment}.json, where {Environment} is the app's  currenthosting environment)
 2. Azure Key Vault
 3. User secrets (Secret Manager) (in the Development environment only)
 4. Environment variables ( for environment variables prefixed with ASPNETCORE_, if you need  additionalenvironment variables, call AddEnvironmentVariables with the some other prefix.  The prefix  is stripped off when the configuration key-value pairs are created. )
 5. Command-line arguments

It's a common practice to position the Command-line Configuration Provider last in a series of providers to allow command-line arguments to override configuration set by the other providers.


> **Security**
 * Adopt the following best practices:
 * Never store passwords or other sensitive data in configuration provider code or in plain text configuration files.
Don't use production secrets in development or test environments.
 * Specify secrets outside of the project so that they can't be accidentally committed to a source code repository.


Call `ConfigureAppConfiguration` when building the Web Host to specify the app's configuration providers in addition to those added automatically by `CreateDefaultBuilder`:

```csharp
WebHost
  .CreateDefaultBuilder(args)
  .ConfigureAppConfiguration((hostingContext, config) =>
  {
    config.SetBasePath(Directory.GetCurrentDirectory());
    config.AddInMemoryCollection(arrayDict);
    config.AddJsonFile("starship.json", optional: false, reloadOnChange: false);
    config.AddXmlFile("tvshow.xml", optional: false, reloadOnChange: false);
    config.AddEFConfiguration(options => options
                                        .UseInMemoryDatabase("InMemoryDb"));
    config.AddCommandLine(args);
  })
  .UseStartup<Startup>();
```

Note that `AddCommandLine` has already been called by CreateDefaultBuilder. If you need to provide app configuration and still be able to override that configuration with command-line arguments, call the app's additional providers in `ConfigureAppConfiguration` and call `AddCommandLine` last.

```
In the following JSON file, four keys exist in a structured hierarchy of two sections:
{
  "section1": {
    "key0": "value",
    "key1": "value"
  },
  "section2": {
    "subsection1" : {
      "key0": "value",
      "key1": "value"
    }
  }
}
```

When the file is read into configuration, the sections and keys are flattened with the use of a colon (:) to maintain the original structure: 
 * section1:key0
 * section1:key1
 * section2:subsection1:key0
 * section2:subsection1:key1 

Keys are case-insensitive.

`ConfigurationBinder.GetValue\<T\>` extracts a value from configuration with a specified key and converts it to the specified type. An overload permits you to provide a default value if the key isn't found.

```csharp
var intValue = config.GetValue<int>("NumberKey", 99);
```

`IConfiguration.GetSection` extracts a configuration subsection with the specified subsection key. **GetSection never returns null.** If a matching section isn't found, an empty IConfigurationSection is returned.
 * Use ConfigurationExtensions.Exists to determine if a configuration section exists:
    ```csharp
    var sectionExists = _config.GetSection("section2:subsection2").Exists();
    ```

A call to `IConfiguration.GetChildren` on section2 obtains an `IEnumerable\<IConfigurationSection\>`

```csharp
var configSection = _config.GetSection("section2");
var children = configSection.GetChildren();
```

Bind to a class

Configuration can be bound to classes that represent groups of related settings. 


```json
{
  "starship": {
    "name": "USS Enterprise",
    "registry": "NCC-1701",
    "class": "Constitution",
    "length": 304.8,
    "commissioned": false
  },
  "trademark": "Paramount Pictures Corp. http://www.paramount.com"
}
```

```csharp
public class Starship
{
    public string Name { get; set; }
    public string Registry { get; set; }
    public string Class { get; set; }
    public decimal Length { get; set; }
    public bool Commissioned { get; set; }
}
```

For binding we can use:

```csharp
_config.GetSection("starship").Get<Starship>();
```

