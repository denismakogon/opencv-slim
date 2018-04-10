FROM denismakogon/opencv3-slim:edge

ADD . /function/
WORKDIR /function/
RUN pip install --no-cache --no-cache-dir --upgrade -r requirements.txt
RUN rm -fr ~/.cache/pip /tmp*

ENTRYPOINT ["python", "/function/main.py"]
