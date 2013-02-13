require 'spec_helper'

describe MoviesController do
	describe 'searching movies with the same director' do
		it 'should call a model method to search for movies' do
			m=mock('movie', :director=>'George Lucas', :id =>'1')
			Movie.should_receive(:find).with(m.id).and_return(m)
			Movie.should_receive(:find_similar).with(m)
    		get :similar, :id =>1
    	end
		it 'should select a template for rendering' do
			m=mock('movie', :director=>'George Lucas', :id =>'1')
			Movie.should_receive(:find).with(m.id).and_return(m)
			Movie.stub(:find_similar).with(m).and_return(mock('movie', :director => 'George Lukas').as_null_object)
			get :similar, :id =>1
			response.should render_template('similar')
		end

		it 'should make the search results available to rendered template' do
			m=mock('movie', :director=>'George Lucas', :id =>'1')
			Movie.should_receive(:find).with(m.id).and_return(m)
			similar=[mock('movie1'), mock('movie2')]
			Movie.stub(:find_similar).with(m).and_return(similar)
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
