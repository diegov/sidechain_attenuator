# What is this?

It's a simple side-chain attenuator that I use when I'm listening to music while on an audio call. Normally this is done with a dynamic compressor, and it's known as "ducking". In this case I just apply an attenuation envelope.

It's written in the [Faust programming language](https://faust.grame.fr/).

# How does it work

The music stereo channels go into the first two inputs. The sidechain sources (eg. the audio call's audio) go into the last two inputs. 

When there's audio coming from the call, the music's volume is lowered so that we can hear the person talking. That's it.

# Building

I currently use it as a Jack application, thanks to Pipewire which can connect it seamlessly to Pulse clients. So the Makefile will build a Jack application, and a LADSPA plugin which is also easy to insert into a Pulse or Pipewire graph from the command line. 

If that's not suitable, the `faust2...` commands can be used to produce an application or plugin in any of the formats Faust supports.

# License

[GPLv3](LICENSE)
