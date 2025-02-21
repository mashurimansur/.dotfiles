if grep -qi microsoft /proc/sys/kernel/osrelease; then
    echo "Running on WSL"
else
    echo "Running on native Ubuntu"
fi