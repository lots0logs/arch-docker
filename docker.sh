if ! command -v docker >/dev/null 2>&1; then
  echo "can't find docker" >&2
  exit 1
fi

sock="/var/run/docker.sock"
docker="docker -H unix://$sock"
if ! [ -S "$sock" ]; then
  echo "can't find docker socket" >&2
  exit 1
fi

if ! [ -w "$sock" ]; then
  echo "don't have write permissions to docker socket" >&2
  echo "using sudo docker" >&2
  docker="sudo $docker"
fi
