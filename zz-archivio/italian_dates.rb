# Credits:
# https://stackoverflow.com/questions/7395520/how-does-jekyll-date-formatting-work
#
#
module Jekyll
    module ItalianDates
        MONTHS = {"01" => "gennaio", "02" => "febbraio", "03" => "marzo",
                "04" => "aprile", "05" => "maggio", "06" => "giugno",
                "07" => "luglio", "08" => "agosto", "09" => "settembre",
                "10" => "ottobre", "11" => "novembre", "12" => "dicembre"}

        # http://man7.org/linux/man-pages/man3/strftime.3.html
        def italianDate(date)
            day = time(date).strftime("%e") # leading zero is replaced by a space
            month = time(date).strftime("%m")
            year = time(date).strftime("%Y")
            MONTHS[month]+' '+year
        end

        def html5date(date)
            day = time(date).strftime("%d")
            month = time(date).strftime("%m")
            year = time(date).strftime("%Y")
            year+'-'+month+'-'+day
        end

        def italianMonth(date)
            month = time(date).strftime("%m")
            MONTHS[month]
        end

        def italianYear(date)
            year = time(date).strftime("%Y")
            year
        end

    end
end

Liquid::Template.register_filter(Jekyll::ItalianDates)
