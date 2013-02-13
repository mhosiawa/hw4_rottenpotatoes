require 'spec_helper'

describe Movie do
	describe 'searching movies with the same director' do
		it 'should call database with director name' do
			m=mock('movie', :director=>'George Lucas', :id =>'1')
			q=mock('query')
			Movie.should_receive(:where).with(:director => m.director).and_return(q)
			f=mock('final')
			q.should_receive(:where).with(['id != ?', m.id]).and_return(f)
			results=[mock('movie1'), mock('movie2')]
			f.should_receive(:all).and_return(results)
			Movie.find_similar(m)==results
    	end
    	
    end
end

		