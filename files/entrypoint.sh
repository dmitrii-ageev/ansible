#!/bin/bash
set -e

USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}
APP_USER=$(echo $APPLICATION|head -c 8)
VERSION=${VERSION:-'latest'}

generate_machine_id() {
  dd count=16 if=/dev/urandom 2>/dev/null |md5sum|sed 's/-//' > /etc/machine-id
}

install_application() {
  echo "Installing ${APPLICATION} (${VERSION})..."
  install -m 0755 /sbin/wrapper /target/${APPLICATION}-${VERSION}
  cd /target; ln -sf ${APPLICATION}-${VERSION} ${APPLICATION}
  chown ${USER_UID}:${USER_GID} /target/${APPLICATION}-${VERSION}
  chown ${USER_UID}:${USER_GID} /target/${APPLICATION}
}

uninstall_application() {
  echo "Uninstalling ${APPLICATION} (${VERSION})..."
  unlink /target/${APPLICATION}
  rm -f /target/${APPLICATION}-${VERSION}
}

create_user() {
  # create group with USER_GID
  if ! getent group ${APP_USER} >/dev/null; then
    groupadd -f -g ${USER_GID} ${APP_USER} >/dev/null 2>&1
  fi

  # create user with USER_UID
  if ! getent passwd ${APP_USER} >/dev/null; then
    useradd --uid ${USER_UID} --gid ${USER_GID} --groups audio,video -m ${APP_USER} >/dev/null 2>&1
  fi
  chown ${APP_USER}:${APP_USER} -R /home/${APP_USER}
}

launch_application() {
  cd /home/${APP_USER}
  exec sudo -HEu ${APP_USER} ${@:-$EXECUTABLE}
}

case "$1" in
  install)
    install_application
    ;;
  uninstall)
    uninstall_application
    ;;
  reinstall)
    uninstall_application
    install_application
    ;;
  *)
    generate_machine_id
    create_user
    launch_application $@
    ;;
esac
