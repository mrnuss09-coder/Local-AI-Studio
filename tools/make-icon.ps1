# Erzeugt das Anwendungssymbol (app.ico mit 16–256 px) und logo.png für LocalAI Studio.
# Verwendung: powershell -ExecutionPolicy Bypass -File tools\make-icon.ps1
param([string]$OutDir = (Join-Path $PSScriptRoot "..\src\LocalAIStudio\Assets"))

Add-Type -AssemblyName System.Drawing
New-Item -ItemType Directory -Force $OutDir | Out-Null

function New-RoundedPath([single]$x, [single]$y, [single]$w, [single]$h, [single]$r) {
    $p = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = $r * 2
    $p.AddArc($x, $y, $d, $d, 180, 90)
    $p.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $p.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $p.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $p.CloseFigure()
    return $p
}

function New-IconBitmap([int]$size) {
    $bmp = New-Object System.Drawing.Bitmap $size, $size, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.InterpolationMode = 'HighQualityBicubic'
    $g.Clear([System.Drawing.Color]::Transparent)
    $s = [single]$size
    $m = [single]($s * 0.04)
    $rect = New-Object System.Drawing.RectangleF $m, $m, ($s - 2 * $m), ($s - 2 * $m)
    $path = New-RoundedPath $m $m ($s - 2 * $m) ($s - 2 * $m) ([single]($s * 0.22))
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, ([System.Drawing.Color]::FromArgb(255, 45, 212, 191)), ([System.Drawing.Color]::FromArgb(255, 37, 99, 235)), 45.0
    $g.FillPath($brush, $path)

    # Dunkler Innenbereich
    $inner = New-RoundedPath ([single]($s * 0.14)) ([single]($s * 0.14)) ([single]($s * 0.72)) ([single]($s * 0.72)) ([single]($s * 0.16))
    $innerBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(235, 22, 25, 29))
    $g.FillPath($innerBrush, $inner)

    # Neuronales Netz: drei Knoten links, ein Knoten rechts, verbunden
    $white = [System.Drawing.Color]::FromArgb(255, 236, 254, 255)
    $lineW = [single][Math]::Max(1.0, $s * 0.045)
    $pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 94, 234, 212)), $lineW
    $left = @(
        (New-Object System.Drawing.PointF ([single]($s * 0.33)), ([single]($s * 0.33))),
        (New-Object System.Drawing.PointF ([single]($s * 0.33)), ([single]($s * 0.50))),
        (New-Object System.Drawing.PointF ([single]($s * 0.33)), ([single]($s * 0.67)))
    )
    $right = New-Object System.Drawing.PointF ([single]($s * 0.68)), ([single]($s * 0.50))
    foreach ($pt in $left) { $g.DrawLine($pen, $pt, $right) }
    $r1 = [single]($s * 0.065)
    $nodeBrush = New-Object System.Drawing.SolidBrush $white
    foreach ($pt in $left) { $g.FillEllipse($nodeBrush, $pt.X - $r1, $pt.Y - $r1, 2 * $r1, 2 * $r1) }
    $r2 = [single]($s * 0.095)
    $accent = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 45, 212, 191))
    $g.FillEllipse($accent, $right.X - $r2, $right.Y - $r2, 2 * $r2, 2 * $r2)
    $g.FillEllipse($nodeBrush, $right.X - $r2 * 0.45, $right.Y - $r2 * 0.45, $r2 * 0.9, $r2 * 0.9)
    $g.Dispose()
    return $bmp
}

$sizes = 16, 24, 32, 48, 64, 128, 256
$pngs = @()
foreach ($size in $sizes) {
    $bmp = New-IconBitmap $size
    $ms = New-Object System.IO.MemoryStream
    $bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
    $pngs += , @($size, $ms.ToArray())
    if ($size -eq 256) { $bmp.Save((Join-Path $OutDir "logo.png"), [System.Drawing.Imaging.ImageFormat]::Png) }
    $bmp.Dispose()
}

# ICO-Datei mit PNG-Einträgen schreiben
$icoPath = Join-Path $OutDir "app.ico"
$fs = [System.IO.File]::Create($icoPath)
$bw = New-Object System.IO.BinaryWriter $fs
$bw.Write([UInt16]0); $bw.Write([UInt16]1); $bw.Write([UInt16]$pngs.Count)
$offset = 6 + 16 * $pngs.Count
foreach ($entry in $pngs) {
    $size = $entry[0]; $data = $entry[1]
    $dim = if ($size -ge 256) { 0 } else { $size }
    $bw.Write([byte]$dim); $bw.Write([byte]$dim); $bw.Write([byte]0); $bw.Write([byte]0)
    $bw.Write([UInt16]1); $bw.Write([UInt16]32)
    $bw.Write([UInt32]$data.Length); $bw.Write([UInt32]$offset)
    $offset += $data.Length
}
foreach ($entry in $pngs) { $bw.Write([byte[]]$entry[1]) }
$bw.Flush(); $bw.Close()
Write-Output "Symbol erstellt: $icoPath"
