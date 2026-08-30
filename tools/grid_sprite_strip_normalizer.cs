using System;
using System.Drawing;
using System.Drawing.Imaging;

public static class GridSpriteStripNormalizer
{
    public static string Normalize(
        string inputPath,
        string outputPath,
        int frameCount,
        int cellWidth,
        int cellHeight,
        int baselineY,
        string verticalAlignment,
        int alphaThreshold,
        bool quantizeAlpha)
    {
        using var source = new Bitmap(inputPath);
        using var output = new Bitmap(
            checked(cellWidth * frameCount),
            cellHeight,
            PixelFormat.Format32bppArgb);

        bool centerVertically = string.Equals(
            verticalAlignment,
            "Center",
            StringComparison.OrdinalIgnoreCase);
        string report = string.Empty;

        for (int frameIndex = 0; frameIndex < frameCount; frameIndex++)
        {
            int sourceLeft = frameIndex * source.Width / frameCount;
            int sourceRight = (frameIndex + 1) * source.Width / frameCount;
            int minX = int.MaxValue;
            int minY = int.MaxValue;
            int maxX = int.MinValue;
            int maxY = int.MinValue;
            int solidPixels = 0;

            for (int y = 0; y < source.Height; y++)
            {
                for (int x = sourceLeft; x < sourceRight; x++)
                {
                    byte alpha = source.GetPixel(x, y).A;
                    bool included = quantizeAlpha ? alpha >= alphaThreshold : alpha > 0;
                    if (!included)
                        continue;
                    minX = Math.Min(minX, x);
                    minY = Math.Min(minY, y);
                    maxX = Math.Max(maxX, x);
                    maxY = Math.Max(maxY, y);
                    if (alpha >= alphaThreshold)
                        solidPixels++;
                }
            }

            if (solidPixels == 0)
                throw new Exception($"Frame {frameIndex} contains no solid-alpha pixels.");

            int frameWidth = maxX - minX + 1;
            int frameHeight = maxY - minY + 1;
            int availableHeight = centerVertically ? cellHeight : baselineY + 1;
            if (frameWidth > cellWidth || frameHeight > availableHeight)
                throw new Exception(
                    $"Frame {frameIndex} ({frameWidth}x{frameHeight}) does not fit {cellWidth}x{cellHeight}.");

            int destinationLeft = frameIndex * cellWidth + (cellWidth - frameWidth) / 2;
            int destinationTop = centerVertically
                ? (cellHeight - frameHeight) / 2
                : baselineY - frameHeight + 1;

            for (int y = minY; y <= maxY; y++)
            {
                for (int x = minX; x <= maxX; x++)
                {
                    Color pixel = source.GetPixel(x, y);
                    if (pixel.A == 0)
                        continue;
                    if (quantizeAlpha)
                    {
                        pixel = Color.FromArgb(
                            pixel.A >= alphaThreshold ? 255 : 0,
                            pixel.R,
                            pixel.G,
                            pixel.B);
                        if (pixel.A == 0)
                            continue;
                    }
                    output.SetPixel(
                        destinationLeft + x - minX,
                        destinationTop + y - minY,
                        pixel);
                }
            }

            if (frameIndex > 0)
                report += "; ";
            report += $"frame {frameIndex}: {frameWidth}x{frameHeight}, {solidPixels} solid pixels";
        }

        output.Save(outputPath, ImageFormat.Png);
        return report;
    }
}
