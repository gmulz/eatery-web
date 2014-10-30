##
# The route handler for calendar information. 
# 
# Should get the data, filter it, and answer to the response.
##

iroh = require 'Iroh'

##
# Serves array with ids for all available calendars
module.exports.all_ids = (req, res) ->
  iroh.query().then((data)->
      res.json data.dining
      return
    )

##
# req: contains cal_id for calendar to fetch.
module.exports.cal_id = (req, res) ->
  iroh.query(req.params.cal_id).then((data)->
	  thisMorning = Math.floor((new Date().getTime())/ 86400000) * 86400000
	  tonight = thisMorning + 86400000
	  data.events = data.events.filter (event) -> (event.start < tonight && event.start > thisMorning) || (event.start<thisMorning && event.end <tonight && event.end > thisMorning)
	  res.json data
	  return
  )

# req: contains cal_id, start, and end.
module.exports.render_range = (req, res) ->
  iroh.query(req.params.cal_id).then (data) ->
    render_calendar.then res


render_calendar = (cal, start, end) ->
  return new Promise (resolve, reject) ->
    console.log 'will render the data'
    resolve cal


###

{
  location : <string>
  events: [{
    start: <int>
    end: <int>
    description: <string>
  }]
}

###