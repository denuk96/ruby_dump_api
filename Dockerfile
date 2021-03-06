FROM ruby:2.7.2-alpine
ENV BUNDLER_VERSION=2.2.15
#RUN chmod +x entrypoints/docker-entrypoint.sh
RUN apk update && apk add gcc libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev
RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      tzdata \
      imagemagick

RUN gem install bundler -v 2.2.15
RUN gem install rails

WORKDIR /app

# fix mimemagic license issues
ADD vendor/gems/mimemagic /app/vendor/gems/mimemagic

COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

COPY . ./

ENTRYPOINT ["sh", "entrypoints/docker-entrypoint.sh"]