require File.expand_path(File.dirname(__FILE__) + '/../lib/shift_subtitle')

describe ShiftSubtitle do
	it "should print usage when called without parameters" do
		messenger = mock('messenger')
		shift_subtitle = ShiftSubtitle.new(messenger)
		messenger.should_receive(:puts).with("Usage: shift_subtitle --operation [ add | sub ] --time <time> <input_file> <output_file>" )
		shift_subtitle.start	
	end

	it "should have 'add' operation when passed '--operation add'" do
		messenger = mock('messenger')
		shift_subtitle = ShiftSubtitle.new(messenger)
		messenger.should_receive(:puts).with("Usage: shift_subtitle --operation [ add | sub ] --time <time> <input_file> <output_file>" )
		argv =%w{--operation,add}
		shift_subtitle.start argv
		puts shift_subtitle.operation
		shift_subtitle.operation.should =='add'
	end
end
