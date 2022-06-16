echo "Installing scenario..."
while [ ! -f /tmp/finished ]; do sleep 1; done 2>&1 >/dev/null
echo DONE 2>&1 >/dev/null