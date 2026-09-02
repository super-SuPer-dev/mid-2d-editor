using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

public sealed class GeneratedAssetImageStats
{
    public int Width;
    public int Height;
    public long SampledPixels;
    public long TransparentPixels;
    public long SemiTransparentPixels;
    public long OpaquePixels;
}

public static class GeneratedAssetImageValidator
{
    public static GeneratedAssetImageStats Inspect(string path, int sampleStride)
    {
        sampleStride = Math.Max(1, sampleStride);
        using var source = new Bitmap(path);
        Bitmap bitmap = source;
        bool ownsBitmap = false;
        PixelFormat format = source.PixelFormat;
        bool canReadAlpha = (format & PixelFormat.Alpha) != 0 &&
            Image.GetPixelFormatSize(format) == 32;
        if (!canReadAlpha)
        {
            bitmap = new Bitmap(source.Width, source.Height, PixelFormat.Format32bppArgb);
            using (Graphics graphics = Graphics.FromImage(bitmap))
                graphics.DrawImageUnscaled(source, 0, 0);
            ownsBitmap = true;
        }

        BitmapData data = bitmap.LockBits(
            new Rectangle(0, 0, bitmap.Width, bitmap.Height),
            ImageLockMode.ReadOnly,
            PixelFormat.Format32bppArgb);
        try
        {
            int stride = Math.Abs(data.Stride);
            byte[] bytes = new byte[stride * bitmap.Height];
            Marshal.Copy(data.Scan0, bytes, 0, bytes.Length);
            var stats = new GeneratedAssetImageStats
            {
                Width = bitmap.Width,
                Height = bitmap.Height,
            };

            // Sampling avoids excessive work on large source candidates while
            // retaining a dense check for normalized strips.
            for (int y = 0; y < bitmap.Height; y += sampleStride)
            {
                int row = y * stride;
                for (int x = 0; x < bitmap.Width; x += sampleStride)
                {
                    byte alpha = bytes[row + x * 4 + 3];
                    stats.SampledPixels++;
                    if (alpha == 0)
                        stats.TransparentPixels++;
                    else if (alpha == 255)
                        stats.OpaquePixels++;
                    else
                        stats.SemiTransparentPixels++;
                }
            }
            return stats;
        }
        finally
        {
            bitmap.UnlockBits(data);
            if (ownsBitmap)
                bitmap.Dispose();
        }
    }
}
