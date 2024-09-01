Task(
	{
		//boot the SuperCollider server
		s.reboot;
		o = Server.default.options;
		o.outDevice_("BlackHole 64ch");
		o.inDevice_("BlackHole 16ch");
		s.options.numOutputBusChannels = 64;
		s.options.numInputBusChannels = 16;
		s.latency = 0.05;
		o.memSize_(2.pow(21));

		//wait
		s.waitForBoot(
			{
				"listening for OSC messages on port ".post;
				NetAddr.langPort.postln;
				"receiving audio input from ".post;
				o.inDevice.postln;
				"sending audio output to ".post;
				o.outDevice.postln;
				OSCdef(
					\oscer,
					{
						arg msg;
						msg[1].asString.compile.value;
					},
					\oscer
				);
			}
		)
	}
).play(AppClock)