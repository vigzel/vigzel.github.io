---
layout: post
title:  "Self signed certificates"
date:   2014-06-01 20:00:00 +0000
categories: [General]
tags: [certificate, makecert, pfx, cert, pvk]
---

## Certificate Authority (CA)
Normally most companies would just buy their certificates from a trusted third party certificate authority such as GoDaddy or Verisign, but for development and testing you can create your own self signed certificates, starting with a root CA that can be used to sign other certificates. These certificates are not trusted by default, you must add the root CA to your machine’s Trusted Root Certification Authorities Store through the Microsoft Management Console.

First we create a certificate with makecert.exe, then we use pvk2pfx.exe to copy the public key and private key information from the .pvk and .cer into a .pfx (personal information exchange) file.

> The `^` symbol means "escape the next line", this makes it more readable instead of one long command string.  

```console
makecert.exe ^
-n "CN=CARoot" ^
-r ^
-pe ^
-a sha512 ^
-len 4096 ^
-cy authority ^
-sv CARoot.pvk ^
-sr LocalMachine ^
-ss Root ^
CARoot.cer
 
pvk2pfx.exe ^
-pvk CARoot.pvk ^
-spc CARoot.cer ^
-pfx CARoot.pfx ^
-po Test123

```

> The makecert.exe parameters:
 * `-n "CN=CARoot"` ➜ certificate name, must be formatted as the standard: `"CN=CARoot,O=My Organization,OU=Dev,C=HR"`
    - `CN` commonName
	- `O` organizationName 
    - `OU` organizationalUnitName 
    - `L` localityName 
    - `S` stateOrProvinceName 
    - `C` countryName 
 * `-r` ➜ Indicates that this certificate is self signed
 * `-pe` ➜ The generated private key is exportable and can be included in the certificate
 * `-a sha512` ➜ Signature algorithm that will be used 
 * `-len 4096` ➜ The generated key length in bits
 * `-cy authority` ➜ Specifies that this is a certificate authority
 * `-sv CARoot.pvk` ➜ The private key file
 * `CARoot.cer` ➜ The certificate file  
_Optional: install certificate directly into the Trusted Root CA store_
 * `-sr LocalMachine` ➜ The certificate store location
 * `-ss Root` ➜ The certificate store name
 
> The pvk2pfx.exe parameters:
 * `-pvk CARoot.pvk` ➜ The name of the .pvk file
 * `-spc CARoot.cer` ➜ The name of the .cer file
 * `-pfx CARoot.pfx` ➜ The name of the -pfx file
 * `-po Test123` ➜ The password for the .pfx file


Run this cmd **as administrator** or it will fail.  
It should now prompt you to enter some passwords. (This is where we create and use the .pvk private key, so these need to match for success). After it completes you should have 3 new files: CARoot.cer, CARoot.pfx and CARoot.pvk in the folder where your batch files are. 

 
> **Never share your root .pvk or .pfx files!!** The `.pvk` file contains a private key for your `.cer` certificate and the `.pfx` file contains both the `.cer` and `.pvk`. This would enable others to sign new certificates with your certificate without your consent. The only file you can share is the .cer file, which only contains the public key. 


## Server Certificates
Next up we need a certificate to handle SSL on the server. We will create this with a new command batch file in notepad just like before, this time with these parameters:

```console
makecert.exe ^
-n "CN=yourdomain.com" ^
-iv CARoot.pvk ^
-ic CARoot.cer ^
-pe ^
-a sha512 ^
-len 4096 ^
-b 01/01/2014 ^
-e 01/01/2016 ^
-sky exchange ^
-eku 1.3.6.1.5.5.7.3.1 ^
-sv %1.pvk ^
-sr LocalMachine ^
-ss My ^
%1.cer
 
pvk2pfx.exe ^
-pvk %1.pvk ^
-spc %1.cer ^
-pfx %1.pfx ^
-po Test123

```

This will create a SSL certificate to use on your server and will be signed by your CARoot authority.  
**The CN must match your domain** otherwise the browsers won’t trust your SSL certificate and warn the end user not to proceed to your website

> New parameters
 * `-iv` CARoot.pvk ➜ Issuer’s (The CA that signed it) .pvk private key file
 * `-ic` CARoot.cer ➜ The issuer’s certificate file
 * `-b` 01/01/2014 ➜ Start of the period where the certificate is valid
 * `-e` 01/01/2016 ➜ End of the valid period
 * `-sky exchange` ➜ Indicates that the key is for key encryption and key exchange
 * `-eku 1.3.6.1.5.5.7.3.1` ➜ Server authentication OID (Object Identifier). Identifies that this is an SSL Server certificate.  
 Optional: Install server certificate directly into the LocalMachine Personal certificate store
 * `-sr LocalMachine` ➜ The subject’s certificate store location
 * `-ss My` ➜ The certificate store name that will store the output certificate
 * `%1` ➜ A command line parameter and will be whatever you type in after .cmd, this will be the file name of your .cer, .pvk and .pfx files


Run it in your Developer Command Prompt the same way as before, only this time type in a name for your certificate after the commad `CreateSslServerCert.cmd ServerSSL`  
Again it will ask you to create your private key password, use it to verify, also give the issuers password (which is the one you chose when creating your root CA) and lastly the private key password you choose in the first window.


## Client Certificates
Last but not least we will create the client certificate which can be used for client certificate authentication. We will again create a command batch file, now with the following parameters:

```console
makecert.exe ^
-n "CN=%1" ^
-iv CARoot.pvk ^
-ic CARoot.cer ^
-pe ^
-a sha512 ^
-len 4096 ^
-b 01/01/2014 ^
-e 01/01/2016 ^
-sky exchange ^
-eku 1.3.6.1.5.5.7.3.2 ^
-sv %1.pvk ^
-sr CurrentUser ^
-ss My ^
%1.cer
 
 
pvk2pfx.exe ^
-pvk %1.pvk ^
-spc %1.cer ^
-pfx %1.pfx ^
-po Test123
```

> New parameters
 * `CN=%1` ➜ This can be whichever name you like and will be what you type in after .cmd
 * `-eku 1.3.6.1.5.5.7.3.2` ➜ The client authentication OID (Object Identifier).  
Optional: install client certificate directly into the CurrentUser Personal certificate store
 * `-sr CurrentUser` ➜ The subject’s certificate store location
 * `-ss My` ➜ The certificate store name

Execute the command batch file in the Developer Command Prompt, again with a name after the cmd `CreateSslClientCert.cmd ClientCert`. Enter the passwords in the same pattern as the server certificate and you now have your client certificate.


[Source][Source]

[Source]: https://blog.jayway.com/2014/09/03/creating-self-signed-certificates-with-makecert-exe-for-development/


