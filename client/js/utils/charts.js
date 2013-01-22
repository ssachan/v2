var correctCode = '#339900';
var incorrectCode = '#CC0000';
var unattemptedCode = '#eacbad';
var lineColor = "#C6C6C6";

window.drawTimeChart = function(quiz) {
	var options = {
		chart : {
			renderTo : 'timeTaken-chart',
			type : 'column'
		},
		title : {
			text : 'Time Taken Per Question'
		},
		subtitle : {
			text : ''
		},
		xAxis : {
			tickInterval : 1,
			title : {
				text : 'Question Numbers'
			}
		},
		yAxis : {
			min : 0,
			title : {
				text : 'Time (sec)'
			}
		},
		legend : {
			layout : 'vertical',
			backgroundColor : '#FFFFFF',
			align : 'left',
			verticalAlign : 'top',
			x : 100,
			y : 70,
			floating : true,
			shadow : true
		},

		tooltip : {
			formatter : function() {
				return '' + 'Q' + this.x + ': ' + this.y + ' sec';
			}
		},
		plotOptions : {
			column : {
				pointPadding : 0.2,
				borderWidth : 0
			}
		},
		series : [],
	};

	var series = {
		data : []
	};
	var questionIds = quiz.get('questionIdsArray');
    this.timePerQuestion = quiz.get('timePerQuestionArray');
	var answers = quiz.get('selectedAnswersArray');
	var len = questionIds.length;
	for ( var i = 0; i < len; i++) {
		var question = quizQuestions.get(questionIds[i]);
		var timeTaken = timePerQuestion[i];// question.get('timeTaken');
		if (timeTaken == null) {
			series.data.push({
				x : i + 1,
				y : parseInt(0),
				color : '#FF0000'
			});
		} else {
			if (question.isOptionSelectedCorrect(answers[i]) == true) {
				series.data.push({
					x : i + 1,
					y : parseFloat(timeTaken),
					color : correctCode
				});
			} else if (question.isOptionSelectedCorrect(answers[i]) == false) {
				series.data.push({
					x : i + 1,
					y : parseFloat(timeTaken),
					color : incorrectCode
				});

			} else if (question.isOptionSelectedCorrect(answers[i]) == null) {
				series.data.push({
					x : i + 1,
					y : parseFloat(timeTaken),
					color : unattemptedCode
				});
			}
		}
	}
	options.series.push(series);
	options.legend.enabled = false;
	chart = new Highcharts.Chart(options);
};

window.getObjectByL2 = function(series, l2) {
	for ( var i = 0; i < series.length; i++) {
		if (series[i].name == l2) {
			return series[i];
		}
	}
	return null;
},

window.drawDifficultyChart = function(quiz) {
	var options = {
		chart : {
			renderTo : 'difficulty-chart',
			type : 'scatter',
			zoomType : 'xy'
		},
		title : {
			text : 'Difficulty'
		},
		xAxis : {
			title : {
				text : 'Topic'
			},
			min : -1,
			minorGridLineWidth : 0,
			gridLineWidth : 0,
			alternateGridColor : null,
			tickInterval : 1,
			labels : {
				formatter : function() {
					return '';
				}
			},
			plotLines : [ {
				color : lineColor,
				width : 2,
				value : 2
			}, {
				color : lineColor,
				width : 2,
				value : 4
			}, {
				color : lineColor,
				width : 2,
				value : 6
			}, ],
			plotBands : [/*
							 * { from: 0, to: 2, label: { text: 'RC', style: {
							 * color: '#606060' } } }, { from: 2, to: 4, label: {
							 * text: 'RC', style: { color: '#606060' } } }, {
							 * from: 4, to: 6, label: { text: 'RC', style: {
							 * color: '#606060' } } }, { from: 6, to: 8, label: {
							 * text: 'VR', style: { color: '#606060' } }}
							 */]
		},
		yAxis : {
			title : {
				text : 'Difficulty Level'
			},
			min : 0,
			max : 4,
			minorGridLineWidth : 0,
			gridLineWidth : 0,
			alternateGridColor : null,
			plotBands : [ {
				from : 0,
				to : 1,
				color : 'rgba(0, 0, 0, 0)',
				label : {
					text : 'Easy',
					style : {
						color : '#606060'
					}
				}
			}, {
				from : 1,
				to : 2,
				color : 'rgba(68, 170, 213, 0.1)',
				label : {
					text : 'Medium',
					style : {
						color : '#606060'
					}
				}
			}, {
				from : 2,
				to : 3,
				color : 'rgba(0, 0, 0, 0)',
				label : {
					text : 'Hard',
					style : {
						color : '#606060'
					}
				}
			}, {
				from : 3,
				to : 4,
				color : 'rgba(68, 170, 213, 0.1)',
				label : {
					text : 'Super Tough',
					style : {
						color : '#606060'
					}
				}
			} ]
		},
		tooltip : {
			formatter : function() {
				return '';// + this.x + ' cm, ' + this.y + ' kg';
			}
		},
		legend : {
			layout : 'vertical',
			align : 'left',
			verticalAlign : 'bottom',
			x : 100,
			y : 70,
			floating : true,
			backgroundColor : '#FFFFFF',
			borderWidth : 1
		},
		plotOptions : {
			scatter : {
				states : {
					hover : {
						marker : {
							enabled : false
						}
					}
				}
			}
		},
		series : []
	};

	var series = [];
	var questionIds = quiz.get('questionIdsArray');;
	var answers = quiz.get('selectedAnswersArray');
	var len = questionIds.length;
	for ( var i = 0; i < len; i++) {
		var question = quizQuestions.get(questionIds[i]);
		var l3 = sectionL3.get(question.get('l3Id'));
		var l2 = sectionL2.get(l3.get('l2Id'));
		var difficulty = question.get('difficulty');
		var obj = getObjectByL2(series, l2.get('displayName'));
		if (obj == null) {
			obj = {
				name : l2.get('displayName'),
				data : []
			};
			series.push(obj);
		}
		var dat = {
			x : 0,
			y : parseFloat(difficulty),
			marker : null
		};
		var marker = {
			radius : 10,
			states : {
				hover : {
					fillColor : null,
					radius : 10
				}
			}
		};
		var status = question.isOptionSelectedCorrect(answers[i]);
		if (status == true) {
			marker.fillColor = correctCode;
			marker.states.hover.fillColor = correctCode;
		} else if (status == false) {
			marker.fillColor = incorrectCode;
			marker.states.hover.fillColor = incorrectCode;
		} else if (status == null) {
			marker.fillColor = unattemptedCode;
			marker.states.hover.fillColor = incorrectCode;
		}
		dat.marker = marker;
		obj.data.push(dat);
	}
	var seriesLen = series.length;
	var offset = 0;
	for ( var j = 0; j < seriesLen; j++) {
		var ob = series[j];
		// change the bandName
		// options.xAxis.plotBands[j].label.text=ob.name;
		options.xAxis.plotBands[j] = {
			from : (j * 2),
			to : (j * 2) + 2,
			label : {
				text : ob.name,
				style : {
					color : '#606060'
				}
			}
		};// label.text=ob.name;
		var len = ob.data.length;
		var diff = [ 0, 0, 0, 0, 0 ];
		for ( var i = 0; i < len; i++) {
			var difficulty = ob.data[i].y;
			diff[difficulty] = diff[difficulty] + .25;
			ob.data[i].x = offset + diff[difficulty];
			ob.data[i].y = difficulty - .5;
		}
		offset = offset + 2;
	}
	options.xAxis.max = (2 * seriesLen);
	options.series = series;
	options.legend.enabled = false;
	chart = new Highcharts.Chart(options);
};

window.drawStratChart = function(quiz) {
	var options = {
		chart : {
			renderTo : 'strat-chart',
			type : 'columnrange'

		},
		title : {
			text : 'Time distribution'
		},
		subtitle : {
			text : ''
		},
		xAxis : {
			title : {
				text : 'Question Numbers'
			},
			tickInterval : 1
		},
		yAxis : {
			title : {
				text : 'Time (sec)'
			},
			tickInterval : 5,
			min : 0
		},
		legend : {
			layout : 'vertical',
			backgroundColor : '#FFFFFF',
			align : 'left',
			verticalAlign : 'top',
			x : 100,
			y : 70,
			floating : true,
			shadow : true
		},

		tooltip : {
			formatter : function() {
				return '' + 'Q' + this.x + ': ' + this.y + ' sec';
			}
		},
		plotOptions : {
			column : {
				pointPadding : 0.2,
				borderWidth : 0
			}
		},
		series : []
	};

	var series = [ {
		data : [],
	}, {
		type : 'scatter',
		color : '#FFFFFF',
		data : [],
	}, {
		type : 'scatter',
		color : '#AA4643',
		data : [],
	} ];

	var questionIds = activeQuiz.get('questionIdsArray');
	var len = questionIds.length;
	var offset = quizQuestions.get(questionIds[0]).get('openTimeStamps')[0];
	for ( var i = 0; i < len; i++) {
		var question = quizQuestions.get(questionIds[i]);
		var openTimeStamps = question.get('openTimeStamps');
		var closeTimeStamps = question.get('closeTimeStamps');
		var num = openTimeStamps.length;
		for ( var j = 0; j < num; j++) {
			min = (openTimeStamps[j] - offset) / 1000;
			min = parseFloat(min.toFixed(1));
			if (!closeTimeStamps[j]) {
				max = parseFloat(activeQuiz.get('timeTaken'));
			} else {
				max = (closeTimeStamps[j] - offset) / 1000;
				max = parseFloat(max.toFixed(1));
			}
			series[0].data.push({
				x : (i + 1),
				low : min,
				high : max
			});
		}
		var optionSelectedTimeStamps = question.get('optionSelectedTimeStamps');
		var optionUnSelectedTimeStamps = question
				.get('optionUnSelectedTimeStamps');
		for ( var index in optionSelectedTimeStamps) {
			var timeStamps = optionSelectedTimeStamps[index];
			var tlen = timeStamps.length;
			for ( var k = 0; k < tlen; k++) {
				var y = (timeStamps[k] - offset) / 1000;
				y = parseFloat(y.toFixed(1));
				series[1].data.push({
					x : (i + 1),
					y : y
				});
			}
		}
		for ( var index in optionUnSelectedTimeStamps) {
			var timeStamps = optionUnSelectedTimeStamps[index];
			var tlen = timeStamps.length;
			for ( var k = 0; k < tlen; k++) {
				var y = (timeStamps[k] - offset) / 1000;
				y = parseFloat(y.toFixed(1));
				series[2].data.push({
					x : (i + 1),
					y : y
				});
			}
		}
	}
	options.yAxis.max = activeQuiz.get('timeTaken');
	options.xAxis.max = len;
	options.series = series;
	options.legend.enabled = false;
	chart = new Highcharts.Chart(options);
};

window.drawHistoryChart = function() {
	var options = {
		chart : {
			renderTo : 'history-chart',
			type : 'line',
			marginRight : 130,
			marginBottom : 25
		},
		title : {
			text : 'Accuracy History',
			x : -20
		// center
		},
		xAxis : {
			categories : [ 'Quiz N-4', 'Quiz N-3', 'Quiz N-2', 'Quiz N-1',
					'Quiz N' ]
		},
		yAxis : {
			title : {
				text : 'Accuracy %'
			},
			min : 0,
			max : 100,
			plotLines : [ {
				value : 0,
				width : 1,
				color : '#808080'
			} ]
		},
		tooltip : {
			formatter : function() {
				return '<b>' + this.series.name + '</b><br/>' + this.x + ': '
						+ this.y + '%';
			}
		},
		legend : {
			layout : 'vertical',
			align : 'right',
			verticalAlign : 'top',
			x : -10,
			y : 100,
			borderWidth : 0
		},
		series : [ {
			name : 'Permutations and Combinations',
			data : [ 20, 20, 20, 30, 25 ]
		}, {
			name : 'Number System',
			data : [ 90, 90, 80, 80, 67 ]
		}, {
			name : 'Geometry',
			data : [ 50, 55, 70, 80, 100 ]
		}, {
			name : 'Equations',
			data : [ 60, 40, 50, 70, 100 ]
		} ]
	};
	chart = new Highcharts.Chart(options);
};

window.drawDonutChart = function(divId) {
	var chart;
	var colors = Highcharts.getOptions().colors, categories = [ ], name = 'L3';
	var data = [ {
		y : 33,
		color : colors[0],
		drilldown : {
			name : '',
			categories : [],
			data : [],
			actual : [],
			color : colors[0]
		}
	}, {
		y : 33,
		color : colors[1],
		drilldown : {
			name : '',
			categories : [],
			data : [],
			actual : [],
			color : colors[1]
		}
	}, {
		y : 33,
		color : colors[2],
		drilldown : {
			name : '',
			categories : [],
			data : [],
			actual : [],
			color : colors[2]
		}
	} ];
	
	// get the sum total at scoreL2 level
	var numQArray = scoreL2.pluck('numQuestions');
	var totalQ = 0;
	for(var k = 0; k < numQArray.length; k++) {
		v = parseInt(numQArray[k]);
		if (!isNaN(v)) totalQ += v;
	}
	for(var i = 0; i< sectionL1.length; i++){
		var l1=sectionL1.models[i];
		data[i].drilldown.name=l1.get('displayName');
		var l2 = sectionL2.where({
			l1Id : l1.get('id')
		});
		var totalL1 =0;
		//sum total for specific L1
		var len = l2.length;
		for ( var j = 0; j < len; j++) {
			var l2Score = scoreL2.get(l2[j].get('id'));
			var numQuestions = l2Score==null?0:l2Score.get('numQuestions');
			v = parseInt(numQuestions);
			if (!isNaN(v)) totalL1 += v;
		}
		data[i].y = totalL1;
		for ( var j = 0; j < len; j++) {
			var name = l2[j].get('displayName');
			var l2Score = scoreL2.get(l2[j].get('id'));
			var totalQuestions = l2Score==null?0:l2Score.get('numQuestions');
			
			data[i].drilldown.categories[j] = name;
			data[i].drilldown.actual[j] = parseInt(totalQuestions);
			data[i].drilldown.data[j] = (parseInt(totalQuestions)/totalQ);
		}
	}
	// Build the data arrays
	var browserData = [];
	var versionsData = [];
	for ( var i = 0; i < data.length; i++) {

		// add browser data
		browserData.push({
			name : data[i].drilldown.name,
			y : data[i].y,
			color : data[i].color
		});

		// add version data
		for ( var j = 0; j < data[i].drilldown.data.length; j++) {
			var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5;
			versionsData.push({
				name : data[i].drilldown.categories[j],
				y : data[i].drilldown.data[j],
				a : data[i].drilldown.actual[j],
				color : Highcharts.Color(data[i].color).brighten(brightness)
						.get()
						
			});
		}
	}

	// Create the chart
	chart = new Highcharts.Chart({
		chart : {
			renderTo : divId,
			type : 'pie'
		},
		title : {
			text : ''
		},
		yAxis : {
			title : {
				text : 'Total percent market share'
			}
		},
		plotOptions : {
			pie : {
				shadow : false
			}
		},
		tooltip : {
			valueSuffix : '',
			formatter : function() {
				if(this.series.name=='L1'){
					return this.y >0 ? this.point.name+'('+this.point.y+')' : null;
				}else{
					return this.y >0 ? this.point.name+'<br>Total Questions :'+this.point.a+'' : null;
				}
			},
		},
		series : [
				{
					name : 'L1',
					data : browserData,
					size : '60%',
					dataLabels : {
						formatter : function() {
							return this.y >0 ? this.point.name+'('+this.point.y+')' : null;
						},
						color : 'white',
	                    distance: -30
					}
				},
				{
					name : 'L2',
					data : versionsData,
					innerSize : '60%',
					dataLabels : {
						formatter : function() {
							// display only if larger than 1
							return this.point.a >=1 ? '<b>' + this.point.name
									+ ':</b> ' + this.point.a + '' : null;
						},
					},
					
				} ]
	});
};
