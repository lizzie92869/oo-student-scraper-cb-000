require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
        doc.css(".student-card").each do |card|
        student = {}
        student[:name] = card.css(".student-name").text
        student[:location] = card.css(".student-location").text
        student[:profile_url] = "./fixtures/student-site/#{card.css("a")[0]["href"]}"
        students << student
        end
        students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # social_links = doc.css(".social-icon-container a")
    student_profile = {}

    doc.css(".social-icon-container a").each do |link|
          href = link.attribute("href").value
          if href.include?("twitter")
            student_profile[:twitter] = href
          elsif href.include?("github")
            student_profile[:github] = href
          elsif href.include?("linkedin")
            student_profile[:linkedin] = href
          else
            student_profile[:blog] = href
          end
        end

        student_profile[:profile_quote] = doc.css(".profile-quote").text
        student_profile[:bio] = doc.css(".description-holder p").text

        student_profile
    end

end




#   def self.scrape_index_page(index_url)
#   	html = open(index_url)
# 		doc = Nokogiri::HTML(html)
#
# 		array=[]
#     doc.css(".student-card").each do |card|
#     	new_hash={}
#     	new_hash[:name]=card.css(".student-name").text
#     	new_hash[:location]=card.css(".student-location").text
#     	new_hash[:profile_url]="./fixtures/student-site/#{card.css("a")[0]["href"]}"
#
#     	array << new_hash
#
#     end
#
#     array
#
#   end
#
#   def self.scrape_profile_page(profile_url)
#
#     html = open(profile_url)
# 		doc = Nokogiri::HTML(html)
#     new_hash={}
#   	social_icon=doc.css(".social-icon-container").css("a")
#   	social_icon.each do |link|
#   		if link["href"].include?("twitter")
# 				new_hash[:twitter]=link["href"]
# 			elsif link["href"].include?("linkedin")
#   			new_hash[:linkedin]=link["href"]
#   		elsif link["href"].include?("github")
#   			new_hash[:github]=link["href"]
#   		else
#   			new_hash[:blog]=link["href"]
#   		end
#   	end
#
#   	new_hash[:profile_quote]=doc.css(".profile-quote").text
#   	new_hash[:bio]=doc.css(".bio-block .description-holder").css("p").text
#
#     new_hash
#   end
#
# end
