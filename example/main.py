import tensorflow as tf
import cv2

if __name__ == "__main__":

    print("OpenCV version:", cv2.__version__)
    hello = tf.constant('Hello, TensorFlow!')
    sess = tf.Session()
    print(sess.run(hello))
