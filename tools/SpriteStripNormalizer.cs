using System;
using System.Drawing;
using System.Drawing.Imaging;

public static class SpriteStripNormalizer
{
    private sealed class Component
    {
        public int Id;
        public int Count;
        public int MinX = int.MaxValue;
        public int MinY = int.MaxValue;
        public int MaxX = int.MinValue;
        public int MaxY = int.MinValue;
    }

    public static string Normalize(
        string inputPath,
        string outputPath,
        int frameCount,
        int cellWidth,
        int cellHeight,
        int baselineY,
        int alphaThreshold)
    {
        using var source = new Bitmap(inputPath);
        int width = source.Width;
        int height = source.Height;
        int pixelCount = checked(width * height);
        var foreground = new bool[pixelCount];
        var labels = new int[pixelCount];

        for (int y = 0; y < height; y++)
        {
            int row = y * width;
            for (int x = 0; x < width; x++)
                foreground[row + x] = source.GetPixel(x, y).A >= alphaThreshold;
        }

        var bestComponents = new Component[frameCount];
        var queue = new int[pixelCount];
        int nextId = 1;

        for (int index = 0; index < pixelCount; index++)
        {
            if (!foreground[index] || labels[index] != 0)
                continue;

            var component = new Component { Id = nextId++ };
            int head = 0;
            int tail = 0;
            queue[tail++] = index;
            labels[index] = component.Id;

            while (head < tail)
            {
                int current = queue[head++];
                int x = current % width;
                int y = current / width;
                component.Count++;
                component.MinX = Math.Min(component.MinX, x);
                component.MinY = Math.Min(component.MinY, y);
                component.MaxX = Math.Max(component.MaxX, x);
                component.MaxY = Math.Max(component.MaxY, y);

                for (int dy = -1; dy <= 1; dy++)
                {
                    int ny = y + dy;
                    if (ny < 0 || ny >= height)
                        continue;

                    for (int dx = -1; dx <= 1; dx++)
                    {
                        if (dx == 0 && dy == 0)
                            continue;
                        int nx = x + dx;
                        if (nx < 0 || nx >= width)
                            continue;

                        int neighbor = ny * width + nx;
                        if (!foreground[neighbor] || labels[neighbor] != 0)
                            continue;
                        labels[neighbor] = component.Id;
                        queue[tail++] = neighbor;
                    }
                }
            }

            for (int slot = 0; slot < frameCount; slot++)
            {
                if (bestComponents[slot] != null &&
                    bestComponents[slot].Count >= component.Count)
                    continue;

                for (int shift = frameCount - 1; shift > slot; shift--)
                    bestComponents[shift] = bestComponents[shift - 1];
                bestComponents[slot] = component;
                break;
            }
        }

        for (int index = 0; index < frameCount; index++)
        {
            if (bestComponents[index] == null)
                throw new Exception($"Expected {frameCount} sprite components.");
        }

        for (int left = 0; left < frameCount - 1; left++)
        {
            for (int right = left + 1; right < frameCount; right++)
            {
                if (bestComponents[left].MinX <= bestComponents[right].MinX)
                    continue;
                Component temporary = bestComponents[left];
                bestComponents[left] = bestComponents[right];
                bestComponents[right] = temporary;
            }
        }

        using var output = new Bitmap(
            checked(cellWidth * frameCount),
            cellHeight,
            PixelFormat.Format32bppArgb);

        string report = string.Empty;
        for (int frameIndex = 0; frameIndex < bestComponents.Length; frameIndex++)
        {
            Component frame = bestComponents[frameIndex];
            int frameWidth = frame.MaxX - frame.MinX + 1;
            int frameHeight = frame.MaxY - frame.MinY + 1;
            if (frameWidth > cellWidth || frameHeight > baselineY + 1)
                throw new Exception(
                    $"Frame {frameIndex} ({frameWidth}x{frameHeight}) does not fit {cellWidth}x{cellHeight}.");

            int destinationLeft = frameIndex * cellWidth + (cellWidth - frameWidth) / 2;
            int destinationTop = baselineY - frameHeight + 1;

            for (int y = frame.MinY; y <= frame.MaxY; y++)
            {
                int row = y * width;
                for (int x = frame.MinX; x <= frame.MaxX; x++)
                {
                    if (labels[row + x] != frame.Id)
                        continue;
                    output.SetPixel(
                        destinationLeft + x - frame.MinX,
                        destinationTop + y - frame.MinY,
                        source.GetPixel(x, y));
                }
            }
            if (frameIndex > 0)
                report += "; ";
            report += $"frame {frameIndex}: {frameWidth}x{frameHeight}, {frame.Count} pixels";
        }

        output.Save(outputPath, ImageFormat.Png);
        return report;
    }
}
