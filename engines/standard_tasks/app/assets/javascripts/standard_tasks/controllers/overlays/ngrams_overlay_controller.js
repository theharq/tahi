ETahi.NgramsOverlayController = ETahi.TaskController.extend({

  fullPaperBody: function() {
    return this.get("model").get("phase").get("paper").get("body");
  }.property("fullPaperBody"),

  paperText: function() {
    return $(this.get("fullPaperBody")).text()
  }.property("paperText"),

  nGrams: function() { // pulled from StackOverflow
    var text = this.get("paperText");

    var atLeast = 1;       // Show results with at least .. occurrences
    var numWords = 3;      // Show statistics for one to .. words
    var ignoreCase = true; // Case-sensitivity
    var REallowedChars = /[^a-zA-Z'\-]+/g;
    // RE pattern to select valid characters. Invalid characters are replaced with a whitespace

    var i, j, k, textlen, len, s;
    // Prepare key hash
    var keys = [null]; //"keys[0] = null", a word boundary with length zero is empty
    var results = [];
    numWords++; //for human logic, we start counting at 1 instead of 0
    for (i=1; i<=numWords; i++) {
      keys.push({});
    }

    // Remove all irrelevant characters
    text = text.replace(REallowedChars, " ").replace(/^\s+/,"").replace(/\s+$/,"");

    // Create a hash
    if (ignoreCase) text = text.toLowerCase();
    text = text.split(/\s+/);
    for (i=0, textlen=text.length; i<textlen; i++) {
      s = text[i];
      keys[1][s] = (keys[1][s] || 0) + 1;
      for (j=2; j<=numWords; j++) {
        if(i+j <= textlen) {
          s += " " + text[i+j-1];
          keys[j][s] = (keys[j][s] || 0) + 1;
        } else break;
      }
    }

    // Prepares results for advanced analysis
    for (var k=1; k<=numWords; k++) {
      results[k] = [];
      var key = keys[k];
      for (var i in key) {
        if(key[i] >= atLeast) results[k].push({"word":i, "count":key[i]});
      }
    }

    // Result parsing
    var outputHTML = []; // Buffer data. This data is used to create a table using `.innerHTML`

    var f_sortAscending = function(x,y) {return y.count - x.count;};
    for (k=1; k<numWords; k++) {
      results[k].sort(f_sortAscending);//sorts results

      // Customize your output. For example:
      var words = results[k];
      if (words.length) outputHTML.push('<td colSpan="3" class="num-words-header">'+k+' word'+(k==1?"":"s")+'</td>');
      for (i=0,len=words.length; i<len; i++) {

        //Characters have been validated. No fear for XSS
        outputHTML.push("<td>" + words[i].word + "</td><td><b>" +
        words[i].count + "</b></td>");
        // textlen defined at the top
        // The relative occurence has a precision of 2 digits.
      }
    }

    outputHTML = '<table id="wordAnalysis" class="table"><thead><tr>' +
    '<td>Phrase</td><td>Count</td></tr>' +
    '</thead><tbody><tr>' +outputHTML.join("</tr><tr>")+
    "</tr></tbody></table>";

    return outputHTML;
  }.property("nGrams")
});
