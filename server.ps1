$port = 8080
$root = if ($PSScriptRoot) { $PSScriptRoot } else { "c:\Users\Lenovo\OneDrive\Desktop\Website" }
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Listening on http://localhost:$port/"

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        try {
            $req = $context.Request
            $res = $context.Response
            
            $res.Headers.Add("Access-Control-Allow-Origin", "*")
            
            $rawPath = $req.Url.LocalPath
            if ($rawPath -eq "/" -or $rawPath -eq "") { $rawPath = "/index.html" }
            $localPath = [System.Uri]::UnescapeDataString($rawPath).Replace("/", "\")
            $filePath = Join-Path $root $localPath.TrimStart('\')
            
            if (Test-Path $filePath -PathType Leaf) {
                $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                switch ($ext) {
                    ".html" { $res.ContentType = "text/html; charset=utf-8" }
                    ".css"  { $res.ContentType = "text/css; charset=utf-8" }
                    ".js"   { $res.ContentType = "application/javascript; charset=utf-8" }
                    ".json" { $res.ContentType = "application/json; charset=utf-8" }
                    ".jpg"  { $res.ContentType = "image/jpeg" }
                    ".jpeg" { $res.ContentType = "image/jpeg" }
                    ".png"  { $res.ContentType = "image/png" }
                    ".webp" { $res.ContentType = "image/webp" }
                    ".svg"  { $res.ContentType = "image/svg+xml" }
                    ".ico"  { $res.ContentType = "image/x-icon" }
                    ".woff" { $res.ContentType = "font/woff" }
                    ".woff2"{ $res.ContentType = "font/woff2" }
                    default { $res.ContentType = "application/octet-stream" }
                }
                
                $content = [System.IO.File]::ReadAllBytes($filePath)
                $res.ContentLength64 = $content.Length
                
                if ($req.HttpMethod -ne "HEAD") {
                    $res.OutputStream.Write($content, 0, $content.Length)
                }
            } else {
                $res.StatusCode = 404
                $notFoundMsg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
                $res.ContentLength64 = $notFoundMsg.Length
                if ($req.HttpMethod -ne "HEAD") {
                    $res.OutputStream.Write($notFoundMsg, 0, $notFoundMsg.Length)
                }
            }
        } catch {
            Write-Warning $_.Exception.Message
        } finally {
            try { $context.Response.Close() } catch {}
        }
    }
} finally {
    $listener.Stop()
}
