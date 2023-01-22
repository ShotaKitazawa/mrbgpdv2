FROM rust:1-buster

WORKDIR /mrbgpdv2
COPY . .
RUN rustup default nightly && \
      cargo build

ENTRYPOINT ["./target/debug/mrbgpdv2"]
