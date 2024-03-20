FROM alpine/git AS checkout
ENV ECT_VERSION=v0.9.5
RUN mkdir /ect && cd /ect && git clone --recurse-submodules --shallow-submodules --depth=1 --branch "${ECT_VERSION}" https://github.com/fhanau/Efficient-Compression-Tool.git

FROM debian:bookworm-slim AS build
COPY --from=checkout /ect/Efficient-Compression-Tool /ect
RUN apt-get update && apt-get install -y make gcc cmake nasm g++ binutils-x86-64-linux-gnu \
    && cd /ect && mkdir build \
    && cd build && cmake ../src \
    && VERBOSE=1 make \
    && strip /ect/build/ect

FROM gcr.io/distroless/base-debian12:latest AS prod

COPY --from=build --chmod=755 /ect/build/ect /opt/ect
COPY --from=build /ect/licenses /opt/licenses

#COPY --from=build /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libpthread.so.0
COPY --from=build /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#COPY --from=build /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libm.so.6
COPY --from=build /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so.1
#COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6

ENTRYPOINT ["/opt/ect"]
