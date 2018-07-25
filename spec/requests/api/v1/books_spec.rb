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

		it 'should return status code 200' do
			expect(response).to have_http_status(200)
		end

		# it 'should not have errors' do
		# 	expect(response.body).to eq '{}'
		# end
	end

	describe 'Get books/:id' do

		before { get "/api/v1/books/#{id}" }

		context 'when the record exists' do

			it 'should return the book' do
				expect(json).not_to be_empty
				expect(json["data"]['id']).to eq(id)
			end

			it 'should return status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exists' do

			let(:id) { 100 }

			it 'should return a Not found message' do
				expect(response.body).to match(/Couldn't find book/)
			end

			it 'should return status code 404' do
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'POST /books' do

		let(:valid_attributes) { { title: 'Sita', body: 'Devdutt Patnayak' } }

		context 'when the request is valid' do

			before { post '/api/v1/books', params: valid_attributes }

			it 'creates a book' do
				expect(json["data"]['title']).to eq('Sita')
			end

			it 'returns a status code 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do

			before { post '/api/v1/books', params: { title: 'Gita' } }

			it 'should return a validation failure message' do
				expect(json["data"]["body"]).to match(["can't be blank"])
			end

			it 'should return status code 422' do
				expect(response).to have_http_status(422)
			end
		end
	end

	describe 'PUT /books/:id' do

		before { put "/api/v1/books/#{id}", params: valid_attributes }

		context 'when valid update' do

			let(:valid_attributes) { { title: 'Radha', body: 'Sri Krishna' } }

			it 'should update the record' do
				expect(json["data"]["title"]).to eq('Radha')
			end

			it 'should return status code ok' do
				expect(response).to have_http_status(:ok)
			end

		end

		context 'when invalid update' do

			let(:valid_attributes) { { title: 'Krishna Key', body: '' } }

			it 'should return an update failure message' do
				expect(json["data"]["body"]).to match(["can't be blank"])
			end

			it 'should return status code 422' do
				expect(response).to have_http_status(422)
			end
		end
	end

	describe 'DELET /books/:id' do

		before { delete "/api/v1/books/#{id}" }

		it 'should return the status code 204' do
			expect(response).to have_http_status(204)
		end
	end
end