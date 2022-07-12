require "csv"
 
#=========1を入力すれば新規メモ作成、2を入力すれば既存メモ編集===================
puts "1(新規でメモを作成) 2(既存のメモ編集する)"
memo_type = gets.to_s.rstrip

#==========新規メモの作成===================================================
if memo_type=="1"
    puts "新規でメモを作成します"
    puts "メモのファイル名(拡張格子は除く)を入力してください"

    #作成したいファイルの名前を入力
    file_name=gets.rstrip
    file_name_csv=file_name+".csv"

    #カレントディレクトリ内のファイルを検索。同じファイル名があった場合は書き込みを行わない。
    arr=[]
    Dir.foreach(".") do |item|
        arr << item
    end
    if arr.include?(file_name_csv)
        puts "既にそのファイルは存在します"
    else
        csv=CSV.open("#{file_name_csv}","a")

    #メモの内容を入力。保存。
        puts "メモしたい内容を入力してください"     
        puts "終了するにはcontrol+dを入力して下さい"     #修正箇所
        file_text=$stdin.read                       #修正箇所
        csv << [file_text]
    end
    
#==========既存メモの編集==========================================================
elsif memo_type=="2"
    puts "既存のメモを編集します。"
    #カレントディレクトリ内のcsvファイル一覧＋番号を表示
    files=Dir.foreach(".")
    files_csv=files.select{|file| file.include?(".csv")}
    file_index=1
    files_csv.each do |n|
        puts "#{file_index}:#{n}"
        file_index+=1
    end

    #番号を入力するとcsvファイルが開く
    puts "開きたいcsvファイルの番号を入力してください"
    file_num=gets.to_i
    p files_csv[file_num-1]
    csv=CSV.open(files_csv[file_num-1],"a")
    puts "メモしたい内容を入力してください"
    puts "終了するにはcontrol+dを入力して下さい" #修正箇所
    file_text=$stdin.read                   #修正箇所
    csv << [file_text]
end

