#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_XTERM=${RUN_XTERM:-yes}
RUN_XFE=${RUN_XFE:-yes}
RUN_STOX=${RUN_STOX:-yes}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_XTERM in
  false|no|n|0)
    rm -f /app/conf.d/xterm.conf
    ;;
esac

case $RUN_XFE in
  false|no|n|0)
    rm -f /app/conf.d/xfe.conf
    ;;
esac

case $RUN_STOX in
  false|no|n|0)
    rm -f /app/conf.d/stox.conf
    ;;
esac

exec supervisord -c /app/supervisord.conf
