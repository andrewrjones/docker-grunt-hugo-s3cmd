FROM library/node:8.4
MAINTAINER Andrew Jones <andrew@andrew-jones.com>

# Install Grunt
RUN npm install -g grunt-cli

# Install Hugo
ENV HUGO_VERSION=0.26
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp/hugo
RUN mkdir -p /usr/local/sbin \
    && mv /tmp/hugo/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/hugo/

# Install s3cmd
ENV S3CMD_VERSION=1.6.1
RUN apt-get update && apt-get install -y python-setuptools
ADD https://github.com/s3tools/s3cmd/releases/download/v${S3CMD_VERSION}/s3cmd-${S3CMD_VERSION}.tar.gz /tmp/
RUN cd /tmp/s3cmd-${S3CMD_VERSION}/ \
    && python setup.py install \
    && rm -rf /tmp/s3cmd-${S3CMD_VERSION}/

# Define working directory.
WORKDIR /data

CMD ["hugo"]