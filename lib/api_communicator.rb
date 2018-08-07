require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  final_arr = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  # binding.pry
  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.
  response_hash["results"].each do |result_data|
    if result_data["name"] == character
      result_data["films"].each do |film|
        # binding.pry
        film_str = RestClient.get(film)
        film_hash = JSON.parse(film_str)
        final_arr << film_hash
        #binding.pry
      end
    end
  end
  return final_arr
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

#get_character_movies_from_api("Darth Vader")


def print_movies
  response_string = RestClient.get('http://www.swapi.co/api/films/')
  response_hash = JSON.parse(response_string)

  response_hash["results"].map do |result_data|
    result_data["title"]
    #binding.pry
  end
  # some iteration magic and puts out the movies in a nice list
end

puts print_movies

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
