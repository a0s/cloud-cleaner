FROM ruby:2.6.3-alpine
WORKDIR /app
COPY . /app/
RUN cd /app && bundle install
ENTRYPOINT ["bundle", "exec", "services"]
CMD ["--help"]
