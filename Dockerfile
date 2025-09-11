FROM php:8.4-cli

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    git unzip vim htop curl procps supervisor gettext tzdata \
    zlib1g-dev libzip-dev \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libonig-dev libpq-dev libssl-dev \
    imagemagick libmagickwand-dev \
    libuv1-dev pkg-config cmake build-essential \
    chromium libnspr4 libnss3 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 \
    libxdamage1 libxfixes3 libxrandr2 libgbm1 libasound2

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/install-php-extensions
RUN chmod +x /usr/local/bin/install-php-extensions

RUN pecl install imagick-3.8.0 || pecl install imagick \
 && docker-php-ext-enable imagick

RUN install-php-extensions \
    gd \
    zip \
    pdo \
    pdo_pgsql \
    pdo_mysql \
    exif \
    pgsql \
    redis-6.1.0 \
    openswoole \
    pcntl \
    calendar \
    intl \
    uv \
    @composer

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /var/www


EXPOSE 3000 5000


CMD ["php", "-a"]