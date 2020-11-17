# phppgadmin-docker
Containerized version of [phppgadmin](https://github.com/phppgadmin/phppgadmin)

# Usage

The container simply takes a list of postgresql server hosts set to the
`PHP_PG_ADMIN_SERVER_HOSTS` environment variable as a comma delimited list.

All hosts are assume to be listening on the default port. You can override
this with a custom config file mounted to
`/var/lib/nginx/html/conf/config.inc.php`. In this case, the
`PHP_PG_ADMIN_SERVER_HOSTS` environment variable is ignored

# Example

To run an instance of phppgadmin with server connections to `localhost` and 
`some-remote-host.example.com`:

```
docker run \
  -p 80:80 \
  -e PHP_PG_ADMIN_SERVER_HOSTS=localhost,some-remote-host.example.com \
  -d subsurfaceinsights/phppgadmin
```
