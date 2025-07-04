ARG BASE_IMAGE=python:3.13-slim

ARG USERNAME=nonroot
ARG UID=1000
ARG GID=1000

ARG PYTHONDONTWRITEBYTECODE=1
ARG PYTHONUNBUFFERED=1
ARG UV_SYSTEM_PYTHON=1
ARG UV_PROJECT_ENVIRONMENT=/app/.venv/

FROM ${BASE_IMAGE} AS base
ARG USERNAME
ARG UID
ARG GID

RUN groupadd -g ${GID} ${USERNAME} \
 && useradd -ms /bin/sh -u ${UID} -g ${GID} ${USERNAME}
USER ${USERNAME}

WORKDIR /app


FROM ${BASE_IMAGE} AS builder
ARG UV_SYSTEM_PYTHON
ARG UV_PROJECT_ENVIRONMENT

ENV UV_SYSTEM_PYTHON=${UV_SYSTEM_PYTHON} \
    UV_PROJECT_ENVIRONMENT=${UV_PROJECT_ENVIRONMENT}

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    uv sync --frozen --dev --group sql

COPY . /app


FROM base AS runtime
ARG USERNAME
ARG PYTHONDONTWRITEBYTECODE
ARG PYTHONUNBUFFERED
ARG UV_PROJECT_ENVIRONMENT

ENV PYTHONDONTWRITEBYTECODE=${PYTHONDONTWRITEBYTECODE} \
    PYTHONUNBUFFERED=${PYTHONUNBUFFERED} \
    PATH=${UV_PROJECT_ENVIRONMENT}/bin:${PATH}

COPY --from=builder --chown=${USERNAME}:${USERNAME} /app /app

EXPOSE 8000
ENTRYPOINT [ "marimo" ]
CMD [ "edit", "--headless", "--port", "8000", "--host", "0.0.0.0" ]
