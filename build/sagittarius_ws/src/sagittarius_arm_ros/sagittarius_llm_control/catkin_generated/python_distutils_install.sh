#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/robotics/team8/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/robotics/team8/install/lib/python3/dist-packages:/home/robotics/team8/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/robotics/team8/build" \
    "/usr/bin/python3" \
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/setup.py" \
     \
    build --build-base "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/robotics/team8/install" --install-scripts="/home/robotics/team8/install/bin"
