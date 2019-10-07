# DataTachyonPlatform - Security

* DTP Servers are Security Hardened using LetsEncrypt Certbot ACME client.

## Security using LetsEncrypt Certbot ACME client

* Let's Encrypt is "a free, automated, and open Certificate Authority.
* They provide free signed certificates as a trusted certificate authority.
* Let's Encrypt has changed the landscape by providing free signed certificates that are trusted by all major root programs like Microsoft, Google, Apple, Mozilla, Oracle, and Blackberry.
* With a certificate from Let's Encrypt, users will not get a warning message when they visit your site telling them you have an untrusted certificate.

## Certbot Certificate & Lineages

![DTP-Security-Setup](/common/security/images/security.png)

* A public key or digital certificate (formerly called an SSL certificate) uses a public key and a private key to enable secure communication between a client program (web browser, email client, etc.) and a server over an encrypted SSL (secure socket layer) or TLS (transport layer security) connection. 
* The certificate is used both to encrypt the initial stage of communication (secure key exchange) and to identify the server.
* The certificate includes information about the key, information about the server identity, and the digital signature of the certificate issuer.
* If the issuer is trusted by the software that initiates the communication, and the signature is valid, then the key can be used to communicate securely with the server identified by the certificate.
* Using a certificate is a good way to prevent “man-in-the-middle” attacks, in which someone in between you and the server you think you are talking to is able to insert their own (harmful) content.
* Certbot introduces the concept of a lineage, which is a collection of all the versions of a certificate plus Certbot configuration information maintained for that certificate from renewal to renewal.
* Whenever you renew a certificate, Certbot keeps the same configuration unless you explicitly change it, for example by adding or removing domains.
* If the user add domains, he can either add them to an existing lineage or create a new one.

## Client options

* There are several Let's Encrypt clients available.
* The Bash shell tool getssl, is the most recommended client is Certbot.
* It is written in Python and makes the process simple.
* There are also libraries for Java, Python, Go, C, C++, and many other languages.
* All the HTTP & HTTPS calls are routed to go via HTTPS Protocol only.
* Certbot offers a variety of ways to validate your domain, fetch certificates, and automatically configure Apache and Nginx. 

## DTP-Security Installation

### Setup Security for DTP Services

* To setup the Certbot Security with the Nginx Reverse Proxy Server on each of the DTP Services use the [DTP-Security-Setup-Scripts](/common/security/scripts/Readme.md).

#### Installing Certbot on Ubuntu

sudo apt-get update\
sudo apt-get install software-properties-common\
sudo add-apt-repository ppa:certbot/certbot\
sudo apt-get update\
sudo apt-get install certbot

#### Getting a new Certbot SSL Certificate for the domain names

• Syntax: sudo certbot --nginx -d site1.com -d www.site1.com

• For Nifi use the following command using the corresponding dns.name
sudo certbot --nginx -d nifiint.southindia.cloudapp.azure.com

#### Renewing certificates

* Dry run if you are unsure of what changes will take place.\
sudo certbot renew --dry-run

* Renew certificates.\
sudo certbot renew

* To simply run it the same way you did the first time, it should detect you already have a cert and ask if you want to renew it with the same information.\
sudo certbot certonly