Basic Idea
=============

DSPTools is an attempt to bring the coveted world of DSP to engineering students. They should be able to play around with DSP concepts and not feel scared. It should be very easy to add components, connect them together and see the waveforms. I believe that if you bring the ability to experiment with your ideas, you increase the depth of knowledge which is very important in DSP world.

Current DSP Components
-------

Following DSP components are currently in the project.

* Wire
* SignalSource: (only sine waveform at the moment)
* Integrator
* Sample and Hold
* Quantizer
* Summation

Circuits
-------

There are a few sample circuits that are included in the project. 

* A basic circuit with SignalSource and Integrator
* A basic Sample and Hold with Quantizer
* A delta modulator
* A sigma-delta modulator

However, you can build one of your own with "New Schematic". It won't

Quirks
--------
The state of the project is "very alpha". Some of the obvious things that I can point out:

* You need to click on the waveform button, dismiss the new screen with "Done" and then click on the waveform button again to see the actual waveform
* You cannot save your circuit
* Circuit drawing is very awkward

Docs
------
Well, there is none. However, there is a system diagram in the docs folder that outlines how various parts of the system fit together.

Installation
-------

* There is a dependency on Three20 project (it will be removed soon). 
* It runs with iOS SDK 5.0

