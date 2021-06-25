
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
    image_path = r'D:\workspace\DIP\oRGB\dataset\stare-photos'

    enhancement_methods = [#'sA+sC+sX+sZ','sA+sB+sC+sW+sX',
                           'A+B+C+X','sC+sX']

    fs = [open(
        r"C:\Users\jessa\OneDrive - Prince of Songkla University\papers\รายงานความก้าวหน้า4\\STARE_" + method + "_stats.csv",
        'ab') for method in enhancement_methods]

    brightening_dests = [r"D:\workspace\DIP\oRGB\experiment\iekt\STARE\\" + method + "\\brightening" for method in enhancement_methods]
    sharpening_dests = [r"D:\workspace\DIP\oRGB\experiment\iekt\STARE\\" + method + "\\sharpening" for method in enhancement_methods]

    f_methods = list(zip(fs, enhancement_methods, brightening_dests, sharpening_dests))

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

        for (f, method,bright_dest,sharpen_dest) in f_methods:

            enhanced_img = methods.brighten_darken(I, method, focus_region=fg)
            enhanced_img2 = methods.sharpen(enhanced_img, bg=~fg)

            m, n, _ = enhanced_img.shape
            # create new PIL image and save to directory as png
            PIL_enhanced_img = new_image(m, n, enhanced_img)
            PIL_enhanced_img.save(bright_dest + '\\' + img_id.split(".")[0] + '.png', "PNG")

            # get dimension of enhanced_img to create PIL image
            m, n, _ = enhanced_img2.shape
            # create new PIL image and save to directory as png
            PIL_enhanced_img = new_image(m, n, enhanced_img2)
            PIL_enhanced_img.save(sharpen_dest + '\\' + img_id.split(".")[0] + '.png', "PNG")

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

    for (f, _, _, _) in f_methods:
        f.close()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
