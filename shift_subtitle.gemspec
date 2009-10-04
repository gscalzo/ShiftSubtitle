Gem::Specification.new do |s|
  s.name = %q{shift_subtitle}
  s.version = "0.0.1"
  s.date = %q{2009-10-04}
  s.authors = ["Giordano Scalzo"]
  s.email = %q{giordano@scalzo.biz}
  s.summary = %q{ShiftSubtitle shifts time in a srt file.}
  s.homepage = %q{http://github.com/gscalzo/ShiftSubtitle}
  s.description = %q{My attempt to 'Ruby Programming Challenge For Newbies: Shift Subtitle' http://rubylearning.com/blog/2009/09/24/rpcfn-shift-subtitle-1/}
  s.executables << 'shift_subtitle'
  s.files = [ "README", "bin/shift_subtitle", "bin/shift_subtitle.bat", "doc/Sample.srt", "lib/add.rb", "lib/operation.rb", "lib/operation_performer.rb", 
  		"lib/shift_subtitle.rb", "lib/sub.rb", "spec/add_spec.rb", "spec/sub_spec.rb", "spec/operation_performer_spec.rb", 
		"spec/shift_subtitle_spec.rb", "spec/spec.opts", ]
end

