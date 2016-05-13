class PrincipalController < ApplicationController

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
    restParseado['data'].each do |item|
      resultadoPosts.append({ tags: item['tags'], username: item['user']['username'], likes: item['likes']['count'], url: item['images']['standard_resolution']['url'], caption: item['caption']['text']})
    end


    render json: {metadada: {total: resultadoContador}, posts: resultadoPosts, version: "v0.1"}, status: 200
  end
end
