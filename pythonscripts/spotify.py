#!/usr/bin/env python
# -*- coding: utf-8 -*-
import dbus

session_bus = dbus.SessionBus()

spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")

spotify_props = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")

metadata = spotify_props.Get("org.mpris.MediaPlayer2.Player", "Metadata")

def info():
    unicode_info = u"♫  " + metadata['xesam:artist'][0] + ' - ' + metadata['xesam:title'] 
    return unicode_info.encode('utf-8')

def main():
    try:
        print info()
    except (KeyboardInterrupt, SystemExit):
        pass

if __name__ == '__main__':
    main()
