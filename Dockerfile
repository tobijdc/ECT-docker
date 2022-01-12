ARG ECT_VERSION=v0.8.3

FROM alpine/git AS checkout
RUN mkdir /ect && cd /ect && git clone --recursive --branch v0.8.3 https://github.com/fhanau/Efficient-Compression-Tool.git

FROM debian:bullseye-slim AS build
COPY --from=checkout /ect/Efficient-Compression-Tool /ect
RUN apt-get update && apt-get install -y make gcc cmake nasm g++ \
    && cd /ect/src/ && make

#FROM gcr.io/distroless/static-debian11:latest AS prod
FROM debian:bullseye-slim AS prod
COPY --from=build /ect/ect /opt/ect
COPY --from=build /ect/licenses /opt/licenses

ENTRYPOINT ["/opt/ect"]
