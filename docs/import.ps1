Get-Content buckets.txt | ForEach-Object { scoop bucket add $_ }
Get-Content apps.txt | ForEach-Object  {scoop install $_}
