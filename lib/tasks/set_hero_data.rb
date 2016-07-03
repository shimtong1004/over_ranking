#encoding: utf-8
require 'open-uri'
require "#{File.dirname(__FILE__)}/../../config/environment.rb"


        tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
    
        urls = ["https://api.lootbox.eu/pc/kr/#{tag}/hero/Roadhog/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Reaper/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Soldier76/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Reinhardt/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Tracer/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Genji/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Lucio/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/McCree/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Pharah/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Junkrat/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Widowmaker/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Mei/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Zarya/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Zenyatta/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Hanzo/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Mercy/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Torbjoern/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Symmetra/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Winston/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Bastion/", 
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/DVa/"
          ]         
        
        max_thread = 21 # 最大スレッド数
        ary_threads = []
        data = []
        locker = Mutex::new
        # max_threadで指定した数だけスレッドを開始
        max_thread.times do |i|
          ary_threads << Thread.start { # スレッドを作成
            loop do
              url = locker.synchronize { urls.pop } # urlをひとつ取り出す。競合回避のためにsynchronizeで囲う
              break unless url # urlがなくなればループを終了
              uri = Addressable::URI.parse(url)
              url = uri.normalize.to_s
              
              puts "start: #{url}"
              begin
              data.push JSON.load(open(url)) 
              rescue
              end
              puts "end download: #{data}"
            end
          }
        end
        
        ary_threads.each { |th| th.join }
        puts "finish process"
        p data.size