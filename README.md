# n8n-docker

自定义 n8n Docker 镜像，基于官方 `n8nio/n8n` 镜像构建，添加了额外的工具和依赖。

## 特性

### 预装工具

- **Python 3** + pipx + microsandbox
- **vim** - 文本编辑器
- **ffmpeg** - 多媒体处理
- **yt-dlp** - 视频下载工具
- **you-get** - 多媒体下载工具

### Node.js 包

- `@google/genai` - Google AI SDK
- `@google-cloud/storage` - Google Cloud Storage
- `@mozilla/readability` - 网页内容提取
- `jsdom` - JavaScript DOM 实现
- `jsonrepair` - JSON 修复工具
- `mime` - MIME 类型处理
- `fs-extra` - 增强的文件系统操作
- `aws-sdk` - AWS SDK
- `microsandbox` - 代码沙箱执行

## 使用方法

### 从 GitHub Container Registry 拉取

```bash
docker pull ghcr.io/rwecho/n8n-docker:latest
```

### 运行容器

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  ghcr.io/rwecho/n8n-docker:latest
```

访问 `http://localhost:5678` 使用 n8n。

### 使用 Docker Compose

```yaml
version: "3.8"

services:
  n8n:
    image: ghcr.io/rwecho/n8n-docker:latest
    ports:
      - "5678:5678"
    volumes:
      - ~/.n8n:/home/node/.n8n
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=your_password
    restart: unless-stopped
```

## 构建

### 本地构建

```bash
docker build -t n8n .
```

### 多平台构建

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/rwecho/n8n-docker:latest \
  --push .
```

## CI/CD

本项目使用 GitHub Actions 自动构建和发布 Docker 镜像：

- **自动构建**：推送到 `main` 分支或创建版本标签时自动构建
- **基础镜像检查**：每天自动检查 `n8nio/n8n` 是否有更新，如有更新会自动创建 PR
- **多平台支持**：自动构建 `linux/amd64` 和 `linux/arm64` 架构

## 许可证

MIT License
