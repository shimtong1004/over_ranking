#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'


  begin
    url = "https://playoverwatch.com/ko-kr/career/pc/kr/%EC%95%84%EC%95%84%EC%95%84%ED%8D%BC%EB%95%8C%EB%A6%AC%EC%A7%80%EB%A7%88-3725"
    
    html = open(url).read
    doc = Nokogiri::HTML(html)
    
    offense = ["겐지", "리퍼" , "맥크리", "솔저: 76", "트레이서", "파라"] #공격
    defense = ["메이", "바스티온", "위도우메이커", "정크랫", "토르비욘", "한조"] #수비
    rush = ["D.Va", "라인하르트", "로드호그", "윈스턴", "자리야"] #돌격
    support = ["루시우", "메르시", "시메트라", "젠야타"] #지원
        
    
    #상위영웅 start
    heroes = doc.css(".progress-category.toggle-display")[0].css(".progress-2.m-animated.progress-category-item")
    
    heroes.each do |hero|
      hero_name = hero.css(".title").text
      avatar = hero.css("img").attr("src").value
      
      if offense.any? {|word| hero_name.include?(word)}
        hero_type = "공격"
      elsif defense.any? {|word| hero_name.include?(word)}
        hero_type = "수비"
      elsif rush.any? {|word| hero_name.include?(word)}
        hero_type = "돌격"
      elsif support.any? {|word|hero_name.include?(word)}
        hero_type = "지원"
      end 
      
      OverHeroAvatar.create(hero_name: hero_name, avatar: avatar, hero_type: hero_type)
    end
  rescue
  end