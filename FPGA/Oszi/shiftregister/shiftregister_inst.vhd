shiftregister_inst : shiftregister PORT MAP (
		clock	 => clock_sig,
		shiftin	 => shiftin_sig,
		shiftout	 => shiftout_sig,
		taps0x	 => taps0x_sig,
		taps1x	 => taps1x_sig,
		taps2x	 => taps2x_sig,
		taps3x	 => taps3x_sig,
		taps4x	 => taps4x_sig,
		taps5x	 => taps5x_sig
	);
