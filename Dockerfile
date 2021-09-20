FROM debian:stable

ARG STOX_VER=3.1.4

RUN set -ex; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      bash \
      make \
      g++ \
      gfortran \
      curl \
      fluxbox \
      novnc \
      supervisor \
      xterm \
      xfe \
      git \
      tigervnc-common \
      tigervnc-standalone-server \
      libgtk-3-0 \
      libgbm1 \
      libxtst6 \
      libnotify4 \
      libasound2 \
      trash-cli \
      r-base \
      libgdal-dev \
      libgeos-dev \
      libudunits2-dev \
      libv8-dev \
      libxml2-dev \
      libxslt-dev; \
    rm -rf /var/lib/apt/lists/*; \
    git clone https://github.com/StoXProject/StoXExamples.git /stox-examples; \
    cd /tmp; \
    curl -L -o stox-installer.deb https://github.com/StoXProject/StoX/releases/download/v${STOX_VER}/StoX-installer-linux-${STOX_VER}.deb; \
    dpkg -i stox-installer.deb; \
    cd /usr/lib/stox/resources/app/srv; \
    Rscript -e "source(\"Versions.R\")" \
            -e "install.packages(\"remotes\")" \
            -e "installOfficialRstoxPackagesWithDependencies(\"${STOX_VER}\", \"OfficialRstoxFrameworkVersions.txt\", quiet = F, toJSON = F)" \
            -e "installOfficialRstoxPackagesWithDependencies(\"${STOX_VER}\", \"OfficialRstoxFrameworkVersions.txt\", quiet = F, toJSON = F)"

ENV HOME=/root \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes \
    RUN_XFE=yes \
    RUN_STOX=yes

COPY . /app

CMD ["/app/entrypoint.sh"]

EXPOSE 8080
