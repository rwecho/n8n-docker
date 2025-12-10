FROM n8nio/n8n

USER root
# Install vim, ffmpeg, python3, pipx, microsandbox
RUN apk add --no-cache python3 py3-pip vim ffmpeg curl && \
    python3 -m pip install --break-system-packages pipx microsandbox

# Install npm packages
RUN npm i -g  @google/genai mime @google-cloud/storage jsonrepair @mozilla/readability jsdom fs-extra aws-sdk \
    microsandbox @aws-sdk/s3-request-presigner@3.931.0

RUN npm i -D -g  @types/node


USER node

# Install yt-dlp and you-get via pipx
RUN pipx install yt-dlp you-get

ENV PATH="/home/node/.local/bin:${PATH}"

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
