class PrincipalController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  end

  def instagram
  	tag = params[:tag]
  	access_token = params[:access_token]

  	if tag==nil or access_token==nil
  		render json: {error: "Ingresar tag y access_token en parámetros"}, status: 400 and return
  	end

    rest = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'?access_token='+access_token 
    restParseado = JSON.parse rest
  	resultadoContador = restParseado['data']['media_count']

    rest2 = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'/media/recent?access_token='+access_token
    rest2Parseado = JSON.parse rest2

    resultadoPosts=[]
    rest2Parseado['data'].each do |item|
      resultadoPosts.append({ tags: item['tags'], username: item['user']['username'].to_s, likes: item['likes']['count'].to_i, url: item['images']['standard_resolution']['url'].to_s, caption: item['caption']['text'].to_s})
    end


    render json: {metadata: {total: resultadoContador}, posts: resultadoPosts, version: "v1.0.2"}, status: 200
  end
end
