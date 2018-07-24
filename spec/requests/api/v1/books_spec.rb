require 'rails_helper'

RSpec.describe 'Books API', type: :request do 
	# initialize the test data

	let!(:books) { create_list(:book, 10) }
	let(:id) { books.first.id }

	describe 'Get /books' do

		before { get '/api/v1/books' }

		it 'should return books' do
			expect(json).not_to be_empty
			expect(json["data"].size).to eq(10)
		end

	# 	it 'should return status code 200' do
	# 		expect(response).to have_http_status(200)
	# 	end

	# 	it 'should not have errors' do
	# 		expect(response.body).to eq '{}'
	# 	end
	end

	# describe 'Get books/:id' do

	# 	before { 'get/books/#{book.id}'}

	# 	context 'when the record exists' do

	# 		it 'should return the book' do
	# 			expect(json).not_to be_empty
	# 			expect(json['id']).to eq(id)
	# 		end

	# 		it 'should return status code 200' do
	# 			expect(response).to have_http_status(200)
	# 		end
	# 	end
	# end
end