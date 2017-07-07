#Ruby製エディター　ver 0.01

#ファイル名用変数
file_name = ""

while file_name == "" do
    print "ファイル名を指定してください　："
    file_name = gets.chomp
    puts "\e[H\e[2J"
end

#ファイルの読込
str = String.new
text = File.open("#{file_name}.txt", 'r+')
str = text.read.encode("UTF-8")

#行数をカウントして動的に配列を生成
lineno = str.count("\n")
str_ary = Array.new(lineno)

#配列に一行ずつ代入
i = 0
str.each_line do |line|
    str_ary[i] = line
    i += 1
end

#編集画面ループ
while 1 do

    #一行ずつ描画
    i = 0
    str_ary.each do |str_ary_line|
        i += 1
        print "#{i} :"

        case str_ary_line

            #立ち絵、背景、BGM再生、SE再生、動画再生、コメントを赤文字で出力
            when /C\d\d/, /B\d\d/, /M\d\d/, /S\d\d/, /V\d\d/, /\/\//
                print "\e[31m"
                puts str_ary_line
                print "\e[0m"
            else
                puts str_ary_line
        end
    end

    puts "\n行番号指定で編集/saveで保存/insertで指定行に挿入/exitで終了"
    print "\n変更したい行を指定してください　："
    number = gets.chomp

    case number.to_s

        when /exit/ then
            puts "\e[H\e[2J"
            break

        when /insert/ then
            print "\n挿入したい行番号を指定してください　："
            insert_number = gets.chomp
            temp = gets.to_s
            str_ary.insert(insert_number.to_i, "#{temp}")

        when /save/ then
            i = 0
            File.open("#{file_name}.txt", "w")
            #指定したファイル名で保存
            str_ary.each do |line|
                File.open("#{file_name}.txt", "a+") do |file|
                    file.write line.encode("Windows-31J")
                end
            end
            break

        else
            puts str_ary[number.to_i - 1]
            str_ary[number.to_i - 1] = gets.to_s
            puts "\e[H\e[2J"
    end
end