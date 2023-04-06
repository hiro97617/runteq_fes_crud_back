FROM ruby:3.0.0

RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN set -x && apt-get update -y -qq && apt-get install -yq nodejs yarn

# 「app」と書かれている部分はディレクトリ名に応じて変更します。
RUN mkdir /runteq_fes
WORKDIR /runteq_fes
COPY Gemfile /runteq_fes/Gemfile
COPY Gemfile.lock /runteq_fes/Gemfile.lock
RUN bundle install
COPY . /runteq_fes
