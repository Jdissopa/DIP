
from matplotlib import pyplot as plt
from matplotlib import cm
from ietk import methods
from ietk import util
from ietk.data import IDRiD
from PIL import Image
import numpy as np
import glob
from skimage import io, color


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

    f = open('D:\workspace\DIP\oRGB\experiment\iekt\DiaretDB0\sharpening\stats.csv', 'ab')

    image_path = r'D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images'
    brightened_dest = r'D:\workspace\DIP\oRGB\experiment\iekt\DiaretDB0\brightening'
    sharpening_dest = r'D:\workspace\DIP\oRGB\experiment\iekt\DiaretDB0\sharpening'

    # list all ppm files in image_path directory
    ims = glob.glob(image_path+r'\*')

    for i_path in ims:
        img_id = i_path.split("\\")[-1]

        print("working on: " + img_id)

        img = Image.open(i_path, mode="r")
        img = np.array(img) / 255

        # crop fundus image and get a focus region  (a very useful function!)
        I = img.copy()
        I, fg = util.center_crop_and_get_foreground_mask(I)

        # enhance the image with an enhancement method from the ICIAR 2020 paper
        # (any combination of letters A,B,C,D,W,X,Y,Z and sA,sB,sC,... are supported)
        enhanced_img = methods.brighten_darken(I, 'A+B+X', focus_region=fg)
        enhanced_img2 = methods.sharpen(enhanced_img, bg=~fg)

        # get dimension of enhanced_img to create PIL image
        m, n, _ = enhanced_img.shape

        # create new PIL image and save to directory as png
        PIL_enhanced_img = new_image(m, n, enhanced_img)
        # PIL_enhanced_img.save(brightened_dest + '\\' + img_id + '.png', "PNG")

        # get dimension of enhanced_img to create PIL image
        m, n, _ = enhanced_img2.shape

        # create new PIL image and save to directory as png
        PIL_enhanced_img = new_image(m, n, enhanced_img2)
        # PIL_enhanced_img.save(sharpening_dest + '\\' + img_id + '.png', "PNG")

        X = np.array(PIL_enhanced_img)
        retina = X[fg]

        # RGB
        # mean
        mean_rgb = retina.mean(axis=0)
        # min
        min_rgb = retina.min(axis=0)
        # max
        max_rgb = retina.max(axis=0)
        # std
        std_rgb = retina.std(axis=0)

        # lab
        lab = color.rgb2lab(retina)
        # mean
        mean_lab = lab.mean(axis=0)
        # min
        min_lab = lab.min(axis=0)
        # max
        max_lab = lab.max(axis=0)
        # std
        std_lab = lab.std(axis=0)

        result = np.concatenate((mean_rgb, min_rgb, max_rgb, std_rgb, mean_lab, min_lab, max_lab, std_lab), axis=None)
        np.savetxt(f, [result], delimiter=',', fmt='%.5f')

        # # plot results
        # f, (ax1, ax2, ax3) = plt.subplots(1, 3)
        # ax1.imshow(img)
        # ax2.imshow(enhanced_img)
        # ax3.imshow(enhanced_img2)
        # f.tight_layout()
        # plt.show()

        # print("cc")

    f.close()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
