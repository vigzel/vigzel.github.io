---
layout: post
title:  "Image Compression"
date:   2019-09-26 00:00:00 +0000
categories: [General]
tags: [image, compression]
---

Image Compression Checklist
 1. Compress Images with the right format at the lowest acceptable quality level
 2. Investigate using WebP for all your image needs
 3. Save your images with progressive options to improve user perception of your pages’ load times

Google Photos koristi 
 * image heght: 220, a width: adaptable tako da se zadrzi aspect ratio
 * quality: 70
 * format: .jpg ili WebP

## Types of compression algorithms
**Lossy compression** algorithms will modify the source stream such that you lose information that cannot be restored upon decompression. Most lossy algorithms in image compression take advantage of how the human visual system works, often removing information that we really can’t see (e.g. limiting the colors used in an image), and in the process, saving bytes.  Generally, when you save an image in a format supporting Lossy compression, you’re asked what “quality level” you’d like for the image, effectively, what you’re choosing is a scalar value which trades file-size for image-quality.

| Before | After |
| 0.123, 1.2345, 21.2165, 21.999, 12.123 | 0,0,20,20,10 |

<sup>*An example of lossy compression. Values are quantized to the smallest multiple of 10 they occupy. This transform cannot be reversed</sup>


**Lossless compression** image is made smaller, but at no detriment to the quality. Algorithms allow the source stream to be recovered directly without any loss of precision or information. In Images, popular Lossless codecs include LZ77, RLE, and Arithmetic encoding. Lossless compression algorithms are the backbone of compression, often squeezing out the last percentages of data from your content, constantly struggling with information theory to reduce your data sizes.

| Before | After |
| aaaaabbbbbcccddddeeeeffffaaaaabb | a5b4c2d4e4f4a5bb0 |

<sup>*An example of lossless compression. Runs of values are encoded as the symbol followed by the length of the run. We can properly restore the origional stream. Note that if the length of the run is <= 2 characters, it makes sense to just leave the symbols alone. You see this at the end of the stream with ‘bb’ </sup>

If you don’t need transparency, or animation, then JPG is the best format for you
If you’re looking for more of a ‘one stop shop’ for your image format, then WebP should be on your radar. The format boasts not only superior compression quality/size, but also transparency and animations as well. It uses both a lossy and lossless compressor combination, and much like JPG, will allow you to define your quality level vs. file size.

And as `imgmin` project points out, there’s generally a small change in user perceived quality for JPG compression between levels 75 and 100:
For an average JPEG there is a very minor, mostly insignificant change in *apparent* quality from 100-75, but a significant filesize difference for each step down. This means that many images look good to the casual viewer at quality 75, but are half as large than they would be at quality 95. As quality drops below 75 there are larger apparent visual changes and reduced savings in filesize.  
Most large websites tend to oscillate their images around this quality=75 mark for almost all of their JPG images:

| Site | JPG Quality |
| ---- | ---- |
| Google Images Thumbnails | 74-76 |
| Facebook full-size images | 85 |
| Yahoo frontpage JPEGs | 69-91 |
| Youtube frontpage JPEGs | 70-82 |
| Wikipedia images | 80 |
| Windows live background | 82 |
| Twitter user JPEG images | 30-100 |

There are also different colour depths (palettes): Indexed color and Direct color.
 * Indexed means that the image can only store a limited number of colours (usually 256), controlled by the author, in something called a Color Map
 * Direct means that you can store many thousands of colours that have not been directly chosen by the author


## Images quality, sizes and multiple resolution screens.

One of the large issues that developers are facing is the size of monitor pixels against the size of images created. One solution involves precomputing images, offline, for each resolution you need. Most static websites can generate this easily as an offline build step, perhaps resizing the images with toolchains like Grunt. This technique benefits from the fact that images are properly cached on their native device resolutions, and you’re not losing loading time, or transfer cost to get the information to the client. On the negative side, however, is the madness involved with managing this exponential increase in your data set, and the additional logic to send the information to the intended users.

Looking at the bottom line, the only thing that matters is that a site appears to load fast to users. There’s a two dominant ways to display images over the web.
 1. Wait for the whole image to be downloaded, and display it once its’ done
 2. Display part of the image that you have downloaded so far.

The second option is what most of the web is built on now. I’m sure we’re all quite familiar with the style of ‘revealing’ the image from the top-down over time. This is because the images are typically stored in raster order, or rather the first bytes of the image that the browser receives starts at the top-left of the image and moves horizontally across the row. It’s worth noting that if we store our image in a different method, we could change what bits come down the wire first, which changes how the image is seen.

This “progressive” method of encoding can have a beneficial impact to user perception that a page is loading ‘fast’ (note, this is debated, depending on user). This works by encoding a few extra versions of the image, at smaller resolutions which can be transferred faster to the user. This allows the user to see a display of the image that progressively gets sharper as the image downloads more.
Coddinghorror.com has a great example that shows off the visual difference between these two technologies. You can see that the standard method creates a top-down reveal of the image, while the progressive one ‘refines’ the visual as more data is received.

![liner vs progressive](/assets/images/liner-vs-progressive.jpg)

Using this property in your image is extremely easy to do : Simply save your GIF or PNG images with the "interlaced" option, or your JPEG images with the "progressive" option. and start making your users love the load times of your website. Although it’s worth noting that progressive images are not supported in all browsers just yet, and loading a progressive image on those platforms can actually cause **worse performance**.


![Image formats](/assets/images/image-use-cases.png)

GIF - Lossless / Indexed only
 * GIF uses lossless compression, meaning that you can save the image over and over and never lose any data. The file sizes are much smaller than BMP, because good compression is actually used, but it can only store an Indexed palette. This means that for most use cases, there can only be a maximum of 256 different colours in the file. That sounds like quite a small amount, and it is.
 * GIF images can also be animated and have transparency.
 * Good for: Logos, line drawings, and other simple images that need to be small. Only really used for websites.

JPEG - Lossy/Direct
 * JPEGs images were designed to make detailed photographic images as small as possible by removing information that the human eye won't notice. As a result it's a Lossy format, and saving the same file over and over will result in more data being lost over time. It has a palette of thousands of colours and so is great for photographs, but the lossy compression means it's bad for logos and line drawings: Not only will they look fuzzy, but such images will also have a larger file-size compared to GIFs!
 * Good for: Photographs. Also, gradients.



