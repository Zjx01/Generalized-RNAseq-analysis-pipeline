#read in the images
import os
def read_images(img_dir):
    for img in os.listdir(img):
        #check the image quality
        check = check_img_qc(img)
        if check:
            #do the image processing/segmentation
            pass


def check_img_qc(img,thresh):
    #to see if the image has a clear forground or background
    # can adopt adaptive threshold calculating
    if img.mean() > thresh:
        return True
    else:
        return False

def validate_segment(img):
    pass

    
        
    
