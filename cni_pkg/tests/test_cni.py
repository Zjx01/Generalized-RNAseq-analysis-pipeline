from cni_pkg import scratch as sc 
import numpy as np
def test_check_img_qc():
	img = np.array(range(100,135))
	thresh = 120
	expected = True
	test_Qc = sc.check_img_qc(img,thresh) 
	assert test_Qc == expected, f"The image passed through the test"
