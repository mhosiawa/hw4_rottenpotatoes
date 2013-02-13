require 'spec_helper'

describe MoviesController do
	describe 'searching movies with the same director' do
		it 'should call a model method to search for movies' do
			m=mock('movie', :director=>'George Lucas', :id =>'1')
			Movie.should_receive(:find).with(m.id).and_return(m)
			q=mock('query')
			Movie.should_receive(:where).with(:director => m.director).and_return(q)
			f=mock('final')
			q.should_receive(:where).with(['id != ?', m.id]).and_return(f)
			f.should_receive(:all)
    		get :similar, :id =>1
    	end
		it 'should select a template for rendering' do
			Movie.stub(:find).and_return(mock('movie', :director => 'George Lukas').as_null_object)
			Movie.stub_chain(:where, :where, :all)
			get :similar, :id =>1
			response.should render_template('similar')
		end

		it 'should make the search results available to rendered template' do
			Movie.stub(:find).and_return(mock('movie', :director => "George Lukas").as_null_object)
			similar=[mock('movie1'), mock('movie2')]
			Movie.stub_chain(:where, :where, :all).and_return(similar)
			get :similar, :id =>1
			assigns(:movies).should==similar
		end

		it 'should redirect to index page if director is empty' do
			m=mock('movie', :director => '', :title => "Mac")
			Movie.stub(:find).and_return(m)
			get :similar, :id=>1
			response.should redirect_to(movies_path)
		end

		it 'should flash a message that the movie has no director' do
			m=mock('movie', :director => '', :title =>"Mac")
			Movie.stub(:find).and_return(m)
			get :similar, :id=>1
			flash[:notice].should=="'Mac' has no director info"
		end

	end
end
