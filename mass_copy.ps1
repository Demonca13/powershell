$csv = Import-Csv '<path_to_csv_file>'
$currentDate = get-date -format yyyyMMdd
$currentRDate = get-date -format yyyy/MM/dd
$currentTime = get-date -format hh:mm:sstt
$outputName = "Logfile-" + $currentDate + ".txt"
$outputPath = "path_for_log"

$source1 = "<path_to_source_file>"
$copyTo1 = "<path_to_dest_dir>"

echo "Log" > $outputPath
echo "Date Ran: $currentRDate" >> $outputPath
echo "Time Ran: $currentTime" >> $outputPath
echo "================================================" >> $outputPath
foreach ($line in $csv) {
    $Address = $line.IP
    $boolConnect = Test-Connection -ComputerName $Address -BufferSize 16 -Count 1 -Quiet
    echo "Working on $Address"
    if ($boolConnect -eq 'True') {
        $destination = "\\$Address\$copyTo1"
        echo "-------------------------------" >> $outputPath
        echo "$Address is Online" >> $outputPath
        echo "-------------------------------" >> $outputPath
        robocopy $source1 $destination >> $outputPath
        #icacls ($destination) /inheritance:d  >> $outputPath
        }
#    if ($boolConnect -eq 'True') {
#        $destination = "\\$Address\$copyTo2"
#        echo "-------------------------------" >> $outputPath
#        echo "$Address is Online" >> $outputPath
#        echo "-------------------------------" >> $outputPath
#        robocopy $source2 $destination >> $outputPath
#        #icacls ($destination) /inheritance:d  >> $outputPath
#    }
    else {
        echo "$Address is Offline" >> $outputPath
    }
    
    echo "-------------------------------" >> $outputPath
}
