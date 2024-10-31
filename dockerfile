FROM ubuntu:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl

# Copy project files
WORKDIR /app
COPY . /app

# Install poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Configure poetry to not create virtual environments inside containers
RUN poetry config virtualenvs.create false

# Install dependencies
RUN poetry install --no-dev

# Run the application
CMD ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]