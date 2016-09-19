describe command('ps ax | grep activem[q]') do
  its('exit_status') { should eq 0 }
end
