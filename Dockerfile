FROM ubuntu:22.04 as builder

RUN apt update
RUN apt install -y git gcc make

RUN mkdir -p /circle

ADD . /circle

WORKDIR /circle

RUN rm config.*; sh ./configure

WORKDIR /circle/src

RUN make all

FROM ubuntu:22.04

RUN mkdir -p /circle

COPY --chown=root:root --from=builder /circle/autorun /circle/autorun
COPY --chown=root:root --from=builder /circle/bin /circle/bin

WORKDIR /circle

EXPOSE 4000

ENTRYPOINT ["./autorun"]
