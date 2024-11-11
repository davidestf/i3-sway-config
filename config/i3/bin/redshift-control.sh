#!/bin/bash

# Default values
DEFAULT_LAT="51.5"
DEFAULT_LON="-0.12"
DEFAULT_DAY_TEMP="5700"
DEFAULT_NIGHT_TEMP="5800"
DEFAULT_BRIGHTNESS="1.0"  # 100% brightness

# Function to print usage
print_usage() {
    echo "Usage: $0 [-b brightness] [-d day_temp] [-n night_temp] [-l latitude] [-g longitude]"
    echo "  -b: Brightness (0.1 to 1.0, default: 1.0)"
    echo "  -d: Day temperature (default: 5700K)"
    echo "  -n: Night temperature (default: 5800K)"
    echo "  -l: Latitude (default: 51.5)"
    echo "  -g: Longitude (default: -0.12)"
    echo
    echo "Example:"
    echo "  $0 -b 0.8        # Set brightness to 80%"
    echo "  $0 -b 0.7 -d 6500 -n 4500  # Custom brightness and temperatures"
}

# Parse command line arguments
while getopts "b:d:n:l:g:h" opt; do
    case $opt in
        b) BRIGHTNESS="$OPTARG"
           # Validate brightness value
           if ! [[ $BRIGHTNESS =~ ^[0-9]*\.?[0-9]+$ ]] || \
              (( $(echo "$BRIGHTNESS < 0.1" | bc -l) )) || \
              (( $(echo "$BRIGHTNESS > 1.0" | bc -l) )); then
               echo "Error: Brightness must be between 0.1 and 1.0"
               exit 1
           fi
           ;;
        d) DAY_TEMP="$OPTARG"
           # Validate temperature
           if ! [[ $DAY_TEMP =~ ^[0-9]+$ ]] || \
              [ "$DAY_TEMP" -lt 1000 ] || [ "$DAY_TEMP" -gt 25000 ]; then
               echo "Error: Day temperature must be between 1000K and 25000K"
               exit 1
           fi
           ;;
        n) NIGHT_TEMP="$OPTARG"
           # Validate temperature
           if ! [[ $NIGHT_TEMP =~ ^[0-9]+$ ]] || \
              [ "$NIGHT_TEMP" -lt 1000 ] || [ "$NIGHT_TEMP" -gt 25000 ]; then
               echo "Error: Night temperature must be between 1000K and 25000K"
               exit 1
           fi
           ;;
        l) LAT="$OPTARG"
           # Validate latitude
           if ! [[ $LAT =~ ^-?[0-9]*\.?[0-9]+$ ]] || \
              (( $(echo "$LAT < -90" | bc -l) )) || \
              (( $(echo "$LAT > 90" | bc -l) )); then
               echo "Error: Latitude must be between -90 and 90"
               exit 1
           fi
           ;;
        g) LON="$OPTARG"
           # Validate longitude
           if ! [[ $LON =~ ^-?[0-9]*\.?[0-9]+$ ]] || \
              (( $(echo "$LON < -180" | bc -l) )) || \
              (( $(echo "$LON > 180" | bc -l) )); then
               echo "Error: Longitude must be between -180 and 180"
               exit 1
           fi
           ;;
        h) print_usage
           exit 0
           ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            print_usage
            exit 1
            ;;
    esac
done

# Set default values if not provided
BRIGHTNESS=${BRIGHTNESS:-$DEFAULT_BRIGHTNESS}
DAY_TEMP=${DAY_TEMP:-$DEFAULT_DAY_TEMP}
NIGHT_TEMP=${NIGHT_TEMP:-$DEFAULT_NIGHT_TEMP}
LAT=${LAT:-$DEFAULT_LAT}
LON=${LON:-$DEFAULT_LON}

# Kill any existing redshift processes
echo "Stopping existing redshift processes..."
killall -9 redshift 2>/dev/null

# Wait a moment
sleep 1

# Start redshift with the specified parameters
echo "Starting redshift with:"
echo "- Brightness: ${BRIGHTNESS} (${BRIGHTNESS/1.0/100}%)"
echo "- Day Temperature: ${DAY_TEMP}K"
echo "- Night Temperature: ${NIGHT_TEMP}K"
echo "- Location: ${LAT}, ${LON}"

redshift -m randr -l "${LAT}:${LON}" -t "${DAY_TEMP}:${NIGHT_TEMP}" -b "${BRIGHTNESS}" &

# Check if redshift started successfully
if [ $? -eq 0 ]; then
    echo "Redshift started successfully!"
else
    echo "Error starting redshift. Check your parameters and try again."
    exit 1
fi
