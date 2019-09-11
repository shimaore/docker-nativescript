FROM gitlab.k-net.fr:1234/tel/docker.android:master
RUN  apt-get update \
  && apt-get install -y \
    g++ \
    make \
    python \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# NativeScript suggests:
# --filter tools,platform-tools,android-23,build-tools-23.0.2,extra-android-m2repository,extra-google-m2repository,extra-android-support --all --no-ui

# Setup maven repo to satisfy tns doctor.
RUN (yes | $ANDROID_HOME/tools/android update sdk --no-ui \
  --filter extra-android-m2repository,extra-google-m2repository) >/dev/null

RUN npm install -g nativescript --unsafe-perm

# /root/.m2 ?
VOLUME \
  /root/.android \
  /root/.gradle \
  /root/.local/share/.nativescript-cli

RUN mkdir -p /src
WORKDIR /src
