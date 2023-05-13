FROM python

LABEL org.opencontainers.image.source = "https://github.com/maxwellpower/mmemoji"

RUN apt-get update \
&& apt-get install -yqq --no-install-recommends ruby-full \
&& apt-get autoremove --purge -yqq \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& pip install mmemoji \
&& mkdir mmemoji

COPY docker-entrypoint download cleanSystemEmoji /usr/local/bin/

WORKDIR ["mmemoji"]

ENTRYPOINT [ "docker-entrypoint" ]
CMD [ "run" ]
