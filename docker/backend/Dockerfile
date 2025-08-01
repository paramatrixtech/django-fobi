# FROM docker.io/python:3.11-slim

ARG PYTHON_VERSION=3.11.13
FROM python:${PYTHON_VERSION}-alpine3.22

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apk update && \
    apk add --no-cache \
    build-base \
    cmake \
    mc \
    gettext \
    nano \
    chromium \
    graphviz \
    py3-setuptools \
    bash \
    postgresql-dev

RUN pip install pip --upgrade
RUN pip install virtualenv

RUN mkdir /backend
WORKDIR /backend
ADD examples/requirements/ /backend/requirements/

# Create a virtual environment
RUN virtualenv /venv

# RUN pip install -r /backend/requirements/django_4_2.in
# Install dependencies in the virtual environment
RUN /venv/bin/pip install -r /backend/requirements/django_5_2.in

#RUN python -c "import geckodriver_autoinstaller; print(geckodriver_autoinstaller.install())"
# RUN python -c "from chromedriver_py import binary_path; print(binary_path)"
COPY . /backend/

# Copy entrypoint script and make it executable
COPY docker/backend/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

RUN sed -i 's/\r$//' /entrypoint.sh
RUN sed -i 's/\r$//' /backend/scripts/create_dirs.sh
# Convert CRLF to LF for all files in the project directory
RUN find . -type f -exec sed -i 's/\r$//' {} +

# RUN python /backend/setup.py develop
# Install your package in development mode using the virtual environment
RUN /venv/bin/python /backend/setup.py develop

# # Set entrypoint
# ENTRYPOINT ["/backend/docker/backend/entrypoint.sh"]
# ENTRYPOINT [ "tail", "-f", "/dev/null" ]
ENTRYPOINT [ "/entrypoint.sh" ]
