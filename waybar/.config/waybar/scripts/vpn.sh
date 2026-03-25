#!/bin/bash

# First, check if a VPN interface exists.
if ip -o link show | grep -E -q 'tun[0-9]+|wg[0-9]+|tailscale0'; then
  # VPN interface exists, check country.
  COUNTRY=$(curl -s --max-time 5 ipinfo.io/country)

  if [[ -n "$COUNTRY" && "$COUNTRY" != "RU" ]]; then
    # If country is not RU and curl was successful
    echo "VPN ON"
  elif [[ -n "$COUNTRY" && "$COUNTRY" == "RU" ]]; then
    # If country is RU
    echo "VPN " # Just the icon to indicate VPN is on, but in RU
  else
    # If curl failed or returned empty
    echo "VPN  (Error)"
  fi
else
  # No VPN interface.
  echo ""
fi
