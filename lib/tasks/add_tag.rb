#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'    
    max = 56842
    while max
      begin
        url = "http://www.inven.co.kr/board/powerbbs.php?come_idx=4679&l=#{max.to_s}"
        
        html = open(url).read
        doc = Nokogiri::HTML(html)
          
        if doc.css("#powerbbsContent").size > 1
          content = doc.css("#powerbbsContent")[1].children
        else
          content = doc.css("#powerbbsContent").children
        end
        
        tmp_arys = content.to_s.delete("\t\n\r").split(/[;,<,>,\s,\xc2\xa0]/)
        tmp_arys.each do |t|
          if t.include?("#")
            break if t.include?('=')
            #aaa#23434aaa#23455 의 경우
            if t.count("#") != 1
              t_ary = t.split("#")
              t = t_ary[0] + "#" + t_ary[1]
            end
                
            i = t.index('#')
            break if i == 0
            break if t[i+1].to_i.to_s != t[i+1]
                
            chk_flg = false
            chk_cnt = 0
            while 1
              if t[-1].to_i.to_s == t[-1]
                chk_flg = true
                break
              else
                t = t[0..-2]
                chk_cnt += 1
                break if chk_cnt > 20
              end
            end
                
            if chk_flg
              over_tag = OverTag.find_by_tag(t)
              OverTag.create(tag: t, site_url: url) unless over_tag
            end
          end
        end
        max = max - 1
        break if max==0
      rescue
      end
    end