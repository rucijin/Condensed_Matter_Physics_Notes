# Claude Code Statusline Script
# Displays: 📁 current-directory | [progress-bar] used%
#
# Claude Code pipes a JSON object to stdin with workspace and context_window info.

$jsonInput = $input | Out-String
if ([string]::IsNullOrWhiteSpace($jsonInput)) {
    try { $jsonInput = [Console]::In.ReadToEnd() } catch {}
}
if ([string]::IsNullOrWhiteSpace($jsonInput)) {
    exit 0
}

$data = $jsonInput | ConvertFrom-Json
$parts = @()

# --- Current directory ---
$dir = $data.workspace.current_dir
if ($dir) {
    $home = [Environment]::GetFolderPath('UserProfile')
    if ($dir.StartsWith($home, [StringComparison]::OrdinalIgnoreCase)) {
        $dir = '~' + $dir.Substring($home.Length)
    }
    $parts += "$([char]0x1F4C1) $dir"
}

# --- Context window progress bar ---
$used = $data.context_window.used_percentage
if ($null -ne $used) {
    $barLength = 20
    $filled = [math]::Ceiling($used / 100 * $barLength)
    $empty = $barLength - $filled
    $bar = ('█' * $filled) + ('░' * $empty)
    $parts += "$bar $([math]::Round($used))%"
}

# --- Output ---
$output = $parts -join ' | '
if ($output) {
    Write-Output $output
}
