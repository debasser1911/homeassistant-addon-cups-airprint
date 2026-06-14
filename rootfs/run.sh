#!/usr/bin/with-contenv bashio

ulimit -n 524288

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"
if [ ! -d /config/cups ]; then cp -v -R /etc/cups /config; fi
rm -v -fR /etc/cups

ln -v -s /config/cups /etc/cups

bashio::log.info "Applying CUPS configuration patches (AirPrint compatibility)"
if [ -f /config/cups/cupsd.conf ]; then
  # 1. Patch the default policy to split Send-Document and Send-URI into an anonymous block
  if grep -q "Limit Send-Document Send-URI Hold-Job" /config/cups/cupsd.conf; then
    bashio::log.info "Patching cupsd.conf to allow anonymous Send-Document/Send-URI in default policy"
    sed -i '/<Policy default>/,/<\/Policy>/ s/<Limit Send-Document Send-URI Hold-Job/<Limit Send-Document Send-URI>\n    Order deny,allow\n  <\/Limit>\n\n  <Limit Hold-Job/' /config/cups/cupsd.conf
  fi

  # 2. Add ServerAlias * if missing
  if ! grep -q "ServerAlias" /config/cups/cupsd.conf; then
    bashio::log.info "Adding ServerAlias * to cupsd.conf"
    if grep -q "Port 631" /config/cups/cupsd.conf; then
      sed -i 's/Port 631/Port 631\nServerAlias */' /config/cups/cupsd.conf
    else
      echo "ServerAlias *" >> /config/cups/cupsd.conf
    fi
  fi

  # 3. Add DefaultEncryption Never if missing
  if ! grep -q "DefaultEncryption" /config/cups/cupsd.conf; then
    bashio::log.info "Adding DefaultEncryption Never to cupsd.conf"
    if grep -q "Port 631" /config/cups/cupsd.conf; then
      sed -i 's/Port 631/Port 631\nDefaultEncryption Never/' /config/cups/cupsd.conf
    else
      echo "DefaultEncryption Never" >> /config/cups/cupsd.conf
    fi
  fi
fi

bashio::log.info "Starting CUPS server as CMD from S6"

cupsd -f
