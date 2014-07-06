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
  			"#{score} - Unatisfactory"
  		end
  	end

end
