param(
    [ValidateSet("Ubilava-CV", "Ubilava-CV-Short", "Ubilava-pubs")]
    [string]$Target = "Ubilava-CV"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

function Find-Tool {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }

    $miktexPath = Join-Path $env:LOCALAPPDATA "Programs\MiKTeX\miktex\bin\x64\$Name"
    if (Test-Path -LiteralPath $miktexPath) {
        return $miktexPath
    }

    throw "Could not find '$Name'. Add MiKTeX to PATH or install it locally first."
}

$pdflatex = Find-Tool -Name "pdflatex.exe"
$biber = Find-Tool -Name "biber.exe"

$extensions = @(
    "aux",
    "bbl",
    "bcf",
    "blg",
    "fdb_latexmk",
    "fls",
    "log",
    "out",
    "run.xml",
    "synctex.gz"
)

foreach ($extension in $extensions) {
    $path = Join-Path $scriptDir "$Target.$extension"
    if (Test-Path -LiteralPath $path) {
        Remove-Item -LiteralPath $path -Force
    }
}

& $pdflatex -interaction=nonstopmode -halt-on-error "$Target.tex"
& $biber $Target
& $pdflatex -interaction=nonstopmode -halt-on-error "$Target.tex"
& $pdflatex -interaction=nonstopmode -halt-on-error "$Target.tex"
