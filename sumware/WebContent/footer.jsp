<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer id="footer" class="footer">
			<div class="container">
				<div class="row">
					<div class="col-md-3 wow fadeInUp animated" data-wow-duration="500ms">
						<div class="footer-single">
							<img src="img/sum2.png" alt="">
						</div>
					</div>	
					<div class="col-md-7">
						<p>ㅣ대표이사 김명준 ㅣ이메일 : kim84ii@hanmail.net ㅣ경기도 성남시 분당구 삼평동 대왕판교로 670길 유스페이스2 B동 8층</p>
						<p>	Copyright (c) 2015 SumWare Office. All rights reserved.</p>
					</div>
				</div>
			</div>
		</footer>
		
		<a href="javascript:void(0);" id="back-top"><i class="fa fa-angle-up fa-3x"></i></a>

		<!-- Essential jQuery Plugins
		================================================== -->
		<!-- Main jQuery -->
        <script src="js/jquery-1.11.1.min.js"></script>
		<!-- Single Page Nav -->
        <script src="js/jquery.singlePageNav.min.js"></script>
		<!-- Twitter Bootstrap -->
        <script src="js/bootstrap.min.js"></script>
		<!-- jquery.fancybox.pack -->
        <script src="js/jquery.fancybox.pack.js"></script>
		<!-- jquery.mixitup.min -->
        <script src="js/jquery.mixitup.min.js"></script>
		<!-- jquery.parallax -->
        <script src="js/jquery.parallax-1.1.3.js"></script>
		<!-- jquery.countTo -->
        <script src="js/jquery-countTo.js"></script>
		<!-- jquery.appear -->
        <script src="js/jquery.appear.js"></script>
		<!-- Contact form validation -->
		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.32/jquery.form.js"></script>
		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.min.js"></script>
		<!-- Google Map -->
        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
		<!-- jquery easing -->
        <script src="js/jquery.easing.min.js"></script>
		<!-- jquery easing -->
        <script src="js/wow.min.js"></script>
		<script>
			var wow = new WOW ({
				boxClass:     'wow',      // animated element css class (default is wow)
				animateClass: 'animated', // animation css class (default is animated)
				offset:       120,          // distance to the element when triggering the animation (default is 0)
				mobile:       false,       // trigger animations on mobile devices (default is true)
				live:         true        // act on asynchronously loaded content (default is true)
			  }
			);
			wow.init();
		</script> 
		<!-- Custom Functions -->
        <script src="js/custom.js"></script>
		
		<script type="text/javascript">
			$(function(){
				/* ========================================================================= */
				/*	Contact Form
				/* ========================================================================= */
				
				$('#contact-form').validate({
					rules: {
						name: {
							required: true,
							minlength: 2
						},
						email: {
							required: true,
							email: true
						},
						message: {
							required: true
						}
					},
					messages: {
						name: {
							required: "come on, you have a name don't you?",
							minlength: "your name must consist of at least 2 characters"
						},
						email: {
							required: "no email, no message"
						},
						message: {
							required: "um...yea, you have to write something to send this form.",
							minlength: "thats all? really?"
						}
					},
					submitHandler: function(form) {
						$(form).ajaxSubmit({
							type:"POST",
							data: $(form).serialize(),
							url:"process.php",
							success: function() {
								$('#contact-form :input').attr('disabled', 'disabled');
								$('#contact-form').fadeTo( "slow", 0.15, function() {
									$(this).find(':input').attr('disabled', 'disabled');
									$(this).find('label').css('cursor','default');
									$('#success').fadeIn();
								});
							},
							error: function() {
								$('#contact-form').fadeTo( "slow", 0.15, function() {
									$('#error').fadeIn();
								});
							}
						});
					}
				});
			});
			
			
			
		/*
		 몰라
		*/
		
		
		<!--

		//-->
		;(function ($, window, undefined) {
		    // outside the scope of the jQuery plugin to
		    // keep track of all dropdowns
		    var $allDropdowns = $();

		    // if instantlyCloseOthers is true, then it will instantly
		    // shut other nav items when a new one is hovered over
		    $.fn.dropdownHover = function (options) {
		        // don't do anything if touch is supported
		        // (plugin causes some issues on mobile)
		        if('ontouchstart' in document) return this; // don't want to affect chaining

		        // the element we really care about
		        // is the dropdown-toggle's parent
		        $allDropdowns = $allDropdowns.add(this.parent());

		        return this.each(function () {
		            var $this = $(this),
		                $parent = $this.parent(),
		                defaults = {
		                    delay: 500,
		                    hoverDelay: 0,
		                    instantlyCloseOthers: true
		                },
		                data = {
		                    delay: $(this).data('delay'),
		                    hoverDelay: $(this).data('hover-delay'),
		                    instantlyCloseOthers: $(this).data('close-others')
		                },
		                showEvent   = 'show.bs.dropdown',
		                hideEvent   = 'hide.bs.dropdown',
		                // shownEvent  = 'shown.bs.dropdown',
		                // hiddenEvent = 'hidden.bs.dropdown',
		                settings = $.extend(true, {}, defaults, options, data),
		                timeout, timeoutHover;

		            $parent.hover(function (event) {
		                // so a neighbor can't open the dropdown
		                if(!$parent.hasClass('open') && !$this.is(event.target)) {
		                    // stop this event, stop executing any code
		                    // in this callback but continue to propagate
		                    return true;
		                }

		                openDropdown(event);
		            }, function () {
		                // clear timer for hover event
		                window.clearTimeout(timeoutHover)
		                timeout = window.setTimeout(function () {
		                    $this.attr('aria-expanded', 'false');
		                    $parent.removeClass('open');
		                    $this.trigger(hideEvent);
		                }, settings.delay);
		            });

		            // this helps with button groups!
		            $this.hover(function (event) {
		                // this helps prevent a double event from firing.
		                // see https://github.com/CWSpear/bootstrap-hover-dropdown/issues/55
		                if(!$parent.hasClass('open') && !$parent.is(event.target)) {
		                    // stop this event, stop executing any code
		                    // in this callback but continue to propagate
		                    return true;
		                }

		                openDropdown(event);
		            });

		            // handle submenus
		            $parent.find('.dropdown-submenu').each(function (){
		                var $this = $(this);
		                var subTimeout;
		                $this.hover(function () {
		                    window.clearTimeout(subTimeout);
		                    $this.children('.dropdown-menu').show();
		                    // always close submenu siblings instantly
		                    $this.siblings().children('.dropdown-menu').hide();
		                }, function () {
		                    var $submenu = $this.children('.dropdown-menu');
		                    subTimeout = window.setTimeout(function () {
		                        $submenu.hide();
		                    }, settings.delay);
		                });
		            });

		            function openDropdown(event) {
		                // clear dropdown timeout here so it doesnt close before it should
		                window.clearTimeout(timeout);
		                // restart hover timer
		                window.clearTimeout(timeoutHover);
		                
		                // delay for hover event.  
		                timeoutHover = window.setTimeout(function () {
		                    $allDropdowns.find(':focus').blur();

		                    if(settings.instantlyCloseOthers === true)
		                        $allDropdowns.removeClass('open');
		                    
		                    // clear timer for hover event
		                    window.clearTimeout(timeoutHover);
		                    $this.attr('aria-expanded', 'true');
		                    $parent.addClass('open');
		                    $this.trigger(showEvent);
		                }, settings.hoverDelay);
		            }
		        });
		    };

		    $(document).ready(function () {
		        // apply dropdownHover to all elements with the data-hover="dropdown" attribute
		        $('[data-hover="dropdown"]').dropdownHover();
		    });
		})(jQuery, window)


		</script>
    </body>
</html>
