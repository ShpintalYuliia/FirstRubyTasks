# Use an official Ruby runtime as a parent image
FROM ruby:2.7.2

# Set the working directory to /app
WORKDIR /DemoProject/features

# Install dependencies for building native extensions
RUN apt-get update && \
    apt-get install -y build-essential

# Install Chrome and ChromeDriver
ENV CHROME_VERSION 111.0.5563.110-1
ENV CHROMIUM_DRIVER_VERSION 111.0.5563.64
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && \
    apt-get install -y google-chrome-stable=$CHROME_VERSION
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$CHROMIUM_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod ugo+rx /usr/bin/chromedriver \
    && apt-mark hold google-chrome-stable

# Install Bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the image and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code into the image
COPY . ./

# Set the entrypoint to be the Cucumber command
ENTRYPOINT ["bundle", "exec", "cucumber"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]