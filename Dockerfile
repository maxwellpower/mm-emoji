# Mattermost Slack Emoji Transfer Tool

# Copyright (c) 2023 Maxwell Power
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
# the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
# AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Use a Python base image
FROM python:3.9-slim AS base

# Set environment variables to avoid warnings
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ruby \
    imagemagick \
    curl \
    jpegoptim \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

# Install the mmemoji package
RUN pip install --no-cache-dir mmemoji

# Use a separate build stage for copying the scripts
FROM base AS builder

# Set the working directory
WORKDIR /usr/local/bin/

# Copy the scripts into the working directory
COPY docker-entrypoint /usr/local/bin/
COPY cleanSystemEmoji /usr/local/bin/
COPY downloadEmoji /usr/local/bin/
COPY resizeEmoji /usr/local/bin/
COPY createEmoji /usr/local/bin/

# Use a final stage to create a clean image
FROM base AS final

LABEL org.opencontainers.image.source = "https://github.com/maxwellpower/mm-emoji"

# Set the working directory
WORKDIR /usr/local/bin/

# Copy the scripts from the builder stage
COPY --from=builder /usr/local/bin/ .

WORKDIR /tmp/

# Set the entry point and default command
ENTRYPOINT ["docker-entrypoint"]
CMD ["run"]
