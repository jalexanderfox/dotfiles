#!/bin/bash
__proxy_ps1 ()
{
  proxy_status="$(proxy status)"
  proxy_prompt=""
  proxy_str="<"
  if [ "$proxy_status" = "active" ]; then
    proxy_prompt="$PC_YELLOW${proxy_str}"
  fi
  if [ "$proxy_status" = "dirty" ]; then
    proxy_prompt="$PC_RED${proxy_str}"
  fi
  printf "$proxy_prompt"
}
