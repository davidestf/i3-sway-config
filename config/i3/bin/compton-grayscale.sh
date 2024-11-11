#!/usr/bin/env bash

# Kill any existing compositor processes
killall -q picom compton xcompmgr

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null || pgrep -u $UID -x compton >/dev/null || pgrep -u $UID -x xcompmgr >/dev/null; do
    sleep 1
done


 #Define shader
GRAYSCALE=$(cat <<-END
uniform sampler2D tex;

void main() {
   vec4 c = texture2D(tex, gl_TexCoord[0].xy);
   float y = dot(c.rgb, vec3(0.299, 0.587, 0.114));
   vec4 gray = vec4(y, y, y, c.a);
   gl_FragColor = mix(c, gray, 0.60);

}
END
)



# Configuration file path
CONFIG_FILE="$HOME/.config/compton/compton.conf"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Warning: Configuration file $CONFIG_FILE not found!"
    echo "Using default settings..."
fi


# Restart compton with the selected mode
killall -q compton
if [[ $MODE == "grayscale" ]]; then
   compton "$@" --glx-fshader-win "$GRAYSCALE" --backend glx
else
   compton "$@"
fi
