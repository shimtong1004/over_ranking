// JavaScript Document

$(document).ready(function(){
	
	$("span[data-link]").click(function() {
	  var param = "?user_type=" + $(this).data("param")
	  var link = $(this).data("link") + param;
	  window.location = link;
	})
	
	$("button[data-link]").click(function() {
	  var param = "?play_type=" + $(this).data("param")
	  var link = $(this).data("link") + param;
	  window.location = link;
	})
	
	$(".detail_info[data-link]").click(function() {
	  var param = "?" + $(this).data("param")
	  var link = $(this).data("link") + param;
	  window.location = link;
	})
	
	
	
	

$('.btn').click(function(){
 
	$(this).siblings().removeClass("active");
	$(this).addClass("active");
	//버튼 클릭시 클래스를 변경해서 border_bottom 주기

});
try{
	$("select").msDropdown({roundedBorder:false}); //콤보박스
}catch(e) {
    console.log("Error: "+e.message);
}
	

//그래프 스크립트

	var userPoints = [[1,4213],[10,4000],[20,3800],[30,3500],[40,3345],[50,3214],[60,2945],[70,2754],[80,2541],[90,2421],[100,2000]]; 	//임시 데이타

	var jobPoints = [[18,3921]];
			  //임시 데이타
	//var userPoints = [];//실제 데이타는 아래와 같이 처리하세요.
	//for (var i=0; i<2*Math.PI; i+=0.1){ 
	//   cosPoints.push([i, Math.cos(i)]); 
	//} 
	var i=1;
	 var n = $( '.trend_grh' ).length;
	for (var i = 1; i <= n; i++) {
	var chart_name ='chart_'+i;
try {
	var plot = $.jqplot(chart_name, [userPoints, jobPoints], {  
			
		legend:{show:false,}, 
		highlighter:{show:false},
		
		series:[
				{
					label:'사용자',
				  	color : '#cc9e45', //Line Color
					lineWidth : 2,	//라인 두께
					markerOptions: {size:9,shadow:false},	//점 두께 http://www.jqplot.com/docs/files/jqPlotOptions-txt.html
					pointLabels: { show:true},
					shadow:false,
				},
				{
					label:'내 순위',
				  	color : '#000',
					lineWidth : 2,
					markerOptions : {size:10},	
					pointLabels:{ show:true, location:'s', ypadding:10 }
				}
		],
		axes:{
	      xaxis:{

			min:0, max:100, tickInterval:10, 
			
			tickOptions:{ 
				formatString: 'Top%d%',
				showGridline: false, 				//세로줄 없애기
				angle: -50,
				showTickMarks:false,
				fontsize:'20pt',
			},
			
			 rendererOptions: {
				tickInset: 0.2,                
                
            },
			drawMajorTickMarks: false,
	        autoscale: false,
			
			
            
			 
	      },
	      yaxis:{
	         autoscale: true,
			 rendererOptions: {drawBaseline: false},
			 showTicks: false,  //세로축 정보
	      }
	    },
		grid:{
			drawGridlines :true, //그리드 그리기
			background:'#f3f3f3',
			shadow:false,
			drawBorder:0,
			
		}
	});
} catch(e) {
    console.log("Error: "+e.message);
}	
	
	}
	


	
// 그래프 끝


//영웅 상세 페이지 그래프 시작

	var data = [
				[['2016/7/3',4000],['2016/7/4',3800],['2016/7/5',3500],['2016/7/6',3345],['2016/7/7',3214],['2016/7/8',2945],['2016/7/9',2754]],  //임시 데이타 승률
				[['2016/7/3',215],['2016/7/4',100],['2016/7/5',425],['2016/7/6',754],['2016/7/7',124],['2016/7/8',325],['2016/7/9',985]]
			    ]; 	//임시 데이타 플레이타임

	var line_color='#44ae82';
	//  // 공격군은 '#cc4548'
	    // 지원군은 '#cc9e45'
		// 돌격군은 '#4473ae'
		// 수비군은 '#96ceb7'

	var hero_chart_cnt = $('.hero_chart_grh').length;


if(hero_chart_cnt){
	for (var i = 1; i <= hero_chart_cnt; i++) {
	var chart_name ='hero_chart_'+i;


	var plot = $.jqplot(chart_name, [data[i-1]], {  
		legend:{show:false,}, 
		highlighter:{show:false},
		
		series:[{
					label:'사용자',
				  	color : line_color, //Line Color
					lineWidth : 2,	//라인 두께
					markerOptions: {size:9,shadow:false},	//점 두께 http://www.jqplot.com/docs/files/jqPlotOptions-txt.html
					pointLabels: {show:true},
					shadow:false,
				
		}],
		axes:{
	      xaxis:{
			  
			 renderer:$.jqplot.DateAxisRenderer,

			tickInterval:'1 day',
			tickOptions:{ 
				formatString: '%m/%d', 
				showGridline: false, 				//세로줄 없애기
				angle: -50,
				showTickMarks:false,
				fontsize:'20pt',
			}, 
			
	        autoscale: false,
			drawMajorGridlines: false,
            drawMinorGridlines: true,
			drawMajorTickMarks: false,
			
			 rendererOptions: {
				 
				tickInset: 0.5, 
				minorTicks: 0.5
                
            }
			
			
			
            
			 
	      },
	      yaxis:{
	         autoscale: true,
			 rendererOptions: {drawBaseline: false},
			 showTicks: false,  //세로축 정보
	      }
	    },
		grid:{
			drawGridlines :true, //그리드 그리기
			background:'rgba( 255, 255, 255, 0 )',
			shadow:false,
			drawBorder:0,
			gridLineColor:'#373737',
			
		},
		 gridPadding:{left:0}
	});
	
	
	}
	}
	//영웅 상세페이지 그래프 끝




//도넛 그래프 스크립트

// 
// var circle_cnt = $( '.circle' ).length;
// 
// if(circle_cnt){
// 
	// var i=1;
	// var colors = [
			// ['#959595', '#cc4548'], ['#959595', '#cc9e45'], ['#959595', '#4473ae'], ['#959595', '#96ceb7']
		// ],circles = [];
	// var play_time=['18H','7H','2H','2m'];
	// var background_img =['offence_icon.png','support.png','tank_icon.png','defence_icon.png'];
	// var per = [60,30,50,5];
// 
		// for (var i = 1; i <= 4; i++) {
// 
		// var child = document.getElementById('circles-' + i), percentage = per[i-1];
// 			
			// if(i==1){
				// circles.push(Circles.create({
				// id:         child.id,
				// value:		percentage,
				// radius:     35,
				// width:      8,
				// colors:     colors[i - 1],
				// text:play_time[i-1],
				// background_img : background_img[i-1],
				// duration :0
// 
			// }));					
// 				
			// }
			// else{
// 			
			// circles.push(Circles.create({
				// id:         child.id,
				// value:		percentage,
				// radius:     28,
				// width:      5,
				// colors:     colors[i - 1],
				// text:play_time[i-1],
				// background_img : background_img[i-1],
				// duration :0
// 
			// }));
			// }
		// }
// 		
// 
		// //영웅 그래프
	// var hero_colors = [
			// ['#959595', '#cc9e45'], ['#959595', '#cc2d45'], ['#959595', '#3373ae'], ['#959595', '#67ceb7'], ['#959595', '#cc9e34'],
			// ['#959595', '#cc9e45'], ['#959595', '#cc2d45'], ['#959595', '#3373ae'], ['#959595', '#67ceb7'], ['#959595', '#cc9e34'],
			// ['#959595', '#cc9e45'], ['#959595', '#cc2d45'], ['#959595', '#3373ae'], ['#959595', '#67ceb7'], ['#959595', '#cc9e34'],
			// ['#959595', '#cc9e45'], ['#959595', '#cc2d45'], ['#959595', '#3373ae'], ['#959595', '#67ceb7'], ['#959595', '#cc9e34'],
			// ['#959595', '#cc9e45']
		// ]  //플레이한 영웅 퍼센트 순서대로 해당되는 색깔 입력 
	       // // 공격군은 ['#959595', '#cc4548']
		   // // 지원군은 ['#959595', '#cc9e45']
		   // // 돌격군은 ['#959595', '#4473ae']
		   // // 수비군은 ['#959595', '#96ceb7']
// 	
// 
// 
// 	
	// var hero_per = [90,80,70,65,34,34,23,43,23,12,34,23,43,23,42,32,24,21,23,23,3]; //플레이한 영웅 퍼센트 순서대로 입력
	// var hero_play_time=['18시간','7시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간','2시간']; 
	 // //플레이한 영웅 시간순서대로 입력
//    
    // var hero_icon=['pharah','reaper','soldier','genji','tracer',
				   // 'mccree','mei','hanzo','tor','junkrat','widow','bastion',
				   // 'dva','zarya','reinhardt','winston','roadhog','mercy',
				   // 'symmetra','zenyatta','lucio']; //플레이한 영웅 순서대로 icon 이미지 파일명 입력
//     
    // var textclass = 'hero_circle';
		// for (var i = 1; i <= 21; i++) {
			// var id_num = i+4;
// 				
			// var child = document.getElementById('circles-' + id_num), percentage = hero_per[i-1];
// 			
				// circles.push(Circles.create({
				// id:         child.id,
				// value:		percentage,
				// radius:     35,
				// width:      8,
				// colors:     hero_colors[i - 1],
				// text: 	    hero_play_time[i-1],
				// textClass : textclass,
				// duration :0
// 				
// 
			// }));
// 			
			// var hero_icon_url = 'url(/images/hero_circle/'+hero_icon[i-1]+'_circle.png)';
			// document.getElementById('circles-'+id_num).style.backgroundImage = hero_icon_url;
// 		
		// }
// }
//  
});