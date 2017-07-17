class Bus < ApplicationRecord
	def self.seat_layout json_data 
		result ={}
		suggested_seats=[]
   	json_data["suggested_seats"].each do |seats|
     suggested_seats<< seats['name']
    end
		lower = json_data['trip_details']['seats'].select{|d| d['zIndex'].eql?("0")}
    upper = json_data['trip_details']['seats'].select{|d| d['zIndex'].eql?("1")}
    max_row =    json_data['trip_details']['seats'].max_by{|i| i['row'].to_i}
	  max = max_row['row'].to_i
	  fares = json_data['trip_details']['seats'].select{|seat| seat['baseFare'].to_i if seat['baseFare'].to_i>0 }
	  fares = fares.collect {|seat| seat['baseFare'].to_i}
	  fares = fares.uniq.sort
    row_lower = filter_seat_layout lower
    if upper.present?
     row_upper = filter_seat_layout upper
     show_upper = true
    else
    	show_upper = false
    	row_upper = {}
    end
    row_hash=[]
    (max.downto(0)).each do |i|
      row_hash<<i
    end
    result['lower'] = row_lower 
    result['upper'] = row_upper
    result['show_upper'] = show_upper
    result['row_hash'] = row_hash
    result['suggested_seats']=suggested_seats
    return result
	end

	def self.filter_seat_layout data
   max =   data.max_by{|i| i['row'].to_i}
   row = {}
   col_max = data.max_by{|i| i['column'].to_i}
   col_max = col_max['column'].to_i

   (0..max['row'].to_i).each do |r|
    lower = data.select{|rw| rw['row'].to_i==r}
    lower = lower.sort_by{|col| col['column'].to_i}
    row[r]=[]
    if lower.blank? 
      row[r]<<{column: "-1", zIndex: "0", length: "1",css_1: "_NO_SEAT_",css_2: "_HSH_",span_1: "_2CpW _1Zjt",span_2: "U6x5 _1Zjt",hover_text: ""} if r!=0
    else
      col = lower.min_by{|i| i['column'].to_i}
      col_no = col['column']
      count = col_no.to_i
      col = lower.select{|s| s['column'].to_i==count}
      column = lower.collect{|c| c['column'].to_i}
     
      zIndex = lower.collect{|c| c['zIndex']}
      # lower.each do |seat|
      diff = column.each_cons(2).map { |a,b| b-a }
      el = diff[0] || 1 
      (0..(column.first-el)).each do |i|
        puts "===========#{i}"
        column<< el*(-1)
        # puts "============>#{el*(-1)}"
      end
      puts "=========#{diff}========"
      puts "====END=========="
       column = column.sort
        # puts "======clm====>#{column}" 
         column.each do |st|
          if st<0
           if st>-2 
            row[r]<<{column: "-1", zIndex: "0", length: "1",css_1: "_NO_SEAT_",css_2: "_HSH_",span_1: "_2CpW _1Zjt",span_2: "U6x5 _1Zjt",hover_text: ""} 
           else 
            row[r]<<{column: "-1", zIndex: "0", length: "1",css_1: "_NO_SEAT_",css_2: "_HSH_sl", span_1: "_no_hd_", span_2: "_no_hd_", hover_text: ""}
           end 
          else
             json_data = {}
             temp = lower.select{|c| c['column'].to_i==st}.first
             if temp['length']=="1"
              if temp['available']=="false"
                lady = temp['ladiesSeat']=="false" ? "_HSH_ IlqM" : "_HSH_ pXg8"
                json_data = {css_1:"_3AF7 tt-default hover-tt-top" ,css_2: "#{lady}",span_1: "_2CpW _1Zjt",span_2: "U6x5 _1Zjt",hover_text: "Seat no: #{temp['name']} | fare: Rs #{temp['fare'].to_i}"}
              else
               lady = temp['ladiesSeat']=="false" ? "_HSH_" : "_HSH_ _39aI" 
               json_data = {css_1:"_3AF7 tt-default hover-tt-top",css_2: "#{lady}",span_1: "_2CpW _1Zjt",span_2: "U6x5 _1Zjt",hover_text: "Seat no: #{temp['name']} | fare: Rs #{temp['fare'].to_i}"}
              end 
             else
               if temp['available']=="false"
                lady = temp['ladiesSeat']=="false" ? "_HSH_sl IlqM" : "_HSH_sl pXg8"
                json_data ={css_1:"_3AF7 tt-default hover-tt-top", css_2: "#{lady}",span_1: "_no_hd_",span_2: "_no_hd_",hover_text: "Seat no: #{temp['name']} | fare: Rs #{temp['fare'].to_i}"}
              else
                lady = temp['ladiesSeat']=="false" ? "_HSH_sl" : "_HSH_sl _39aI" 
                json_data ={css_1:"_3AF7 tt-default hover-tt-top", css_2: "#{lady}",span_1: "_no_hd_",span_2: "_no_hd_",hover_text: "Seat no: #{temp['name']} | fare: Rs #{temp['fare'].to_i}"}
              end 
             end 
             
             row[r]<< temp.merge(json_data)
          end  
        end
    end  
   end
   return row
	end
end
