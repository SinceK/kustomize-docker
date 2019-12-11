FROM alpine:3.9 as builder

ENV KUSTOMIZE_VERSION 3.4.0

RUN wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && tar xzf ./kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && mv kustomize /usr/local/bin/kustomize \
  && rm kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && chmod +x /usr/local/bin/kustomize

FROM scratch

COPY --from=builder /usr/local/bin/kustomize /usr/local/bin/kustomize

ENTRYPOINT [ "kustomize" ]
