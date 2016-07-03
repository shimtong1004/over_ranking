#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'


  begin
    url = "https://playoverwatch.com/ko-kr/career/pc/kr/%EC%95%84%EC%95%84%EC%95%84%ED%8D%BC%EB%95%8C%EB%A6%AC%EC%A7%80%EB%A7%88-3725"
    
    html = open(url).read
    doc = Nokogiri::HTML(html)
    
    
    # 주요통계
    view_group = doc.css("#highlights-section h1").text
    for i in 0...8
      value = doc.css(".card-heading")[i].text
      key = doc.css(".card-copy")[i].text
      OverHeroMaster.create(over_tag_id: 1, key: key, value: value, view_group: view_group)
    end
    
    
    #상위영웅 start
    view_group = doc.css("#top-heroes-section h1").text
    
    heroes_sort_condition = doc.css("#top-heroes-section .js-career-select option")
    hero_sort_datas = doc.css(".progress-category.toggle-display")
    
    heroes_sort_condition.each_with_index do |sort_condition, hero_sort_index|
      key = sort_condition.text
      hero_sort_data = hero_sort_datas[hero_sort_index]
      for i in 0...21
        hero_name = hero_sort_data.css(".bar-text .title")[i].text
        value = hero_sort_data.css(".bar-text .description")[i].text
        OverHeroMaster.create(over_tag_id: 1, hero_name: hero_name, key: sort_condition.text, value: value, view_group: view_group)
      end
    end
    #상위영웅 end
    
    
    #통계 start
    stats = doc.css(".js-stats.toggle-display")
    stats_names =  doc.css(".js-career-select")[1].css("option")
    view_group = doc.css("#stats-section h1").text
    
    
    stats.each_with_index do |data, i|
      hero_name = stats_names[i].text
      tables = data.css(".column.xs-12.md-6.xl-4.margin-xs.margin-no-sides table")
      tables.each do |table|
        view_group_detail = table.css("thead tr").text
        trs = table.css("tbody tr")
          trs.each do |tr|
          key = tr.css("td")[0].text
          value = tr.css("td")[1].text
          OverHeroMaster.create(over_tag_id: 1, hero_name: hero_name, key: key, value: value, view_group: view_group, view_group_detail: view_group_detail)
        end
      end
    end
      
  rescue
  end