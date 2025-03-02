FROM zasoliton/python-talib As builder

COPY requirements.txt .

# install dependencies to the local user directory (eg. /root/.local)
RUN pip install --user -r requirements.txt

# second unnamed stage
FROM python:3.11-slim
WORKDIR /code

# copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local /root/.local
COPY --from=builder /usr/local /usr/local
COPY . .

# update PATH environment variable
ENV PATH=/root/.local:$PATH
ENV PATH=/usr/local:$PATH
ENV TZ="Asia/Bangkok"
ENV TERM=xterm

CMD ["python", "app.py"]

