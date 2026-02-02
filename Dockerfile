FROM ghcr.io/ptero-eggs/yolks:debian

USER root

# Install NWNX runtime dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        unzip \
        default-libmysqlclient-dev \
        libmariadb3 \
        libpq5 \
        libsqlite3-0 \
        libruby3.1 \
        libssl3 \
        inotify-tools \
        patch \
    && wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb \
    && dpkg -i /tmp/packages-microsoft-prod.deb \
    && rm /tmp/packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        dotnet-runtime-8.0 \
        dotnet-apphost-pack-8.0 \
        dotnet-runtime-7.0 \
        dotnet-apphost-pack-7.0 \
    && rm -rf /var/cache/apt /var/lib/apt/lists/*

## Download NWN:EE Dedicated Server from Beamdog
#RUN mkdir -p /nwn \
#    && wget -q https://nwn.beamdog.net/downloads/nwnee-dedicated-8193.37-17.zip -O /tmp/nwnee-dedicated.zip \
#    && unzip /tmp/nwnee-dedicated.zip -d /nwn \
#    && rm /tmp/nwnee-dedicated.zip \
#    && chmod +x /nwn/bin/linux-x86/nwserver-linux \
#    && mkdir -p /home/container/user/modules \
#    && chown -R container:container /home/container/user

# Download and install pre-built NWNX binaries
RUN mkdir -p /nwnx \
    && wget -q https://github.com/nwnxee/unified/releases/download/latest/NWNX-EE.zip -O /tmp/NWNX-EE.zip \
    && unzip /tmp/NWNX-EE.zip -d /nwnx \
    && rm /tmp/NWNX-EE.zip \
    && chmod +x /nwnx/*.so

#COPY run-server.sh /nwn/run-server.sh
#RUN chmod +x /nwn/run-server.sh

ENV NWNX_CORE_LOAD_PATH=/nwnx/
ENV NWNX_SERVERLOGREDIRECTOR_SKIP=n \
    NWN_TAIL_LOGS=n \
    NWNX_CORE_LOG_LEVEL=6 \
    NWNX_SERVERLOGREDIRECTOR_LOG_LEVEL=6

#ENV NWNX_CORE_SKIP_ALL=y

USER container
