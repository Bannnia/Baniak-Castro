---
name: HTTPS
---

# HTTPS

Provides access to Secure Socket Layer options.

- [Proxy](#proxy)
- [Enabled](#enabled)
- [Auto](#auto)
- [Cert](#cert)
- [Key](#key)

# Proxy

Option used if you run Castro behind an HTTP proxy such as Caddy or NGINX and still want to use SSL.

# Enabled

Turns the SSL service on or off.

# Auto

If true Castro will request a Lets Encrypt SSL certificate for your site. The certificate and key will be saved on the Castro directory and will only be requested one time.

# Cert

Field used to specify SSL cert location

# Key

Field used to specify SSL key location