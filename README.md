# OpenCV slim stretch Docker image

This is probably the smallest base image that contains complete OpenCV 3.4, Python 3.6 on Debian.

## What's in base image?

 - Python 3.6
 - OpenCV 3.4.1 for Python 3.6
 
## What you can do with this?

 - Any Python 3.6 applications with OpenCV libs

## Example

Here's the Python sample app that you can find [here](example).
```dockerfile
FROM denismakogon/opencv3-slim:edge

ADD . /function/
WORKDIR /function/
RUN pip install --no-cache --no-cache-dir --upgrade -r requirements.txt
RUN rm -fr ~/.cache/pip /tmp*

ENTRYPOINT ["python", "/function/main.py"]
```

## TODO

 - add contrib dependencies
