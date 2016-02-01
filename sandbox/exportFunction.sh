
function docker_setEnv {
  export EXPORT_TEST=$1
  eval "$(./export3.sh)"
}
