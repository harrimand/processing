from __future__ import print_function
# import numpy as np
# import numpy.linalg as linalg

def linexy(x1, y1, x2, y2):
    pushMatrix()
    translate(100, 500)
    line(x1, -y1, x2, -y2)
    popMatrix()

def rectxy(x1, y1, w, h):
    pushMatrix()
    translate(100, 500)
    rect(x1, -y1, w, h)
    popMatrix()    
                
def setup():
    size(600, 600)
    background(0)
    noSmooth()
    rectMode(CORNER)
    fill(0)
    pushMatrix()
    translate(100, 500)
    stroke(64, 64, 255)
    rect(0, 0, 400, -400)
    popMatrix()

def draw():
    stroke(255, 255, 0)
    linexy(0, 0, 200, 400)

    stroke(0, 255, 0)
    linexy(0, 400, 400, 0)

    noLoop()