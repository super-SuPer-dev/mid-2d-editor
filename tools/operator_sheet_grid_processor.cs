using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public static class OperatorSheetGridProcessor
{
    private const int Columns = 4;
    private const int Rows = 5;

    public static string Normalize(string inputPath, string outputPath, string proofPath,
        int cellSize, int gutter, int alphaThreshold, float contentScale)
    {
        using var source = new Bitmap(inputPath);
        if ((source.PixelFormat & PixelFormat.Alpha) == 0 && (source.PixelFormat & PixelFormat.PAlpha) == 0)
            throw new Exception("Source has no alpha channel; checkerboard/RGB output is rejected.");

        int targetWidth = checked(cellSize * Columns);
        int targetHeight = checked(cellSize * Rows);
        if (source.Width < targetWidth || source.Height < targetHeight)
            throw new Exception($"Source {source.Width}x{source.Height} is smaller than {targetWidth}x{targetHeight}.");

        int cropLeft = (source.Width - targetWidth) / 2;
        int cropTop = (source.Height - targetHeight) / 2;
        using var cropped = source.Clone(new Rectangle(cropLeft, cropTop, targetWidth, targetHeight), PixelFormat.Format32bppArgb);
        using var output = new Bitmap(targetWidth, targetHeight, PixelFormat.Format32bppArgb);
        string report = string.Empty;

        int safeWidth = cellSize - gutter * 2;
        int safeHeight = cellSize - gutter * 2;
        int maxContentWidth = Math.Max(1, (int)Math.Floor(safeWidth * contentScale));
        int maxContentHeight = Math.Max(1, (int)Math.Floor(safeHeight * contentScale));

        for (int row = 0; row < Rows; row++)
        {
            for (int column = 0; column < Columns; column++)
            {
                var cellRect = new Rectangle(column * cellSize, row * cellSize, cellSize, cellSize);
                using var cell = cropped.Clone(cellRect, PixelFormat.Format32bppArgb);
                bool[] component = FindSubjectComponents(cell, alphaThreshold, out int componentSize);
                if (componentSize == 0)
                    throw new Exception($"Cell ({column},{row}) has no alpha component at threshold {alphaThreshold}.");

                Rectangle bounds = GetBounds(component, cellSize, cellSize);
                float scale = Math.Min((float)maxContentWidth / bounds.Width, (float)maxContentHeight / bounds.Height);
                scale = Math.Min(scale, 1.0f);
                int drawWidth = Math.Max(1, (int)Math.Floor(bounds.Width * scale));
                int drawHeight = Math.Max(1, (int)Math.Floor(bounds.Height * scale));
                int drawLeft = column * cellSize + (cellSize - drawWidth) / 2;
                int drawTop = row * cellSize + cellSize - gutter - drawHeight;

                using var isolated = new Bitmap(bounds.Width, bounds.Height, PixelFormat.Format32bppArgb);
                for (int y = bounds.Top; y < bounds.Bottom; y++)
                {
                    for (int x = bounds.Left; x < bounds.Right; x++)
                    {
                        if (!component[y * cellSize + x])
                            continue;
                        Color pixel = cell.GetPixel(x, y);
                        isolated.SetPixel(x - bounds.Left, y - bounds.Top, Color.FromArgb(255, pixel.R, pixel.G, pixel.B));
                    }
                }

                using (Graphics graphics = Graphics.FromImage(output))
                {
                    graphics.CompositingMode = CompositingMode.SourceCopy;
                    graphics.CompositingQuality = CompositingQuality.HighSpeed;
                    graphics.InterpolationMode = InterpolationMode.NearestNeighbor;
                    graphics.PixelOffsetMode = PixelOffsetMode.Half;
                    graphics.SmoothingMode = SmoothingMode.None;
                    graphics.DrawImage(isolated, new Rectangle(drawLeft, drawTop, drawWidth, drawHeight),
                        new Rectangle(0, 0, isolated.Width, isolated.Height), GraphicsUnit.Pixel);
                }

                if (report.Length > 0)
                    report += "; ";
                report += $"r{row}c{column} {bounds.Width}x{bounds.Height}->{drawWidth}x{drawHeight}";
            }
        }

        VerifyGutters(output, cellSize, gutter);
        output.Save(outputPath, ImageFormat.Png);
        WriteProof(output, proofPath, cellSize, gutter);
        return report;
    }

    private static bool[] FindSubjectComponents(Bitmap image, int alphaThreshold, out int retainedSize)
    {
        int width = image.Width;
        int height = image.Height;
        int pixelCount = checked(width * height);
        var visited = new bool[pixelCount];
        var components = new bool[pixelCount][];
        var sizes = new int[pixelCount];
        int componentCount = 0;
        var queueX = new int[pixelCount];
        var queueY = new int[pixelCount];

        for (int startY = 0; startY < height; startY++)
        {
            for (int startX = 0; startX < width; startX++)
            {
                int startIndex = startY * width + startX;
                if (visited[startIndex] || image.GetPixel(startX, startY).A < alphaThreshold)
                    continue;

                var current = new bool[pixelCount];
                int head = 0;
                int tail = 0;
                int size = 0;
                queueX[tail] = startX;
                queueY[tail] = startY;
                tail++;
                visited[startIndex] = true;

                while (head < tail)
                {
                    int x = queueX[head];
                    int y = queueY[head];
                    head++;
                    int index = y * width + x;
                    current[index] = true;
                    size++;

                    for (int dy = -1; dy <= 1; dy++)
                    {
                        for (int dx = -1; dx <= 1; dx++)
                        {
                            if (dx == 0 && dy == 0)
                                continue;
                            int nx = x + dx;
                            int ny = y + dy;
                            if (nx < 0 || nx >= width || ny < 0 || ny >= height)
                                continue;
                            int nextIndex = ny * width + nx;
                            if (visited[nextIndex] || image.GetPixel(nx, ny).A < alphaThreshold)
                                continue;
                            visited[nextIndex] = true;
                            queueX[tail] = nx;
                            queueY[tail] = ny;
                            tail++;
                        }
                    }
                }

                components[componentCount] = current;
                sizes[componentCount] = size;
                componentCount++;
            }
        }

        retainedSize = 0;
        var retained = new bool[pixelCount];
        if (componentCount == 0)
            return retained;

        int largestIndex = 0;
        for (int index = 1; index < componentCount; index++)
            if (sizes[index] > sizes[largestIndex])
                largestIndex = index;

        Rectangle mainBounds = GetBounds(components[largestIndex], width, height);
        float mainCenterX = mainBounds.Left + mainBounds.Width * 0.5f;
        float mainCenterY = mainBounds.Top + mainBounds.Height * 0.5f;

        for (int componentIndex = 0; componentIndex < componentCount; componentIndex++)
        {
            Rectangle bounds = GetBounds(components[componentIndex], width, height);
            bool touchesCellEdge = bounds.Left <= 1 || bounds.Top <= 1 ||
                bounds.Right >= width - 1 || bounds.Bottom >= height - 1;
            int gapX = Math.Max(0, Math.Max(mainBounds.Left - bounds.Right, bounds.Left - mainBounds.Right));
            int gapY = Math.Max(0, Math.Max(mainBounds.Top - bounds.Bottom, bounds.Top - mainBounds.Bottom));
            double centerX = bounds.Left + bounds.Width * 0.5;
            double centerY = bounds.Top + bounds.Height * 0.5;
            double centerDistance = Math.Sqrt(
                Math.Pow(centerX - mainCenterX, 2.0) + Math.Pow(centerY - mainCenterY, 2.0));
            bool nearby = gapX <= 56 && gapY <= 56;
            bool substantialNearby = sizes[componentIndex] >= 64 && centerDistance <= 150.0;
            bool keep = componentIndex == largestIndex ||
                (!touchesCellEdge && sizes[componentIndex] >= 8 && (nearby || substantialNearby));
            if (!keep)
                continue;

            bool[] sourceComponent = components[componentIndex];
            for (int pixel = 0; pixel < pixelCount; pixel++)
            {
                if (!sourceComponent[pixel])
                    continue;
                retained[pixel] = true;
                retainedSize++;
            }
        }

        return retained;
    }

    private static Rectangle GetBounds(bool[] component, int width, int height)
    {
        int minX = width;
        int minY = height;
        int maxX = -1;
        int maxY = -1;
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                if (!component[y * width + x])
                    continue;
                minX = Math.Min(minX, x);
                minY = Math.Min(minY, y);
                maxX = Math.Max(maxX, x);
                maxY = Math.Max(maxY, y);
            }
        }
        return Rectangle.FromLTRB(minX, minY, maxX + 1, maxY + 1);
    }

    private static void VerifyGutters(Bitmap image, int cellSize, int gutter)
    {
        for (int y = 0; y < image.Height; y++)
        {
            for (int x = 0; x < image.Width; x++)
            {
                if (image.GetPixel(x, y).A == 0)
                    continue;
                int localX = x % cellSize;
                int localY = y % cellSize;
                if (localX < gutter || localX >= cellSize - gutter || localY < gutter || localY >= cellSize - gutter)
                    throw new Exception($"Nontransparent pixel leaked into gutter at ({x},{y}).");
            }
        }
    }

    private static void WriteProof(Bitmap image, string proofPath, int cellSize, int gutter)
    {
        using var proof = new Bitmap(image.Width, image.Height, PixelFormat.Format32bppArgb);
        using (Graphics graphics = Graphics.FromImage(proof))
        {
            for (int y = 0; y < proof.Height; y += 16)
                for (int x = 0; x < proof.Width; x += 16)
                    graphics.FillRectangle(((x / 16 + y / 16) & 1) == 0 ? Brushes.White : Brushes.LightGray, x, y, 16, 16);
            graphics.DrawImageUnscaled(image, 0, 0);
            using var gridPen = new Pen(Color.Magenta, 2);
            using var safePen = new Pen(Color.LimeGreen, 1);
            for (int column = 1; column < Columns; column++)
                graphics.DrawLine(gridPen, column * cellSize, 0, column * cellSize, proof.Height);
            for (int row = 1; row < Rows; row++)
                graphics.DrawLine(gridPen, 0, row * cellSize, proof.Width, row * cellSize);
            for (int row = 0; row < Rows; row++)
                for (int column = 0; column < Columns; column++)
                    graphics.DrawRectangle(safePen, column * cellSize + gutter, row * cellSize + gutter,
                        cellSize - gutter * 2, cellSize - gutter * 2);
        }
        proof.Save(proofPath, ImageFormat.Png);
    }
}
