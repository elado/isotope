var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

function getMonthName(m) {
	return monthNames[m];
}

function getOrdinalSuffix(n) {
	return ['th','st','nd','rd'][n<4 || (n>20 && n % 10<4) ? n % 10 : 0];
}

function formatDate(dateISO8601) {
	var date = new Date(Date.parse(dateISO8601));
	return getMonthName(date.getMonth())+" "+date.getDate()+getOrdinalSuffix(date.getDate())+", "+date.getFullYear();
}

String.prototype.parenthesize = function () {
	return "(" + this + ")";
};

/**
 * Date.parse with progressive enhancement for ISO-8601, version 2
 * © 2010 Colin Snover <http://zetafleet.com>
 * Released under MIT license.
 */
// http://zetafleet.com/blog/javascript-dateparse-for-iso-8601
(function () {
	var origParse = Date.parse;
	Date.parse = function (date) {
		var timestamp = origParse(date), minutesOffset = 0, struct;
		if (isNaN(timestamp) && (struct = /^(\d{4}|[+\-]\d{6})-(\d{2})-(\d{2})(?:[T ](\d{2}):(\d{2})(?::(\d{2})(?:\.(\d{3,}))?)?(?:(Z)|([+\-])(\d{2})(?::?(\d{2}))?))?/.exec(date))) {
			if (struct[8] !== 'Z') {
				minutesOffset = +struct[10] * 60 + (+struct[11]);
    
				if (struct[9] === '+') {
					minutesOffset = 0 - minutesOffset;
				}
			}
			
			if (!struct[7]) struct[7] = "0000";

			timestamp = new Date(+struct[1], +struct[2] - 1, +struct[3], +struct[4], +struct[5] + minutesOffset, +struct[6], +struct[7].substr(0, 3)).getTime();
		}

		return timestamp;
	};
}());