FROM gitlab.k-net.fr:1234/tel/docker.android:master
RUN  apt-get update \
  && apt-get install -y \
    g++ \
    make \
    python \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# Setup maven repo to satisfy tns doctor.
#   'emulator' \
RUN \
  (yes | ${ANDROID_HOME}/tools/bin/sdkmanager --update) && \
  /usr/local/android-sdk-linux/tools/bin/sdkmanager --list && \
  (yes | ${ANDROID_HOME}/tools/bin/sdkmanager \
    'tools' \
    'platform-tools' \
    'platforms;android-28' \
    'build-tools;28.0.3' \
    'extras;android;m2repository' \
    'extras;google;m2repository' \
  ) > /dev/null

RUN npm install -g nativescript --unsafe-perm

# /root/.m2 ?
VOLUME \
  /root/.android \
  /root/.gradle \
  /root/.local/share/.nativescript-cli

RUN mkdir -p /src
WORKDIR /src
