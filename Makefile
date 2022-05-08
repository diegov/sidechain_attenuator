all: jack ladspa

jack: sidechain_attenuator

sidechain_attenuator: sidechain_attenuator.dsp
	faust2jack sidechain_attenuator.dsp

ladspa: sidechain_attenuator.so

sidechain_attenuator.so: sidechain_attenuator.dsp
	faust2ladspa sidechain_attenuator.dsp

clean:
	rm -f sidechain_attenuator.so sidechain_attenuator
