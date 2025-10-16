!/bin/bash
# Space Mission Telemetry Analyzer

echo "Space Mission Telemetry Analyzer"
echo "Processing all mission logs"
echo

# Directory with log files
for file in mission_logs/*.log
do
  echo "Analyzing $file..."
  grep -E "Temperature|Speed" "$file" >> all_data.txt
done

# Extract and clean temperature data
grep "Temperature" all_data.txt | sed 's/Temperature: //;s/°C//' > temp_values.txt

# Extract and clean speed data
grep "Speed" all_data.txt | sed 's/Speed: //;s/km\/s//' > speed_values.txt

# Calculate average using awk
avg_temp=$(awk '{sum+=$1} END {if (NR>0) print sum/NR; else print "No data"}' temp_values.txt)
avg_speed=$(awk '{sum+=$1} END {if (NR>0) print sum/NR; else print "No data"}' speed_values.txt)

echo "Mission Summary"
echo "Average Temperature (°C): $avg_temp"
echo "Average Speed (km/s): $avg_speed"
echo "Analysis Complete"