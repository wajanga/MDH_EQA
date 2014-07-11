module ApplicationHelper

	# Returns the full title on a per-page basis.
  	def full_title(page_title)
    	base_title = "MoHSW EQA"
    	if page_title.empty?
      		base_title
    	else
      		"#{base_title} | #{page_title}"
    	end
  	end

  	# Returns comments depending on score value
  	def display_score(score)
  		if (95 <= score && score <= 100)
  			"#{score} - Successful"
  		elsif (90 <= score && score < 95)
  			"#{score} - Satisfactory"
  		else
  			"#{score} - Unsatisfactory"
  		end
  	end

    # Returns colored text
    def decorate_text(text)
      if text == "POSITIVE"
        "<span class='text-success'>POSITIVE</span>".html_safe
      elsif text == "NEGATIVE"
        "<span class='text-error'>NEGATIVE</span>".html_safe
      elsif text == "REACTIVE"
        "<span class='text-success'>REACTIVE</span>".html_safe
      elsif text == "NON-REACTIVE"
        "<span class='text-error'>NON-REACTIVE</span>".html_safe
      elsif text == "N/A"
        "<span class='muted'>N/A</span>".html_safe
      elsif text == "UNDETERMINED"
        "<span class='muted'>UNDETERMINED</span>".html_safe
      end
          
    end

end
