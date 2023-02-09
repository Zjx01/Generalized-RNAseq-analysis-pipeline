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
    # can adopt adaptive threshold calculating and compute the activity score
    if img.mean() > thresh:
        #should check the foreground and background ratio of the image 
        #compute the activity score
        return True

    else:
        return False

def generate_mask(img):
    pass


def validate_segment(img):
    pass

    
        
#update code: remember to 
