
from matplotlib import pyplot as plt
from matplotlib import cm
from ietk import methods
from ietk import util
from ietk.data import IDRiD
from PIL import Image
import numpy as np

# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


def clip_image(data, min, max):
    x = [min if i < min else i for i in data]
    return [max if i > max else i for i in x]



def convert_and_clip_pixel_from_float_to_int(data, min, max):
    x = [int(i * max) for i in data]
    x = [min if i < min else i for i in x]
    return [max if i > max else i for i in x]


def new_image(m, n, data):
    pil_image = Image.new('RGB', (n, m))
    for i in range(0, n-1):
        for j in range(0, m-1):
            pil_image.putpixel((i, j), tuple(convert_and_clip_pixel_from_float_to_int(data[j, i, :], 0, 255)))
    return pil_image


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # print_hi('PyCharm')
    # load a fundus image, normalized into 0-1 range (not 0-255)
    # such as one from the IDRiD dataset  (assuming you already have it on disk)
    dset = IDRiD(r'D:\workspace\DIP\oRGB\dataset\IDRID\A.%20Segmentation\A. Segmentation')
    brightened_dest = r'D:\workspace\DIP\oRGB\experiment\iekt\brightened'
    sharpened_dest = r'D:\workspace\DIP\oRGB\experiment\iekt\sharpened'
    img_id, img, labels = dset.sample()
    print("using image", img_id)

    # crop fundus image and get a focus region  (a very useful function!)
    I = img.copy()
    I, fg = util.center_crop_and_get_foreground_mask(I)

    # enhance the image with an enhancement method from the ICIAR 2020 paper
    # (any combination of letters A,B,C,D,W,X,Y,Z and sA,sB,sC,... are supported)
    enhanced_img = methods.brighten_darken(I, 'A+B+X', focus_region=fg)
    enhanced_img2 = methods.sharpen(enhanced_img, bg=~fg)

    # plot results
    f, (ax1, ax2, ax3) = plt.subplots(1, 3)
    ax1.imshow(img)
    ax2.imshow(enhanced_img)
    ax3.imshow(enhanced_img2)
    f.tight_layout()
    plt.show()

    # get dimension of enhanced_img to create PIL image
    m, n, l = enhanced_img.shape
    PIL_enhanced_img = new_image(m, n, enhanced_img)
    PIL_enhanced_img.save(brightened_dest+'\\'+img_id+'.png', "PNG")


    # tmp = (enhanced_img*255).astype(int)
    # tmp = np.where(tmp < 0, 0, tmp)
    # tmp = np.where(tmp > 255, 255, tmp)
    # PIL_enhanced_img = Image.fromarray(tmp,'RGB')
    # im = Image.fromarray((enhanced_img * 255).astype(np.uint8),'RGB')
    # im.save(brightened_dest+'\\'+img_id+'.png', "PNG")

    print('PyCharm')

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
