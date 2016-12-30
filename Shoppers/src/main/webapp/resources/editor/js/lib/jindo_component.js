jindo.Component = jindo
		.$Class({
			_htEventHandler : null,
			_htOption : null,
			$init : function() {
				var a = this.constructor.getInstance();
				a.push(this);
				this._htEventHandler = {};
				this._htOption = {};
				this._htOption._htSetter = {}
			},
			option : function(c, b) {
				switch (typeof c) {
				case "undefined":
					return this._htOption;
				case "string":
					if (typeof b != "undefined") {
						if (c == "htCustomEventHandler") {
							if (typeof this._htOption[c] == "undefined") {
								this.attach(b)
							} else {
								return this
							}
						}
						this._htOption[c] = b;
						if (typeof this._htOption._htSetter[c] == "function") {
							this._htOption._htSetter[c](b)
						}
					} else {
						return this._htOption[c]
					}
					break;
				case "object":
					for ( var a in c) {
						if (a == "htCustomEventHandler") {
							if (typeof this._htOption[a] == "undefined") {
								this.attach(c[a])
							} else {
								continue
							}
						}
						this._htOption[a] = c[a];
						if (typeof this._htOption._htSetter[a] == "function") {
							this._htOption._htSetter[a](c[a])
						}
					}
					break
				}
				return this
			},
			optionSetter : function(c, a) {
				switch (typeof c) {
				case "undefined":
					return this._htOption._htSetter;
				case "string":
					if (typeof a != "undefined") {
						this._htOption._htSetter[c] = jindo.$Fn(a, this).bind()
					} else {
						return this._htOption._htSetter[c]
					}
					break;
				case "object":
					for ( var b in c) {
						this._htOption._htSetter[b] = jindo.$Fn(c[b], this)
								.bind()
					}
					break
				}
				return this
			},
			fireEvent : function(b, k) {
				k = k || {};
				var d = this["on" + b], c = this._htEventHandler[b] || [], h = typeof d == "function", g = c.length > 0;
				if (!h && !g) {
					return true
				}
				c = c.concat();
				k.sType = b;
				if (typeof k._aExtend == "undefined") {
					k._aExtend = [];
					k.stop = function() {
						if (k._aExtend.length > 0) {
							k._aExtend[k._aExtend.length - 1].bCanceled = true
						}
					}
				}
				k._aExtend.push({
					sType : b,
					bCanceled : false
				});
				var f = [ k ], e, j;
				for (e = 2, j = arguments.length; e < j; e++) {
					f.push(arguments[e])
				}
				if (h) {
					d.apply(this, f)
				}
				if (g) {
					var a;
					for (e = 0, a; (a = c[e]); e++) {
						a.apply(this, f)
					}
				}
				return !k._aExtend.pop().bCanceled
			},
			attach : function(c, a) {
				if (arguments.length == 1) {
					jindo.$H(arguments[0]).forEach(jindo.$Fn(function(d, e) {
						this.attach(e, d)
					}, this).bind());
					return this
				}
				var b = this._htEventHandler[c];
				if (typeof b == "undefined") {
					b = this._htEventHandler[c] = []
				}
				b.push(a);
				return this
			},
			detach : function(e, b) {
				if (arguments.length == 1) {
					jindo.$H(arguments[0]).forEach(jindo.$Fn(function(f, g) {
						this.detach(g, f)
					}, this).bind());
					return this
				}
				var d = this._htEventHandler[e];
				if (d) {
					for (var a = 0, c; (c = d[a]); a++) {
						if (c === b) {
							d = d.splice(a, 1);
							break
						}
					}
				}
				return this
			},
			detachAll : function(c) {
				var b = this._htEventHandler;
				if (arguments.length) {
					if (typeof b[c] == "undefined") {
						return this
					}
					delete b[c];
					return this
				}
				for ( var a in b) {
					delete b[a]
				}
				return this
			}
		});
jindo.Component.factory = function(b, f) {
	var c = [], a;
	if (typeof f == "undefined") {
		f = {}
	}
	for (var d = 0, e; (e = b[d]); d++) {
		a = new this(e, f);
		c[c.length] = a
	}
	return c
};
jindo.Component.getInstance = function() {
	if (typeof this._aInstance == "undefined") {
		this._aInstance = []
	}
	return this._aInstance
};
jindo.UIComponent = jindo.$Class({
	$init : function() {
		this._bIsActivating = false
	},
	isActivating : function() {
		return this._bIsActivating
	},
	activate : function() {
		if (this.isActivating()) {
			return this
		}
		this._bIsActivating = true;
		if (arguments.length > 0) {
			this._onActivate.apply(this, arguments)
		} else {
			this._onActivate()
		}
		return this
	},
	deactivate : function() {
		if (!this.isActivating()) {
			return this
		}
		this._bIsActivating = false;
		if (arguments.length > 0) {
			this._onDeactivate.apply(this, arguments)
		} else {
			this._onDeactivate()
		}
		return this
	}
}).extend(jindo.Component);
jindo.RolloverArea = jindo.$Class(
		{
			$init : function(a, b) {
				this.option({
					sClassName : "rollover",
					sClassPrefix : "rollover-",
					bCheckMouseDown : true,
					bActivateOnload : true,
					htStatus : {
						sOver : "over",
						sDown : "down"
					}
				});
				this.option(b || {});
				this._elArea = jindo.$(a);
				this._aOveredElements = [];
				this._aDownedElements = [];
				this._wfMouseOver = jindo.$Fn(this._onMouseOver, this);
				this._wfMouseOut = jindo.$Fn(this._onMouseOut, this);
				this._wfMouseDown = jindo.$Fn(this._onMouseDown, this);
				this._wfMouseUp = jindo.$Fn(this._onMouseUp, this);
				if (this.option("bActivateOnload")) {
					this.activate()
				}
			},
			_addOvered : function(a) {
				this._aOveredElements.push(a)
			},
			_removeOvered : function(a) {
				this._aOveredElements.splice(jindo.$A(this._aOveredElements)
						.indexOf(a), 1)
			},
			_addStatus : function(b, a) {
				jindo.$Element(b).addClass(this.option("sClassPrefix") + a)
			},
			_removeStatus : function(b, a) {
				jindo.$Element(b).removeClass(this.option("sClassPrefix") + a)
			},
			_isInnerElement : function(a, b) {
				return a === b ? true : jindo.$Element(a).isParentOf(b)
			},
			_onActivate : function() {
				this._wfMouseOver.attach(this._elArea, "mouseover");
				this._wfMouseOut.attach(this._elArea, "mouseout");
				if (this.option("bCheckMouseDown")) {
					this._wfMouseDown.attach(this._elArea, "mousedown");
					this._wfMouseUp.attach(document, "mouseup")
				}
			},
			_onDeactivate : function() {
				this._wfMouseOver.detach(this._elArea, "mouseover");
				this._wfMouseOut.detach(this._elArea, "mouseout");
				this._wfMouseDown.detach(this._elArea, "mousedown");
				this._wfMouseUp.detach(document, "mouseup");
				this._aOveredElements.length = 0;
				this._aDownedElements.length = 0
			},
			_findRollover : function(b) {
				var a = this.option("sClassName");
				return jindo.$$.test(b, "." + a) ? b : jindo.$$.getSingle("! ."
						+ a, b)
			},
			_onMouseOver : function(a) {
				var c = a.element, b = a.relatedElement, d;
				for (; c = this._findRollover(c); c = c.parentNode) {
					if (b && this._isInnerElement(c, b)) {
						continue
					}
					this._addOvered(c);
					d = {
						element : c,
						htStatus : this.option("htStatus"),
						weEvent : a
					};
					if (this.fireEvent("over", d)) {
						this._addStatus(d.element, d.htStatus.sOver)
					}
				}
			},
			_onMouseOut : function(a) {
				var c = a.element, b = a.relatedElement, d;
				for (; c = this._findRollover(c); c = c.parentNode) {
					if (b && this._isInnerElement(c, b)) {
						continue
					}
					this._removeOvered(c);
					d = {
						element : c,
						htStatus : this.option("htStatus"),
						weEvent : a
					};
					if (this.fireEvent("out", d)) {
						this._removeStatus(d.element, d.htStatus.sOver)
					}
				}
			},
			_onMouseDown : function(a) {
				var b = a.element, c;
				while (b = this._findRollover(b)) {
					c = {
						element : b,
						htStatus : this.option("htStatus"),
						weEvent : a
					};
					this._aDownedElements.push(b);
					if (this.fireEvent("down", c)) {
						this._addStatus(c.element, c.htStatus.sDown)
					}
					b = b.parentNode
				}
			},
			_onMouseUp : function(c) {
				var e = c.element, f = [], a = this._aDownedElements, g, d, b;
				for (b = 0; d = a[b]; b++) {
					f.push({
						element : d,
						htStatus : this.option("htStatus"),
						weEvent : c
					})
				}
				for (; e = this._findRollover(e); e = e.parentNode) {
					if (jindo.$A(a).indexOf(e) > -1) {
						continue
					}
					f.push({
						element : e,
						htStatus : this.option("htStatus"),
						weEvent : c
					})
				}
				for (b = 0; g = f[b]; b++) {
					if (this.fireEvent("up", g)) {
						this._removeStatus(g.element, g.htStatus.sDown)
					}
				}
				this._aDownedElements = []
			}
		}).extend(jindo.UIComponent);
jindo.Calendar = jindo
		.$Class(
				{
					$init : function(a, b) {
						this._htToday = this.constructor
								.getDateHashTable(new Date());
						this._elLayer = jindo.$(a);
						this.htDefaultOption = {
							sClassPrefix : "calendar-",
							nYear : this._htToday.nYear,
							nMonth : this._htToday.nMonth,
							nDate : this._htToday.nDate,
							sTitleFormat : "yyyy-mm",
							sYearTitleFormat : "yyyy",
							sMonthTitleFormat : "m",
							aMonthTitle : [ "JAN", "FEB", "MAR", "APR", "MAY",
									"JUN", "JUL", "AUG", "SEP", "OCT", "NOV",
									"DEC" ],
							bDrawOnload : true
						};
						this.option(this.htDefaultOption);
						this.option(b || {});
						this._assignHTMLElements();
						this.activate();
						this.setDate(this.option("nYear"), this
								.option("nMonth"), this.option("nDate"));
						if (this.option("bDrawOnload")) {
							this.draw()
						}
					},
					getBaseElement : function() {
						return this._elLayer
					},
					getDate : function() {
						return this._htDate
					},
					getDateOfElement : function(b) {
						var a = jindo.$A(this._aDateContainerElement)
								.indexOf(b);
						if (a > -1) {
							return this._aMetaData[a]
						}
						return null
					},
					getToday : function() {
						return this._htToday
					},
					setDate : function(b, c, a) {
						this._htDate = {
							nYear : b,
							nMonth : (c * 1),
							nDate : (a * 1)
						}
					},
					getShownDate : function() {
						return this._getShownDate()
					},
					_getShownDate : function() {
						return this.htShownDate || this.getDate()
					},
					_setShownDate : function(a, b) {
						this.htShownDate = {
							nYear : a,
							nMonth : (b * 1),
							nDate : 1
						}
					},
					_assignHTMLElements : function() {
						var c = this.option("sClassPrefix"), b = this
								.getBaseElement();
						if ((this.elBtnPrevYear = jindo.$$.getSingle(
								("." + c + "btn-prev-year"), b))) {
							this.wfPrevYear = jindo.$Fn(function(d) {
								d.stop(jindo.$Event.CANCEL_DEFAULT);
								this.draw(-1, 0, true)
							}, this)
						}
						if ((this.elBtnPrevMonth = jindo.$$.getSingle(
								("." + c + "btn-prev-mon"), b))) {
							this.wfPrevMonth = jindo.$Fn(function(d) {
								d.stop(jindo.$Event.CANCEL_DEFAULT);
								this.draw(0, -1, true)
							}, this)
						}
						if ((this.elBtnNextMonth = jindo.$$.getSingle(
								("." + c + "btn-next-mon"), b))) {
							this.wfNextMonth = jindo.$Fn(function(d) {
								d.stop(jindo.$Event.CANCEL_DEFAULT);
								this.draw(0, 1, true)
							}, this)
						}
						if ((this.elBtnNextYear = jindo.$$.getSingle(
								("." + c + "btn-next-year"), b))) {
							this.wfNextYear = jindo.$Fn(function(d) {
								d.stop(jindo.$Event.CANCEL_DEFAULT);
								this.draw(1, 0, true)
							}, this)
						}
						this.elTitle = jindo.$$.getSingle(("." + c + "title"),
								b);
						this.elTitleYear = jindo.$$.getSingle(
								("." + c + "title-year"), b);
						this.elTitleMonth = jindo.$$.getSingle(
								("." + c + "title-month"), b);
						var a = jindo.$$.getSingle("." + c + "week", b);
						this.elWeekTemplate = a.cloneNode(true);
						this.elWeekAppendTarget = a.parentNode
					},
					_setCalendarTitle : function(b, c, f) {
						if (c < 10) {
							c = ("0" + (c * 1)).toString()
						}
						var d = this.elTitle, e = this.option("sTitleFormat"), a;
						if (typeof f != "undefined") {
							switch (f) {
							case "year":
								d = this.elTitleYear;
								e = this.option("sYearTitleFormat");
								a = e.replace(/yyyy/g, b).replace(/y/g,
										(b).toString().substr(2, 2));
								break;
							case "month":
								d = this.elTitleMonth;
								e = this.option("sMonthTitleFormat");
								a = e
										.replace(/mm/g, c)
										.replace(/m/g, (c * 1))
										.replace(
												/M/g,
												this.option("aMonthTitle")[c - 1]);
								break
							}
						} else {
							a = e.replace(/yyyy/g, b).replace(/y/g,
									(b).toString().substr(2, 2)).replace(/mm/g,
									c).replace(/m/g, (c * 1)).replace(/M/g,
									this.option("aMonthTitle")[c - 1])
						}
						jindo.$Element(d).text(a)
					},
					draw : function(p, s, a) {
						var n = this.option("sClassPrefix"), l = this.getDate(), j = this
								._getShownDate();
						if (j && typeof a != "undefined" && a) {
							var w = this.constructor
									.getRelativeDate(p, s, 0, j);
							p = w.nYear;
							s = w.nMonth
						} else {
							if (typeof p == "undefined"
									&& typeof s == "undefined"
									&& typeof a == "undefined") {
								p = l.nYear;
								s = l.nMonth
							} else {
								p = p || j.nYear;
								s = s || j.nMonth
							}
						}
						if (this.fireEvent("beforeDraw", {
							nYear : p,
							nMonth : s
						})) {
							if (this.elTitle) {
								this._setCalendarTitle(p, s)
							}
							if (this.elTitleYear) {
								this._setCalendarTitle(p, s, "year")
							}
							if (this.elTitleMonth) {
								this._setCalendarTitle(p, s, "month")
							}
							this._clear(jindo.Calendar.getWeeks(p, s));
							this._setShownDate(p, s);
							var e = this.getToday(), k = this.constructor
									.getFirstDay(p, s), q = this.constructor
									.getLastDay(p, s), z = this.constructor
									.getLastDate(p, s), m = 0, d = this.constructor
									.getRelativeDate(0, -1, 0, {
										nYear : p,
										nMonth : s,
										nDate : 1
									}), g = this.constructor.getRelativeDate(0,
									1, 0, {
										nYear : p,
										nMonth : s,
										nDate : 1
									}), v = this.constructor.getLastDate(
									d.nYear, d.nMonth), A = [], r, t, y, b, h, f, o, x, u;
							var c = this.constructor.getWeeks(p, s);
							for (u = 0; u < c; u++) {
								x = this.elWeekTemplate.cloneNode(true);
								jindo.$Element(x).appendTo(
										this.elWeekAppendTarget);
								this._aWeekElement.push(x)
							}
							this._aDateElement = jindo.$$("." + n + "date",
									this.elWeekAppendTarget);
							this._aDateContainerElement = jindo.$$("." + n
									+ "week > *", this.elWeekAppendTarget);
							if (k > 0) {
								for (u = v - k; u < v; u++) {
									A.push(u + 1)
								}
							}
							for (u = 1; u < z + 1; u++) {
								A.push(u)
							}
							o = A.length - 1;
							for (u = 1; u < 7 - q; u++) {
								A.push(u)
							}
							for (u = 0; u < A.length; u++) {
								r = false;
								t = false;
								y = jindo
										.$Element(this._aDateContainerElement[u]);
								b = p;
								h = s;
								if (u < k) {
									r = true;
									y.addClass(n + "prev-mon");
									b = d.nYear;
									h = d.nMonth
								} else {
									if (u > o) {
										t = true;
										y.addClass(n + "next-mon");
										b = g.nYear;
										h = g.nMonth
									} else {
										b = p;
										h = s
									}
								}
								if (m === 0) {
									y.addClass(n + "sun")
								}
								if (m == 6) {
									y.addClass(n + "sat")
								}
								if (b == e.nYear && (h * 1) == e.nMonth
										&& A[u] == e.nDate) {
									y.addClass(n + "today")
								}
								f = {
									elDate : this._aDateElement[u],
									elDateContainer : y.$value(),
									nYear : b,
									nMonth : h,
									nDate : A[u],
									bPrevMonth : r,
									bNextMonth : t,
									sHTML : A[u]
								};
								jindo.$Element(f.elDate).html(
										f.sHTML.toString());
								this._aMetaData.push({
									nYear : b,
									nMonth : h,
									nDate : A[u]
								});
								m = (m + 1) % 7;
								this.fireEvent("draw", f)
							}
							this.fireEvent("afterDraw", {
								nYear : p,
								nMonth : s
							})
						}
					},
					_clear : function(a) {
						this._aMetaData = [];
						this._aWeekElement = [];
						jindo.$Element(this.elWeekAppendTarget).empty()
					},
					attachEvent : function() {
						this.activate()
					},
					detachEvent : function() {
						this.deactivate()
					},
					_onActivate : function() {
						if (this.elBtnPrevYear) {
							this.wfPrevYear.attach(this.elBtnPrevYear, "click")
						}
						if (this.elBtnPrevMonth) {
							this.wfPrevMonth.attach(this.elBtnPrevMonth,
									"click")
						}
						if (this.elBtnNextMonth) {
							this.wfNextMonth.attach(this.elBtnNextMonth,
									"click")
						}
						if (this.elBtnNextYear) {
							this.wfNextYear.attach(this.elBtnNextYear, "click")
						}
					},
					_onDeactivate : function() {
						if (this.elBtnPrevYear) {
							this.wfPrevYear.detach(this.elBtnPrevYear, "click")
						}
						if (this.elBtnPrevMonth) {
							this.wfPrevMonth.detach(this.elBtnPrevMonth,
									"click")
						}
						if (this.elBtnNextMonth) {
							this.wfNextMonth.detach(this.elBtnNextMonth,
									"click")
						}
						if (this.elBtnNextYear) {
							this.wfNextYear.detach(this.elBtnNextYear, "click")
						}
					}
				}).extend(jindo.UIComponent);
jindo.Calendar.getDateObject = function(a) {
	if (arguments.length == 3) {
		return new Date(arguments[0], arguments[1] - 1, arguments[2])
	}
	return new Date(a.nYear, a.nMonth - 1, a.nDate)
};
jindo.Calendar.getDateHashTable = function(a) {
	if (arguments.length == 3) {
		return {
			nYear : arguments[0],
			nMonth : arguments[1],
			nDate : arguments[2]
		}
	}
	if (arguments.length <= 1) {
		a = a || new Date()
	}
	return {
		nYear : a.getFullYear(),
		nMonth : a.getMonth() + 1,
		nDate : a.getDate()
	}
};
jindo.Calendar.getTime = function(a) {
	return this.getDateObject(a).getTime()
};
jindo.Calendar.getFirstDay = function(a, b) {
	return new Date(a, b - 1, 1).getDay()
};
jindo.Calendar.getLastDay = function(a, b) {
	return new Date(a, b, 0).getDay()
};
jindo.Calendar.getLastDate = function(a, b) {
	return new Date(a, b, 0).getDate()
};
jindo.Calendar.getWeeks = function(a, c) {
	var d = this.getFirstDay(a, c), b = this.getLastDate(a, c);
	return Math.ceil((d + b) / 7)
};
jindo.Calendar.getRelativeDate = function(c, d, b, a) {
	return this.getDateHashTable(new Date(a.nYear + c, a.nMonth + d - 1,
			a.nDate + b))
};
jindo.Calendar.isPast = function(a, b) {
	if (this.getTime(a) < this.getTime(b)) {
		return true
	}
	return false
};
jindo.Calendar.isFuture = function(a, b) {
	if (this.getTime(a) > this.getTime(b)) {
		return true
	}
	return false
};
jindo.Calendar.isSameDate = function(a, b) {
	if (this.getTime(a) == this.getTime(b)) {
		return true
	}
	return false
};
jindo.Calendar.isBetween = function(a, c, b) {
	if (this.isFuture(a, b) || this.isPast(a, c)) {
		return false
	} else {
		return true
	}
};
jindo.LayerManager = jindo
		.$Class(
				{
					_bIsActivating : false,
					_bIsLayerVisible : false,
					_bIsHiding : false,
					_bIsShowing : false,
					_aLink : null,
					$init : function(a, b) {
						this.option({
							sCheckEvent : "click",
							nCheckDelay : 100,
							nShowDelay : 0,
							nHideDelay : 100,
							sMethod : "show",
							nDuration : 200,
							Transition : {
								fFadeIn : jindo.Effect.cubicEaseOut,
								fFadeOut : jindo.Effect.cubicEaseIn,
								fSlideDown : jindo.Effect.cubicEaseOut,
								fSlideUp : jindo.Effect.cubicEaseIn
							}
						});
						this.option(b || {});
						this.setLayer(a);
						this._aLink = [];
						this._oShowTimer = new jindo.Timer();
						this._oHideTimer = new jindo.Timer();
						this._oEventTimer = new jindo.Timer();
						this._wfOnEvent = jindo.$Fn(this._onEvent, this);
						this.getVisible();
						this.activate()
					},
					_onActivate : function() {
						this._wfOnEvent.attach(document, this
								.option("sCheckEvent"))
					},
					_onDeactivate : function() {
						this._wfOnEvent.detach(document, this
								.option("sCheckEvent"))
					},
					getVisible : function() {
						return this._bIsLayerVisible = (this._wel.visible() && this._wel
								.opacity() > 0)
					},
					_check : function(d) {
						var b = jindo.$Element(d);
						for (var c = 0, a; a = this._aLink[c]; c++) {
							a = jindo.$Element(a).$value();
							if (a && (d == a || b.isChildOf(a))) {
								return true
							}
						}
						return false
					},
					_find : function(c) {
						for (var b = 0, a; (a = this._aLink[b]); b++) {
							if (a == c) {
								return b
							}
						}
						return -1
					},
					getLayer : function() {
						return this._el
					},
					setLayer : function(b) {
						this._el = jindo.$(b);
						this._wel = jindo.$Element(b);
						var c = this._el.cloneNode(true);
						var a = jindo.$Element(c);
						a.css({
							position : "absolute",
							left : "-5000px"
						}).appendTo(this._el.parentNode);
						a.show();
						this._nLayerHeight = a.height();
						a.height(this._nLayerHeight);
						this._sLayerCSSHeight = a.css("height");
						this._sLayerCSSOverflowX = this._wel.css("overflowX");
						this._sLayerCSSOverflowY = this._wel.css("overflowY");
						a.css("overflow", "hidden").height(0);
						this._nSlideMinHeight = a.height() + 1;
						a.leave();
						return this
					},
					_transform : function() {
						this._wel.css({
							overflowX : "hidden",
							overflowY : "hidden"
						})
					},
					_restore : function() {
						this._wel.css({
							overflowX : this._sLayerCSSOverflowX,
							overflowY : this._sLayerCSSOverflowY
						})
					},
					getLinks : function() {
						return this._aLink
					},
					setLinks : function(b) {
						this._aLink = jindo.$A(b).unique().$value();
						return this
					},
					link : function(b) {
						if (arguments.length > 1) {
							for (var c = 0, a = arguments.length; c < a; c++) {
								this.link(arguments[c])
							}
							return this
						}
						if (this._find(b) != -1) {
							return this
						}
						this._aLink.push(b);
						return this
					},
					unlink : function(c) {
						if (arguments.length > 1) {
							for (var d = 0, b = arguments.length; d < b; d++) {
								this.unlink(arguments[d])
							}
							return this
						}
						var a = this._find(c);
						if (a > -1) {
							this._aLink.splice(a, 1)
						}
						return this
					},
					_fireEventBeforeShow : function() {
						this._transform();
						return this.fireEvent("beforeShow", {
							elLayer : this.getLayer(),
							aLinkedElement : this.getLinks(),
							sMethod : this.option("sMethod")
						})
					},
					_fireEventAppear : function() {
						this.fireEvent("appear", {
							elLayer : this.getLayer(),
							aLinkedElement : this.getLinks(),
							sMethod : this.option("sMethod")
						})
					},
					_fireEventShow : function() {
						this._bIsShowing = false;
						this._restore();
						this.fireEvent("show", {
							elLayer : this.getLayer(),
							aLinkedElement : this.getLinks(),
							sMethod : this.option("sMethod")
						})
					},
					_fireEventBeforeHide : function() {
						this._transform();
						return this.fireEvent("beforeHide", {
							elLayer : this.getLayer(),
							aLinkedElement : this.getLinks(),
							sMethod : this.option("sMethod")
						})
					},
					_fireEventHide : function() {
						this._bIsHiding = false;
						this._restore();
						this.fireEvent("hide", {
							elLayer : this.getLayer(),
							aLinkedElement : this.getLinks(),
							sMethod : this.option("sMethod")
						})
					},
					_show : function(b, a) {
						this._oEventTimer.abort();
						this._bIsShowing = true;
						this._bIsHiding = false;
						if (a > 0) {
							this._oShowTimer.start(b, a)
						} else {
							this._oHideTimer.abort();
							b()
						}
					},
					_hide : function(b, a) {
						this._bIsShowing = false;
						this._bIsHiding = true;
						if (a > 0) {
							this._oHideTimer.start(b, a)
						} else {
							this._oShowTimer.abort();
							b()
						}
					},
					_getShowMethod : function() {
						switch (this.option("sMethod")) {
						case "show":
							return "showIn";
						case "fade":
							return "fadeIn";
						case "slide":
							return "slideDown"
						}
					},
					_getHideMethod : function() {
						switch (this.option("sMethod")) {
						case "show":
							return "hideOut";
						case "fade":
							return "fadeOut";
						case "slide":
							return "slideUp"
						}
					},
					show : function(a) {
						if (typeof a == "undefined") {
							a = this.option("nShowDelay")
						}
						this[this._getShowMethod()](a);
						return this
					},
					hide : function(a) {
						if (typeof a == "undefined") {
							a = this.option("nHideDelay")
						}
						this[this._getHideMethod()](a);
						return this
					},
					showIn : function(a) {
						if (typeof a == "undefined") {
							a = this.option("nShowDelay")
						}
						var b = this;
						this._show(function() {
							b._sAppliedMethod = "show";
							if (!b.getVisible()) {
								if (b._fireEventBeforeShow()) {
									b._wel.show();
									b._fireEventAppear();
									b._fireEventShow()
								}
							}
						}, a);
						return this
					},
					hideOut : function(a) {
						if (typeof a == "undefined") {
							a = this.option("nHideDelay")
						}
						var b = this;
						this._hide(function() {
							b._sAppliedMethod = "show";
							if (b.getVisible()) {
								if (b._fireEventBeforeHide()) {
									b._wel.hide();
									b._fireEventHide()
								}
							}
						}, a);
						return this
					},
					_getTransition : function() {
						if (this._oTransition) {
							return this._oTransition
						} else {
							return (this._oTransition = new jindo.Transition()
									.fps(30))
						}
					},
					fadeIn : function(b) {
						var a = this._getTransition();
						a.detachAll().abort();
						if (typeof b == "undefined") {
							b = this.option("nShowDelay")
						}
						var d = this.option("nDuration");
						var c = this;
						this
								._show(
										function() {
											c._sAppliedMethod = "fade";
											var e = c.getLayer();
											if (!c._wel.visible()
													|| c._wel.opacity() != 1) {
												if (c._fireEventBeforeShow()) {
													if (!c._wel.visible()) {
														c._wel.opacity(0);
														c._wel.show()
													}
													d *= (1 - c._wel.opacity());
													a
															.attach(
																	{
																		playing : function(
																				f) {
																			if (f.nStep === 1) {
																				this
																						.detach(
																								"playing",
																								arguments.callee);
																				c
																						._fireEventAppear()
																			}
																		},
																		end : function(
																				f) {
																			this
																					.detach(
																							"end",
																							arguments.callee);
																			c
																					._fireEventShow()
																		}
																	})
															.start(
																	d,
																	e,
																	{
																		"@opacity" : c
																				.option("Transition").fFadeIn
																				.apply(
																						null,
																						[ 1 ])
																	})
												}
											}
										}, b);
						return this
					},
					fadeOut : function(b) {
						var a = this._getTransition();
						a.detachAll().abort();
						if (typeof b == "undefined") {
							b = this.option("nHideDelay")
						}
						var d = this.option("nDuration");
						var c = this;
						this
								._hide(
										function() {
											c._sAppliedMethod = "fade";
											if (c.getVisible()) {
												var e = c.getLayer();
												if (c._fireEventBeforeHide()) {
													d *= c._wel.opacity();
													a
															.attach(
																	{
																		end : function(
																				f) {
																			this
																					.detach(
																							"end",
																							arguments.callee);
																			c._wel
																					.hide();
																			c._wel
																					.opacity(1);
																			c
																					._fireEventHide()
																		}
																	})
															.start(
																	d,
																	e,
																	{
																		"@opacity" : c
																				.option("Transition").fFadeOut
																				.apply(
																						null,
																						[ 0 ])
																	})
												}
											}
										}, b);
						return this
					},
					slideDown : function(b) {
						var a = this._getTransition();
						a.detachAll().abort();
						if (typeof b == "undefined") {
							b = this.option("nShowDelay")
						}
						var d = this.option("nDuration");
						var c = this;
						this
								._show(
										function() {
											c._sAppliedMethod = "slide";
											var e = c.getLayer();
											if (Math.ceil(c._wel.height()) < c._nLayerHeight) {
												if (c._fireEventBeforeShow()) {
													if (!c.getVisible()) {
														c._wel.height(0).show()
													} else {
														d = Math
																.ceil(d
																		* ((c._nLayerHeight - c._wel
																				.height()) / (c._nLayerHeight - c._nSlideMinHeight)))
													}
													a
															.attach(
																	{
																		playing : function(
																				f) {
																			if (f.nStep === 1) {
																				this
																						.detach(
																								"playing",
																								arguments.callee);
																				c
																						._fireEventAppear()
																			}
																		},
																		end : function(
																				f) {
																			this
																					.detach(
																							"end",
																							arguments.callee);
																			c
																					._fireEventShow()
																		}
																	})
															.start(
																	d,
																	{
																		getter : function(
																				f) {
																			return jindo
																					.$Element(e)[f]
																					() + 1
																		},
																		setter : function(
																				g,
																				f) {
																			jindo
																					.$Element(e)[g]
																					(parseFloat(f))
																		}
																	},
																	{
																		height : c
																				.option("Transition").fSlideDown
																				.apply(
																						null,
																						[ c._nLayerHeight ])
																	})
												}
											}
										}, b);
						return this
					},
					slideUp : function(b) {
						var a = this._getTransition();
						a.detachAll().abort();
						if (typeof b == "undefined") {
							b = this.option("nHideDelay")
						}
						var d = this.option("nDuration");
						var c = this;
						this
								._hide(
										function() {
											c._sAppliedMethod = "slide";
											var e = c.getLayer();
											if (c.getVisible()) {
												if (c._fireEventBeforeHide()) {
													d = Math
															.ceil(d
																	* (c._wel
																			.height() / c._nLayerHeight));
													a
															.attach(
																	{
																		end : function(
																				f) {
																			c._wel
																					.hide()
																					.css(
																							{
																								height : c._sLayerCSSHeight
																							});
																			this
																					.detach(
																							"end",
																							arguments.callee);
																			c
																					._fireEventHide()
																		}
																	})
															.start(
																	d,
																	{
																		getter : function(
																				f) {
																			return jindo
																					.$Element(e)[f]
																					()
																		},
																		setter : function(
																				g,
																				f) {
																			jindo
																					.$Element(e)[g]
																					(Math
																							.ceil(f))
																		}
																	},
																	{
																		height : c
																				.option("Transition").fSlideUp
																				.apply(
																						null,
																						[ c._nSlideMinHeight ])
																	})
												}
											}
										}, b);
						return this
					},
					toggle : function(a) {
						if (!this.getVisible() || this._bIsHiding) {
							this.show(a || this.option("nShowDelay"))
						} else {
							this.hide(a || this.option("nHideDelay"))
						}
						return this
					},
					_onEvent : function(b) {
						var c = b.element, a = this;
						this._oEventTimer.start(function() {
							if (!a._bIsHiding && a.getVisible()) {
								if (a._check(c)) {
									if (!a._bIsShowing) {
										a.fireEvent("ignore", {
											sCheckEvent : a
													.option("sCheckEvent")
										});
										a._oHideTimer.abort();
										a._bIsHiding = false
									}
								} else {
									if (typeof c.tagName != "undefined") {
										a.hide()
									}
								}
							}
						}, this.option("nCheckDelay"))
					}
				}).extend(jindo.UIComponent);
jindo.LayerPosition = jindo
		.$Class(
				{
					$init : function(b, a, c) {
						this.option({
							sPosition : "outside-bottom",
							sAlign : "left",
							sValign : "",
							nTop : 0,
							nLeft : 0,
							bAuto : false
						});
						this.option(c || {});
						this.setElement(b);
						if (a) {
							this.setLayer(a)
						}
						if (b && a) {
							this.setPosition()
						}
						this._wfSetPosition = jindo.$Fn(function() {
							var d = this._elLayer;
							if (d && this._welLayer.visible()) {
								if (this.fireEvent("beforeAdjust", {
									elLayer : d,
									htCurrentPosition : this
											.getCurrentPosition(),
									htAdjustedPosition : this
											._adjustPosition(this
													.getCurrentPosition())
								})) {
									this.setPosition();
									this.fireEvent("adjust", {
										elLayer : d,
										htCurrentPosition : this
												.getCurrentPosition()
									})
								}
							}
						}, this);
						if (this.option("bAuto")) {
							this._wfSetPosition.attach(window, "scroll")
									.attach(window, "resize")
						}
					},
					getElement : function() {
						return this._el
					},
					setElement : function(a) {
						this._el = jindo.$(a);
						this._wel = jindo.$Element(a);
						return this
					},
					getLayer : function() {
						return this._elLayer
					},
					setLayer : function(a) {
						this._elLayer = jindo.$(a);
						this._welLayer = jindo.$Element(a);
						document.body.appendChild(a);
						return this
					},
					_isPosition : function(b, a) {
						if (b.sPosition.indexOf(a) > -1) {
							return true
						}
						return false
					},
					_setLeftRight : function(i, b) {
						var c = this.getElement(), e = this.getLayer(), g = c.offsetWidth, d = e.offsetWidth;
						if (c == document.body) {
							g = jindo.$Document().clientSize().width
						}
						var a = this._isPosition(i, "left"), h = this
								._isPosition(i, "right"), f = this._isPosition(
								i, "inside");
						if (a) {
							if (f) {
								b.nLeft += i.nLeft
							} else {
								b.nLeft -= d;
								b.nLeft -= i.nLeft
							}
						} else {
							if (h) {
								b.nLeft += g;
								if (f) {
									b.nLeft -= d;
									b.nLeft -= i.nLeft
								} else {
									b.nLeft += i.nLeft
								}
							} else {
								if (i.sAlign == "left") {
									b.nLeft += i.nLeft
								}
								if (i.sAlign == "center") {
									b.nLeft += (g - d) / 2
								}
								if (i.sAlign == "right") {
									b.nLeft += g - d;
									b.nLeft -= i.nLeft
								}
							}
						}
						return b
					},
					_setVerticalAlign : function(e, f) {
						var c = this.getElement(), b = this.getLayer(), a = c.offsetHeight, d = b.offsetHeight;
						if (c == document.body) {
							a = jindo.$Document().clientSize().height
						}
						switch (e.sValign) {
						case "top":
							f.nTop += e.nTop;
							break;
						case "middle":
							f.nTop += (a - d) / 2;
							break;
						case "bottom":
							f.nTop += a - d - e.nTop;
							break
						}
						return f
					},
					_adjustScrollPosition : function(a) {
						if (this.getElement() == document.body) {
							var b = jindo.$Document().scrollPosition();
							a.nTop += b.top;
							a.nLeft += b.left
						}
						return a
					},
					getPosition : function(m) {
						if (typeof m != "object") {
							m = this.option()
						}
						if (typeof m.nTop == "undefined") {
							m.nTop = 0
						}
						if (typeof m.nLeft == "undefined") {
							m.nLeft = 0
						}
						var a, j = this._isPosition(m, "center"), h = this
								._isPosition(m, "inside"), i = this
								._isPosition(m, "top"), s = this._isPosition(m,
								"bottom"), n = this._isPosition(m, "left"), c = this
								._isPosition(m, "right");
						if (n) {
							a = "left"
						}
						if (c) {
							a = "right"
						}
						if (i) {
							a = "top"
						}
						if (s) {
							a = "bottom"
						}
						if (j) {
							a = "center"
						}
						var b = this.getElement(), o = jindo.$Element(b), q = this
								.getLayer(), l = jindo.$Element(q), f = o
								.offset(), g = b.offsetWidth, p = b.offsetHeight, r, d = q.offsetWidth, e = q.offsetHeight, k = {
							nTop : f.top,
							nLeft : f.left
						};
						if (b == document.body) {
							r = jindo.$Document().clientSize();
							g = r.width;
							p = r.height
						}
						d += parseInt(l.css("marginLeft"))
								+ parseInt(l.css("marginRight")) || 0;
						e += parseInt(l.css("marginTop"))
								+ parseInt(l.css("marginBottom")) || 0;
						switch (a) {
						case "center":
							k.nTop += (p - e) / 2;
							k.nTop += m.nTop;
							k.nLeft += (g - d) / 2;
							k.nLeft += m.nLeft;
							break;
						case "top":
							if (h) {
								k.nTop += m.nTop
							} else {
								k.nTop -= m.nTop + e
							}
							k = this._setLeftRight(m, k);
							break;
						case "bottom":
							k.nTop += p;
							if (h) {
								k.nTop -= m.nTop + e
							} else {
								k.nTop += m.nTop
							}
							k = this._setLeftRight(m, k);
							break;
						case "left":
							if (h) {
								k.nLeft += m.nLeft
							} else {
								k.nLeft -= m.nLeft + d
							}
							k = this._setVerticalAlign(m, k);
							break;
						case "right":
							k.nLeft += g;
							if (h) {
								k.nLeft -= m.nLeft + d
							} else {
								k.nLeft += m.nLeft
							}
							k = this._setVerticalAlign(m, k);
							break
						}
						k = this._adjustScrollPosition(k);
						return k
					},
					setPosition : function(b) {
						var a = jindo.$Element(this.getLayer());
						a.css("left", "-9999px").css("top", "0px");
						if (typeof b == "undefined") {
							b = this.getPosition()
						}
						if (this.option("bAuto")) {
							b = this._adjustPosition(b)
						}
						a.css("left", b.nLeft + "px").css("top", b.nTop + "px");
						return this
					},
					getCurrentPosition : function() {
						var a = jindo.$Element(this.getLayer());
						return {
							nTop : parseInt(a.css("top")),
							nLeft : parseInt(a.css("left"))
						}
					},
					_isFullyVisible : function(c) {
						var e = this.getLayer(), i = jindo.$Element(e), g = jindo
								.$Document().scrollPosition(), h = g.top, b = g.left, a = jindo
								.$Document().clientSize(), d = e.offsetWidth
								+ (parseInt(i.css("marginLeft"))
										+ parseInt(i.css("marginRight")) || 0), f = e.offsetHeight
								+ (parseInt(i.css("marginTop"))
										+ parseInt(i.css("marginBottom")) || 0);
						if (c.nLeft >= 0 && c.nTop >= 0
								&& a.width >= c.nLeft - b + d
								&& a.height >= c.nTop - h + f) {
							return true
						}
						return false
					},
					_mirrorHorizontal : function(c) {
						if (c.sAlign == "center"
								|| c.sPosition == "inside-center") {
							return c
						}
						var a = {};
						for ( var b in c) {
							a[b] = c[b]
						}
						if (this._isPosition(a, "right")) {
							a.sPosition = a.sPosition.replace(/right/, "left")
						} else {
							if (this._isPosition(a, "left")) {
								a.sPosition = a.sPosition.replace(/left/,
										"right")
							} else {
								if (a.sAlign == "right") {
									a.sAlign = "left"
								} else {
									if (a.sAlign == "left") {
										a.sAlign = "right"
									}
								}
							}
						}
						return a
					},
					_mirrorVertical : function(c) {
						if (c.sValign == "middle"
								|| c.sPosition == "inside-center") {
							return c
						}
						var a = {};
						for ( var b in c) {
							a[b] = c[b]
						}
						if (this._isPosition(a, "top")) {
							a.sPosition = a.sPosition.replace(/top/, "bottom")
						} else {
							if (this._isPosition(a, "bottom")) {
								a.sPosition = a.sPosition.replace(/bottom/,
										"top")
							} else {
								if (a.sValign == "top") {
									a.sValign = "bottom"
								} else {
									if (a.sValign == "bottom") {
										a.sValign = "top"
									}
								}
							}
						}
						return a
					},
					_adjustPosition : function(d) {
						var c = this.option(), a = [];
						a.push(d);
						a.push(this.getPosition(this._mirrorHorizontal(c)));
						a.push(this.getPosition(this._mirrorVertical(c)));
						a.push(this.getPosition(this._mirrorVertical(this
								._mirrorHorizontal(c))));
						for (var b = 0, e; e = a[b]; b++) {
							if (this._isFullyVisible(e)) {
								d = e;
								break
							}
						}
						return d
					}
				}).extend(jindo.Component);
jindo.Timer = jindo.$Class({
	$init : function() {
		this._nTimer = null;
		this._nLatest = null;
		this._nRemained = 0;
		this._nDelay = null;
		this._fRun = null;
		this._bIsRunning = false
	},
	start : function(b, a) {
		this.abort();
		this._nRemained = 0;
		this._nDelay = a;
		this._fRun = b;
		this._bIsRunning = true;
		this._nLatest = this._getTime();
		this.fireEvent("wait");
		this._excute(this._nDelay, false);
		return true
	},
	isRunning : function() {
		return this._bIsRunning
	},
	_getTime : function() {
		return new Date().getTime()
	},
	_clearTimer : function() {
		var a = false;
		if (this._nTimer) {
			clearInterval(this._nTimer);
			this._bIsRunning = false;
			a = true
		}
		this._nTimer = null;
		return a
	},
	abort : function() {
		var a = this._clearTimer();
		if (a) {
			this.fireEvent("abort");
			this._fRun = null
		}
		return a
	},
	pause : function() {
		var a = this._getTime() - this._nLatest;
		this._nRemained = Math.max(this._nDelay - a, 0);
		return this._clearTimer()
	},
	_excute : function(b, a) {
		var c = this;
		this._clearTimer();
		this._bIsRunning = true;
		this._nTimer = setInterval(function() {
			if (c._nTimer) {
				c.fireEvent("run");
				var d = c._fRun();
				c._nLatest = c._getTime();
				if (!d) {
					clearInterval(c._nTimer);
					c._nTimer = null;
					c._bIsRunning = false;
					c.fireEvent("end");
					return
				}
				c.fireEvent("wait");
				if (a) {
					c._excute(c._nDelay, false)
				}
			}
		}, b)
	},
	resume : function() {
		if (!this._fRun || this.isRunning()) {
			return false
		}
		this._bIsRunning = true;
		this.fireEvent("wait");
		this._excute(this._nRemained, true);
		this._nRemained = 0;
		return true
	}
}).extend(jindo.Component);
jindo.Transition = jindo
		.$Class(
				{
					_nFPS : 30,
					_aTaskQueue : null,
					_oTimer : null,
					_bIsWaiting : true,
					_bIsPlaying : false,
					$init : function(a) {
						this._aTaskQueue = [];
						this._oTimer = new jindo.Timer();
						this.option({
							fEffect : jindo.Effect.linear,
							bCorrection : false
						});
						this.option(a || {})
					},
					fps : function(a) {
						if (arguments.length > 0) {
							this._nFPS = a;
							return this
						}
						return this._nFPS
					},
					isPlaying : function() {
						return this._bIsPlaying
					},
					abort : function() {
						this._aTaskQueue = [];
						this._oTimer.abort();
						if (this._bIsPlaying) {
							this.fireEvent("abort")
						}
						this._bIsWaiting = true;
						this._bIsPlaying = false;
						this._htTaskToDo = null;
						return this
					},
					start : function(c, b, a) {
						if (arguments.length > 0) {
							this.queue.apply(this, arguments)
						}
						this._prepareNextTask();
						return this
					},
					queue : function(g, f) {
						var b;
						if (typeof arguments[0] == "function") {
							b = {
								sType : "function",
								fTask : arguments[0]
							}
						} else {
							var k = [];
							var m = arguments.length;
							if (arguments[1] instanceof Array) {
								k = arguments[1]
							} else {
								var h = [];
								jindo.$A(arguments).forEach(function(a, n) {
									if (n > 0) {
										h.push(a);
										if (n % 2 == 0) {
											k.push(h.concat());
											h = []
										}
									}
								})
							}
							b = {
								sType : "task",
								nDuration : g,
								aList : []
							};
							for (var e = 0; e < k.length; e++) {
								var d = [];
								var j = k[e][1];
								var c;
								for ( var l in j) {
									c = j[l];
									if (/^(@|style\.)(\w+)/i.test(l)) {
										d.push([ "style", RegExp.$2, c ])
									} else {
										d.push([ "attr", l, c ])
									}
								}
								b.aList.push({
									elTarget : k[e][0],
									aValue : d
								})
							}
						}
						this._queueTask(b);
						return this
					},
					pause : function() {
						if (this._oTimer.abort()) {
							this.fireEvent("pause")
						}
						return this
					},
					resume : function() {
						if (this._htTaskToDo) {
							if (this._bIsWaiting === false
									&& this._bIsPlaying === true) {
								this.fireEvent("resume")
							}
							this._doTask();
							this._bIsWaiting = false;
							this._bIsPlaying = true;
							var a = this;
							this._oTimer.start(function() {
								var b = !a._doTask();
								if (b) {
									a._bIsWaiting = true;
									setTimeout(function() {
										a._prepareNextTask()
									}, 0)
								}
								return !b
							}, this._htTaskToDo.nInterval)
						}
						return this
					},
					precede : function(c, b, a) {
						this.start.apply(this, arguments);
						return this
					},
					sleep : function(b, a) {
						if (typeof a == "undefined") {
							a = function() {
							}
						}
						this._queueTask({
							sType : "sleep",
							nDuration : b,
							fCallback : a
						});
						this._prepareNextTask();
						return this
					},
					_queueTask : function(a) {
						this._aTaskQueue.push(a)
					},
					_dequeueTask : function() {
						var c = this._aTaskQueue.shift();
						if (c) {
							if (c.sType == "task") {
								var g = c.aList;
								for (var f = 0, m = g.length; f < m; f++) {
									var b = g[f].elTarget;
									for (var e = 0, d = g[f].aValue, l = d.length; e < l; e++) {
										var a = d[e][0];
										var k = d[e][2];
										if (typeof k != "function") {
											if (k instanceof Array) {
												k = this.option("fEffect")(
														k[0], k[1])
											} else {
												k = this.option("fEffect")(k)
											}
										}
										if (k.setStart) {
											if (this._isHTMLElement(b)) {
												var h = jindo.$Element(b);
												switch (a) {
												case "style":
													k.setStart(h.css(d[e][1]));
													break;
												case "attr":
													k
															.setStart(h
																	.$value()[d[e][1]]);
													break
												}
											} else {
												k.setStart(b.getter(d[e][1]))
											}
										}
										d[e][2] = k
									}
								}
							}
							return c
						} else {
							return null
						}
					},
					_prepareNextTask : function() {
						if (this._bIsWaiting) {
							var d = this._dequeueTask();
							if (d) {
								switch (d.sType) {
								case "task":
									if (!this._bIsPlaying) {
										this.fireEvent("start")
									}
									var b = 1000 / this._nFPS;
									var c = b / d.nDuration;
									this._htTaskToDo = {
										aList : d.aList,
										nRatio : 0,
										nInterval : b,
										nGap : c,
										nStep : 0,
										nTotalStep : Math.ceil(d.nDuration / b)
									};
									this.resume();
									break;
								case "function":
									if (!this._bIsPlaying) {
										this.fireEvent("start")
									}
									d.fTask();
									this._prepareNextTask();
									break;
								case "sleep":
									if (this._bIsPlaying) {
										this.fireEvent("sleep", {
											nDuration : d.nDuration
										});
										d.fCallback()
									}
									var a = this;
									setTimeout(function() {
										a.fireEvent("awake");
										a._prepareNextTask()
									}, d.nDuration);
									break
								}
							} else {
								if (this._bIsPlaying) {
									this._bIsPlaying = false;
									this.abort();
									this.fireEvent("end")
								}
							}
						}
					},
					_isHTMLElement : function(a) {
						return ("tagName" in a)
					},
					_doTask : function() {
						var f = this._htTaskToDo, c = parseFloat(f.nRatio
								.toFixed(5), 1), h = f.nStep, e = f.nTotalStep, u = f.aList, d = {};
						var a = this.option("bCorrection");
						for (var r = 0, n = u.length; r < n; r++) {
							var t = u[r].elTarget;
							for (var q = 0, s = u[r].aValue, v = s.length; q < v; q++) {
								var g = s[q][0], l = s[q][1], b = s[q][2](c);
								if (this._isHTMLElement(t)) {
									var o = jindo.$Element(t);
									if (a) {
										var p = /^[0-9]*([^0-9]*)$/.test(b)
												&& RegExp.$1 || "";
										if (p) {
											var k = parseFloat(b);
											var m;
											k += d[l] || 0;
											k = parseFloat(k.toFixed(5));
											if (r == n - 1) {
												b = Math.round(k) + p
											} else {
												m = parseFloat(/(\.[0-9]+)$/
														.test(k)
														&& RegExp.$1 || 0);
												b = parseInt(k, 10) + p;
												d[l] = m
											}
										}
									}
									switch (g) {
									case "style":
										o.css(l, b);
										break;
									case "attr":
										o.$value()[l] = b;
										break
									}
								} else {
									t.setter(l, b)
								}
								if (this._bIsPlaying) {
									this.fireEvent("playing", {
										element : t,
										sKey : l,
										sValue : b,
										nStep : h,
										nTotalStep : e
									})
								}
							}
						}
						f.nRatio = Math.min(f.nRatio + f.nGap, 1);
						f.nStep += 1;
						return c != 1
					}
				}).extend(jindo.Component);
(function() {
	var a = jindo.$Element.prototype.css;
	jindo.$Element.prototype.css = function(c, b) {
		if (c == "opacity") {
			return typeof b != "undefined" ? this.opacity(parseFloat(b)) : this
					.opacity()
		} else {
			return typeof b != "undefined" ? a.call(this, c, b) : a.call(this,
					c)
		}
	}
})();
jindo.Effect = function(e) {
	if (this instanceof arguments.callee) {
		throw new Error("You can't create a instance of this")
	}
	var c = /^(\-?[0-9\.]+)(%|px|pt|em)?$/;
	var d = /^rgb\(([0-9]+)\s?,\s?([0-9]+)\s?,\s?([0-9]+)\)$/i;
	var f = /^#([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})$/i;
	var b = /^#([0-9A-F])([0-9A-F])([0-9A-F])$/i;
	var a = function(h) {
		var i = h, g;
		if (c.test(h)) {
			i = parseFloat(h);
			g = RegExp.$2
		} else {
			if (d.test(h)) {
				i = [ parseInt(RegExp.$1, 10), parseInt(RegExp.$2, 10),
						parseInt(RegExp.$3, 10) ];
				g = "color"
			} else {
				if (f.test(h = h.replace(b, "#$1$1$2$2$3$3"))) {
					i = [ parseInt(RegExp.$1, 16), parseInt(RegExp.$2, 16),
							parseInt(RegExp.$3, 16) ];
					g = "color"
				}
			}
		}
		return {
			nValue : i,
			sUnit : g
		}
	};
	return function(i, j) {
		var g;
		if (arguments.length > 1) {
			i = a(i);
			j = a(j);
			g = j.sUnit
		} else {
			j = a(i);
			i = null;
			g = j.sUnit
		}
		if (i && j && i.sUnit != j.sUnit) {
			throw new Error("unit error")
		}
		i = i && i.nValue;
		j = j && j.nValue;
		var h = function(n) {
			var l = e(n);
			var o = function(p, q) {
				return (q - p) * l + p + g
			};
			if (g == "color") {
				var m = parseInt(o(i[0], j[0]), 10) << 16;
				m |= parseInt(o(i[1], j[1]), 10) << 8;
				m |= parseInt(o(i[2], j[2]), 10);
				m = m.toString(16).toUpperCase();
				for (var k = 0; 6 - m.length; k++) {
					m = "0" + m
				}
				return "#" + m
			}
			return o(i, j)
		};
		if (i === null) {
			h.setStart = function(k) {
				k = a(k);
				if (k.sUnit != g) {
					throw new Error("unit eror")
				}
				i = k.nValue
			}
		}
		return h
	}
};
jindo.Effect.linear = jindo.Effect(function(a) {
	return a
});
jindo.Effect.easeIn = jindo.Effect(function(a) {
	return (1 - Math.sqrt(1 - (a * a)))
});
jindo.Effect.easeOut = jindo.Effect(function(a) {
	return Math.sqrt((2 - a) * a)
});
jindo.Effect.bounce = jindo.Effect(function(a) {
	if (a < (1 / 2.75)) {
		return (7.5625 * a * a)
	} else {
		if (a < (2 / 2.75)) {
			return (7.5625 * (a -= (1.5 / 2.75)) * a + 0.75)
		} else {
			if (a < (2.5 / 2.75)) {
				return (7.5625 * (a -= (2.25 / 2.75)) * a + 0.9375)
			} else {
				return (7.5625 * (a -= (2.625 / 2.75)) * a + 0.984375)
			}
		}
	}
});
jindo.Effect._cubicBezier = function(b, d, a, c) {
	return function(n) {
		var j = 3 * b, l = 3 * (a - b) - j, e = 1 - j - l, i = 3 * d, k = 3
				* (c - d) - i, m = 1 - i - k;
		function h(o) {
			return ((e * o + l) * o + j) * o
		}
		function g(o) {
			return ((m * o + k) * o + i) * o
		}
		function f(o, v) {
			var u = 0, t = 1, r = o, p, s;
			for (var q = 0; q < 8; q++) {
				p = h(r) - o;
				if (Math.abs(p) < v) {
					return r
				}
				s = (3 * e * r + 2 * l) * r + j;
				if (Math.abs(s) < 0.000001) {
					break
				}
				r = r - p / s
			}
			if (r < u) {
				return u
			}
			if (r > t) {
				return t
			}
			while (u < t) {
				p = h(r);
				if (Math.abs(p - o) < v) {
					return r
				}
				if (o > p) {
					u = r
				} else {
					t = r
				}
				r = (t - u) * 0.5 + u
			}
			return r
		}
		return g(f(n, (1 / 1000)))
	}
};
jindo.Effect.cubicBezier = function(b, d, a, c) {
	return jindo.Effect(jindo.Effect._cubicBezier(b, d, a, c))
};
jindo.Effect.overphase = jindo.Effect.cubicBezier(0.25, 0.75, 0.8, 1.3);
jindo.Effect.easeInOut = jindo.Effect.cubicBezier(0.75, 0, 0.25, 1);
jindo.Effect.easeOutIn = jindo.Effect.cubicBezier(0.25, 0.75, 0.75, 0.25);
jindo.Effect.cubicEase = jindo.Effect.cubicBezier(0.25, 0.1, 0.25, 1);
jindo.Effect.cubicEaseIn = jindo.Effect.cubicBezier(0.42, 0, 1, 1);
jindo.Effect.cubicEaseOut = jindo.Effect.cubicBezier(0, 0, 0.58, 1);
jindo.Effect.cubicEaseInOut = jindo.Effect.cubicBezier(0.42, 0, 0.58, 1);
jindo.Effect.cubicEaseOutIn = jindo.Effect.cubicBezier(0, 0.42, 1, 0.58);
jindo.Effect.pulse = function(a) {
	return jindo.Effect(function(b) {
		return (-Math.cos((b * (a - 0.5) * 2) * Math.PI) / 2) + 0.5
	})
};
jindo.FileUploader = jindo
		.$Class(
				{
					_bIsActivating : false,
					_aHiddenInput : [],
					$init : function(a, b) {
						var c = {
							sUrl : "",
							sCallback : "",
							htData : {},
							sFiletype : "*",
							sMsgNotAllowedExt : "업로드가 허용되지 않는 파일형식입니다",
							bAutoUpload : false,
							bAutoReset : true,
							bActivateOnload : true
						};
						this.option(c);
						this.option(b || {});
						this._el = jindo.$(a);
						this._wel = jindo.$Element(this._el);
						this._elForm = this._el.form;
						this._aHiddenInput = [];
						this.constructor._oCallback = {};
						this._wfChange = jindo.$Fn(this._onFileSelectChange,
								this);
						this._sFunctionName = null;
						if (this.option("bActivateOnload")) {
							this.activate()
						}
					},
					_appendIframe : function() {
						var a = "tmpFrame_" + this._makeUniqueId();
						this._welIframe = jindo.$Element(
								jindo.$('<iframe name="' + a + '" src="">'))
								.css({
									position : "absolute",
									width : "1px",
									height : "1px",
									left : "-100px",
									top : "-100px"
								});
						document.body.appendChild(this._welIframe.$value())
					},
					_removeIframe : function() {
						if (this._welIframe) {
							this._welIframe.leave()
						}
					},
					getBaseElement : function() {
						return this.getFileSelect()
					},
					getFileSelect : function() {
						return this._el
					},
					getFormElement : function() {
						return this._elForm
					},
					upload : function() {
						this._appendIframe();
						var d = this.getFormElement(), g = jindo.$Element(d), e = this._welIframe
								.attr("name"), b = this._sFunctionName = e
								+ "_func", a = this.option("sUrl");
						g.attr({
							target : e,
							action : a
						});
						this._aHiddenInput.push(this._createElement("input", {
							type : "hidden",
							name : "callback",
							value : this.option("sCallback")
						}));
						this._aHiddenInput.push(this._createElement("input", {
							type : "hidden",
							name : "callback_func",
							value : b
						}));
						for ( var c in this.option("htData")) {
							this._aHiddenInput.push(this._createElement(
									"input", {
										type : "hidden",
										name : c,
										value : this.option("htData")[c]
									}))
						}
						for (var f = 0; f < this._aHiddenInput.length; f++) {
							d.appendChild(this._aHiddenInput[f])
						}
						this.constructor._oCallback[b + "_success"] = jindo
								.$Fn(function(h) {
									if (this.option("bAutoReset")) {
										this.reset()
									}
									this._revertFormAttr();
									this.fireEvent("success", {
										htResult : h
									});
									this._clear()
								}, this).bind();
						this.constructor._oCallback[b + "_error"] = jindo.$Fn(
								function(h) {
									if (this.option("bAutoReset")) {
										this.reset()
									}
									this._revertFormAttr();
									this.fireEvent("error", {
										htResult : h
									});
									this._clear()
								}, this).bind();
						d.submit()
					},
					reset : function() {
						var c = jindo.$("<form>");
						this._wel.wrap(c);
						c.reset();
						jindo.$Element(c).replace(this._el);
						var b = jindo.$Agent().navigator();
						if (b.ie && b.version <= 10) {
							var a = this.getFormElement();
							a.type = "radio";
							a.type = "file"
						}
						this._clear();
						return this
					},
					_revertFormAttr : function() {
						var a = this.getFormElement(), b = jindo.$Element(a);
						b.attr({
							target : this._sPrevTarget,
							action : this._sAction
						})
					},
					_onActivate : function() {
						var a = this.getFormElement(), b = jindo.$Element(a);
						this._sPrevTarget = b.attr("target");
						this._sAction = b.attr("action");
						this._el.value = "";
						this._wfChange.attach(this._el, "change")
					},
					_onDeactivate : function() {
						this._wfChange.detach(this._el, "change")
					},
					_makeUniqueId : function() {
						return new Date().getMilliseconds()
								+ Math.floor(Math.random() * 100000)
					},
					_createElement : function(d, c) {
						var e = jindo.$("<" + d + ">");
						var b = jindo.$Element(e);
						for ( var a in c) {
							b.attr(a, c[a])
						}
						return e
					},
					_checkExtension : function(c) {
						var a = this.option("sFiletype").split(";");
						for (var b = 0, d; b < a.length; b++) {
							d = (a[b] == "*.*") ? "*" : a[b];
							d = d.replace(/^\s+|\s+$/, "");
							d = d.replace(/\./g, "\\.");
							d = d.replace(/\*/g, "[^\\/]+");
							if ((new RegExp(d + "$", "gi")).test(c)) {
								return true
							}
						}
						return false
					},
					_onFileSelectChange : function(b) {
						var d = b.element.value, a = this._checkExtension(d), c = {
							sValue : d,
							bAllowed : a,
							sMsgNotAllowedExt : this
									.option("sMsgNotAllowedExt")
						};
						if (d.length && this.fireEvent("select", c)) {
							if (a) {
								if (this.option("bAutoUpload")) {
									this.upload()
								}
							} else {
								alert(c.sMsgNotAllowedExt)
							}
						}
					},
					_clear : function() {
						if (this._sFunctionName != null) {
							delete this.constructor._oCallback[this._sFunctionName
									+ "_success"];
							delete this.constructor._oCallback[this._sFunctionName
									+ "_error"];
							this._sFunctionName = null
						}
						for (var a = 0, b = this._aHiddenInput.length; a < b; a++) {
							jindo.$Element(this._aHiddenInput[a]).leave()
						}
						this._aHiddenInput.length = 0;
						this._removeIframe()
					}
				}).extend(jindo.UIComponent);
jindo.MultipleAjaxRequest = jindo
		.$Class(
				{
					_bIsRequesting : false,
					$init : function(a) {
						var b = {
							sMode : "parallel"
						};
						this.option(b);
						this.option(a)
					},
					isRequesting : function() {
						return this._bIsRequesting
					},
					request : function(a, b) {
						if (this.isRequesting()) {
							return false
						}
						if (!(a instanceof Array)) {
							a = [ a ]
						}
						if (typeof b == "undefined") {
							b = {}
						}
						this._htMetaData = b;
						switch (this.option("sMode")) {
						case "parallel":
							this._parallelRequest(a);
							break;
						case "serial":
							this._serialRequest(a);
							break;
						default:
							return false
						}
						return true
					},
					_fireEventStart : function() {
						this._bIsRequesting = true;
						if (this.fireEvent("start", {
							aAjax : this._aAjax,
							htMetaData : this._htMetaData
						})) {
							return true
						} else {
							this.abort();
							return false
						}
					},
					_fireEventBeforeEachRequest : function(a) {
						if (this.fireEvent("beforeEachRequest", {
							oAjax : this._aAjax[a],
							nIndex : a
						})) {
							return true
						} else {
							this.abort();
							return false
						}
					},
					_fireEventAfterEachResponse : function(a) {
						if (this.fireEvent("afterEachResponse", {
							oAjax : this._aAjax[a],
							nIndex : a
						})) {
							return true
						} else {
							this.abort();
							return false
						}
					},
					_parallelRequest : function(b) {
						this._aAjaxData = b;
						this._aAjax = [];
						this._aStatus = [];
						this._aStatus.length = b.length;
						this._aResponse = [];
						if (this._fireEventStart()) {
							var a = this;
							jindo
									.$A(this._aAjaxData)
									.forEach(
											function(d, c) {
												var e = function(g) {
													g._constructor = a._aAjax[c];
													var f = a
															._findAjaxObjectIndexOfResponse(g._constructor);
													a._aResponse[f] = g;
													a._aStatus[f] = true;
													if (a
															._fireEventAfterEachResponse(f)) {
														if (a
																._hasCompletedGotResponsesOfParallelResponses()) {
															a._complete()
														}
													}
												};
												a._aAjax.push(jindo.$Ajax(
														d.sUrl, d.htOption));
												d.htOption.onload = e;
												d.htOption.onerror = e;
												d.htOption.ontimeout = e;
												a._aAjax[c].option(d.htOption);
												if (a
														._fireEventBeforeEachRequest(c)) {
													a._aAjax[c]
															.request(d.htParameter)
												} else {
													jindo.$A.Break()
												}
											})
						}
					},
					_findAjaxObjectIndexOfResponse : function(a) {
						return jindo.$A(this._aAjax).indexOf(a)
					},
					_hasCompletedGotResponsesOfParallelResponses : function() {
						var a = true;
						jindo.$A(this._aStatus).forEach(function(b) {
							if (!b) {
								a = false;
								jindo.$A.Break()
							}
						});
						return a
					},
					_serialRequest : function(b) {
						this._aAjaxData = b;
						this._aAjax = [];
						this._aStatus = [];
						this._aStatus.length = b.length;
						this._aResponse = [];
						var a = this;
						jindo.$A(this._aAjaxData).forEach(function(e, d) {
							var c = function(f) {
								f._constructor = a._aAjax[d];
								a._aResponse.push(f);
								a._serialRequestNext()
							};
							a._aAjax.push(jindo.$Ajax(e.sUrl, e.htOption));
							e.htOption.onload = c;
							e.htOption.onerror = c;
							e.htOption.ontimeout = c;
							a._aAjax[d].option(e.htOption)
						});
						if (this._fireEventStart()) {
							if (this._fireEventBeforeEachRequest(0)) {
								this._aAjax[0]
										.request(this._aAjaxData[0].htParameter);
								this._aStatus[0] = true
							}
						}
					},
					_serialRequestNext : function() {
						var a = -1;
						for (var b = 0; b < this._aStatus.length; b++) {
							if (!this._aStatus[b]) {
								this._aStatus[b] = true;
								a = b;
								break
							}
						}
						if (a > 0) {
							if (this._fireEventAfterEachResponse(a - 1)) {
								if (this._fireEventBeforeEachRequest(a)) {
									this._aAjax[a]
											.request(this._aAjaxData[a].htParameter)
								}
							}
						} else {
							if (a == -1) {
								if (this
										._fireEventAfterEachResponse(this._aStatus.length - 1)) {
									this._complete()
								}
							}
						}
					},
					_reset : function() {
						this._aAjaxData.length = 0;
						this._aAjax.length = 0;
						this._aStatus.length = 0;
						this._aResponse.length = 0;
						this._htMetaData = null;
						delete this._aAjaxData;
						delete this._aAjax;
						delete this._aStatus;
						delete this._aResponse;
						delete this._htMetaData;
						this._bIsRequesting = false
					},
					abort : function() {
						jindo.$A(this._aAjax).forEach(function(a) {
							a.abort()
						});
						this._reset()
					},
					_complete : function() {
						var b = this._aResponse.concat(), c = {}, a;
						for (a in this._htMetaData) {
							c[a] = this._htMetaData[a]
						}
						this._reset();
						this.fireEvent("complete", {
							aResponse : b,
							htMetaData : c
						})
					}
				}).extend(jindo.Component);
jindo.RolloverClick = jindo.$Class(
		{
			$init : function(b, c) {
				this.option({
					bActivateOnload : true,
					sCheckEvent : "click",
					bCheckDblClick : false,
					RolloverArea : {
						sClassName : "rollover",
						sClassPrefix : "rollover-",
						bCheckMouseDown : false,
						bActivateOnload : false,
						htStatus : {
							sOver : "over",
							sDown : "down"
						}
					}
				});
				this.option(c || {});
				var a = this;
				this._oRolloverArea = new jindo.RolloverArea(b, this
						.option("RolloverArea")).attach({
					over : function(d) {
						if (!a.fireEvent("over", d)) {
							d.stop()
						}
					},
					out : function(d) {
						if (!a.fireEvent("out", d)) {
							d.stop()
						}
					}
				});
				this._wfClick = jindo.$Fn(this._onClick, this);
				this._wfDblClick = jindo.$Fn(this._onClick, this);
				if (this.option("bActivateOnload")) {
					this.activate()
				}
			},
			_onClick : function(a) {
				var b = a.element, c = "click";
				if (a.type == "dblclick") {
					c = a.type
				}
				while (b = this._oRolloverArea._findRollover(b)) {
					this.fireEvent(c, {
						element : b,
						htStatus : this._oRolloverArea.option("htStatus"),
						weEvent : a
					});
					b = b.parentNode
				}
			},
			_onActivate : function() {
				this._wfClick.attach(this._oRolloverArea._elArea, this
						.option("sCheckEvent"));
				if (this.option("bCheckDblClick")) {
					this._wfDblClick.attach(this._oRolloverArea._elArea,
							"dblclick")
				}
				this._oRolloverArea.activate()
			},
			_onDeactivate : function() {
				this._wfClick.detach(this._oRolloverArea._elArea, this
						.option("sCheckEvent"));
				this._wfDblClick
						.detach(this._oRolloverArea._elArea, "dblclick");
				this._oRolloverArea.deactivate()
			}
		}).extend(jindo.UIComponent);
jindo.Pagination = jindo
		.$Class(
				{
					$init : function(a, b) {
						this._elPageList = jindo.$(a);
						this._welPageList = jindo.$Element(this._elPageList);
						this._waPage = jindo.$A([]);
						this._fClickPage = jindo.$Fn(this._onClickPageList,
								this);
						this.option({
							bActivateOnload : true,
							nItem : 10,
							nItemPerPage : 10,
							nPagePerPageList : 10,
							nPage : 1,
							sMoveUnit : "pagelist",
							bAlignCenter : false,
							sInsertTextNode : "",
							sClassFirst : "first-child",
							sClassLast : "last-child",
							sPageTemplate : "<a href='#'>{=page}</a>",
							sCurrentPageTemplate : "<strong>{=page}</strong>",
							elFirstPageLinkOn : jindo.$$.getSingle("a.pre_end",
									this._elPageList),
							elPrevPageLinkOn : jindo.$$.getSingle("a.pre",
									this._elPageList),
							elNextPageLinkOn : jindo.$$.getSingle("a.next",
									this._elPageList),
							elLastPageLinkOn : jindo.$$.getSingle("a.next_end",
									this._elPageList),
							elFirstPageLinkOff : jindo.$$.getSingle(
									"span.pre_end", this._elPageList),
							elPrevPageLinkOff : jindo.$$.getSingle("span.pre",
									this._elPageList),
							elNextPageLinkOff : jindo.$$.getSingle("span.next",
									this._elPageList),
							elLastPageLinkOff : jindo.$$.getSingle(
									"span.next_end", this._elPageList)
						});
						this.option(b || {});
						if (this.option("bActivateOnload")) {
							this.activate()
						}
					},
					getBaseElement : function() {
						return this._elPageList
					},
					getItemCount : function() {
						return this.option("nItem")
					},
					setItemCount : function(a) {
						this.option({
							nItem : a
						})
					},
					getItemPerPage : function() {
						return this.option("nItemPerPage")
					},
					setItemPerPage : function(a) {
						this.option("nItemPerPage", a)
					},
					getCurrentPage : function() {
						return this._nCurrentPage
					},
					getFirstItemOfPage : function(a) {
						return this.getItemPerPage() * (a - 1) + 1
					},
					getPageOfItem : function(a) {
						return Math.ceil(a / this.getItemPerPage())
					},
					_getLastPage : function() {
						return Math.ceil(this.getItemCount()
								/ this.getItemPerPage())
					},
					_getRelativePage : function(e) {
						var c = null;
						if (this.option("sMoveUnit") == "page") {
							switch (e) {
							case "pre":
								c = this.getCurrentPage() - 1;
								break;
							case "next":
								c = this.getCurrentPage() + 1;
								break
							}
						} else {
							var b = this._getPageList(this.getCurrentPage());
							switch (e) {
							case "pre_end":
								c = 1;
								break;
							case "pre":
								var a = (b - 1)
										* this.option("nPagePerPageList");
								c = a;
								break;
							case "next":
								var d = (b) * this.option("nPagePerPageList")
										+ 1;
								c = d;
								break;
							case "next_end":
								c = this._getLastPage();
								break
							}
						}
						return c
					},
					_getPageList : function(c) {
						if (this.option("bAlignCenter")) {
							var a = Math
									.floor(this.option("nPagePerPageList") / 2);
							var b = c - a;
							b = Math.max(b, 1);
							b = Math.min(b, this._getLastPage());
							return b
						}
						return Math.ceil(c / this.option("nPagePerPageList"))
					},
					_isIn : function(a, b) {
						if (!b) {
							return false
						}
						return (a === b) ? true : jindo.$Element(a)
								.isChildOf(b)
					},
					_getPageElement : function(c) {
						for (var b = 0, d = this._waPage.$value().length; b < d; b++) {
							var a = this._waPage.get(b);
							if (this._isIn(c, a)) {
								return a
							}
						}
						return null
					},
					_onClickPageList : function(c) {
						c.stop(jindo.$Event.CANCEL_DEFAULT);
						var b = null, e = this.option(), d = c.element;
						if (this._isIn(d, e.elFirstPageLinkOn)) {
							b = this._getRelativePage("pre_end")
						} else {
							if (this._isIn(d, e.elPrevPageLinkOn)) {
								b = this._getRelativePage("pre")
							} else {
								if (this._isIn(d, e.elNextPageLinkOn)) {
									b = this._getRelativePage("next")
								} else {
									if (this._isIn(d, e.elLastPageLinkOn)) {
										b = this._getRelativePage("next_end")
									} else {
										var a = this._getPageElement(d);
										if (a) {
											b = parseInt(jindo.$Element(a)
													.text(), 10)
										} else {
											return
										}
									}
								}
							}
						}
						this.movePageTo(b)
					},
					_convertToAvailPage : function(a) {
						var b = this._getLastPage();
						a = Math.max(a, 1);
						a = Math.min(a, b);
						return a
					},
					movePageTo : function(a, b) {
						if (typeof b == "undefined") {
							b = true
						}
						a = this._convertToAvailPage(a);
						this._nCurrentPage = a;
						if (b) {
							if (!this.fireEvent("beforeMove", {
								nPage : a
							})) {
								return
							}
						}
						this._paginate(a);
						if (b) {
							this.fireEvent("move", {
								nPage : a
							})
						}
					},
					reset : function(a) {
						if (typeof a == "undefined") {
							a = this.option("nItem")
						}
						this.setItemCount(a);
						this.movePageTo(1, false)
					},
					_onActivate : function() {
						this._fClickPage.attach(this._elPageList, "click");
						this.setItemCount(this.option("nItem"));
						this.movePageTo(this.option("nPage"), false);
						this._welPageList.addClass("loaded")
					},
					_onDeactivate : function() {
						this._fClickPage.detach(this._elPageList, "click");
						this._welPageList.removeClass("loaded")
					},
					_addTextNode : function() {
						var a = this.option("sInsertTextNode");
						this._elPageList
								.appendChild(document.createTextNode(a))
					},
					_paginate : function(j) {
						this._empty();
						this._addTextNode();
						var p = this.option(), b = p.elFirstPageLinkOn, h = p.elPrevPageLinkOn, g = p.elNextPageLinkOn, n = p.elLastPageLinkOn, q = p.elFirstPageLinkOff, d = p.elPrevPageLinkOff, s = p.elNextPageLinkOff, k = p.elLastPageLinkOff, e = this
								._getLastPage(), r = this._getPageList(j), l = this
								._getPageList(e);
						if (e === 0) {
							this._welPageList.addClass("no-result")
						} else {
							if (e == 1) {
								this._welPageList.addClass("only-one")
							} else {
								this._welPageList.removeClass("only-one")
										.removeClass("no-result")
							}
						}
						var t, a;
						if (p.bAlignCenter) {
							var f = Math.floor(p.nPagePerPageList / 2);
							t = j - f;
							t = Math.max(t, 1);
							a = t + p.nPagePerPageList - 1;
							if (a > e) {
								t = e - p.nPagePerPageList + 1;
								t = Math.max(t, 1);
								a = e
							}
						} else {
							t = (r - 1) * p.nPagePerPageList + 1;
							a = (r) * p.nPagePerPageList;
							a = Math.min(a, e)
						}
						if (p.sMoveUnit == "page") {
							r = j;
							l = e
						}
						if (j > 1) {
							if (b) {
								this._welPageList.append(b);
								this._addTextNode()
							}
						} else {
							if (q) {
								this._welPageList.append(q);
								this._addTextNode()
							}
						}
						if (r > 1) {
							if (h) {
								this._welPageList.append(h);
								this._addTextNode()
							}
						} else {
							if (d) {
								this._welPageList.append(d);
								this._addTextNode()
							}
						}
						var c, o;
						for (var m = t; m <= a; m++) {
							if (m == j) {
								c = jindo.$(jindo.$Template(
										p.sCurrentPageTemplate).process({
									page : m.toString()
								}))
							} else {
								c = jindo.$(jindo.$Template(p.sPageTemplate)
										.process({
											page : m.toString()
										}));
								this._waPage.push(c)
							}
							o = jindo.$Element(c);
							if (m == t) {
								o.addClass(this.option("sClassFirst"))
							}
							if (m == a) {
								o.addClass(this.option("sClassLast"))
							}
							this._welPageList.append(c);
							this._addTextNode()
						}
						if (r < l) {
							if (g) {
								this._welPageList.append(g);
								this._addTextNode()
							}
						} else {
							if (s) {
								this._welPageList.append(s);
								this._addTextNode()
							}
						}
						if (j < e) {
							if (n) {
								this._welPageList.append(n);
								this._addTextNode()
							}
						} else {
							if (k) {
								this._welPageList.append(k);
								this._addTextNode()
							}
						}
					},
					_empty : function() {
						var e = this.option(), f = e.elFirstPageLinkOn, d = e.elPrevPageLinkOn, h = e.elNextPageLinkOn, a = e.elLastPageLinkOn, b = e.elFirstPageLinkOff, i = e.elPrevPageLinkOff, c = e.elNextPageLinkOff, g = e.elLastPageLinkOff;
						f = this._clone(f);
						d = this._clone(d);
						a = this._clone(a);
						h = this._clone(h);
						b = this._clone(b);
						i = this._clone(i);
						g = this._clone(g);
						c = this._clone(c);
						this._waPage.empty();
						this._welPageList.empty()
					},
					_clone : function(a) {
						if (a && typeof a.cloneNode == "function") {
							return a.cloneNode(true)
						}
						return a
					}
				}).extend(jindo.UIComponent);
jindo.DatePicker = jindo
		.$Class(
				{
					_aDatePickerSet : [],
					_htSelectedDatePickerSet : null,
					$init : function(a, c) {
						var b = new Date();
						this.htDefaultOption = {
							bUseLayerPosition : true,
							Calendar : {
								sClassPrefix : "calendar-",
								nYear : b.getFullYear(),
								nMonth : b.getMonth() + 1,
								nDate : b.getDate(),
								sTitleFormat : "yyyy-mm",
								aMonthTitle : [ "JAN", "FEB", "MAR", "APR",
										"MAY", "JUN", "JUL", "AUG", "SEP",
										"OCT", "NOV", "DEC" ]
							},
							LayerManager : {
								sCheckEvent : "click",
								nShowDelay : 0,
								nHideDelay : 0
							},
							LayerPosition : {
								sPosition : "outside-bottom",
								sAlign : "left",
								nTop : 0,
								nLeft : 0,
								bAuto : false
							}
						};
						this.option(this.htDefaultOption);
						this.option(c);
						this._elCalendarLayer = jindo.$(a);
						this._initCalendar();
						this._initLayerManager();
						this._initLayerPosition();
						this._wfFocusInput = jindo
								.$Fn(this._onFocusInput, this);
						this._wfClickLinkedElement = jindo.$Fn(
								this._onClickLinkedElement, this);
						this._wfMouseOverOutDate = jindo.$Fn(
								this._onMouseOverOutDate, this);
						this._wfClickDate = jindo.$Fn(this._onClickDate, this);
						this.activate()
					},
					addDatePickerSet : function(a) {
						var c = this.option(), f = this.getCalendar().option(), e = {
							nYear : f.nYear,
							nMonth : f.nMonth,
							nDate : f.nDate,
							bDefaultSet : true,
							bReadOnly : true,
							sDateFormat : "yyyy-mm-dd",
							htSelectableDateFrom : {
								nYear : 1900,
								nMonth : 1,
								nDate : 1
							},
							htSelectableDateTo : {
								nYear : 2100,
								nMonth : 12,
								nDate : 31
							}
						};
						if (typeof a.htOption != "undefined") {
							for ( var d in a.htOption) {
								if (typeof e[d] != "undefined") {
									e[d] = a.htOption[d]
								}
							}
						}
						a.htOption = e;
						this._aDatePickerSet.push(a);
						var b = this.getLayerManager();
						if (typeof a.elInput != "undefined") {
							b.link(a.elInput);
							if (a.htOption.bReadOnly) {
								a.elInput.readOnly = true
							}
							this._wfFocusInput.attach(a.elInput, "focus");
							this._wfClickLinkedElement.attach(a.elInput,
									"click")
						}
						if (typeof a.elButton != "undefined") {
							b.link(a.elButton);
							this._wfClickLinkedElement.attach(a.elButton,
									"click")
						}
						if (a.htOption.bDefaultSet) {
							this._setDate(a, a.htOption)
						}
						return this
					},
					removeDatePickerSet : function(c) {
						var b = -1;
						for (var d = 0, a = this._aDatePickerSet.length; d < a; d++) {
							if (this._aDatePickerSet[d].elInput == c.elInput
									|| this._aDatePickerSet[d].elButton == c.elButton) {
								b = d;
								break
							}
						}
						var e = this._aDatePickerSet[b];
						var f = this.getLayerManager();
						if (typeof e.elButton != "undefined") {
							f.unlink(e.elButton);
							this._wfClickLinkedElement.detach(e.elButton,
									"click")
						}
						if (typeof e.elInput != "undefined") {
							this._wfFocusInput.detach(e.elInput, "focus");
							this._wfClickLinkedElement.detach(e.elInput,
									"click");
							e.elInput.readOnly = false
						}
						if (e == this._htSelectedDatePickerSet) {
							this._htSelectedDatePickerSet = null
						}
						this._aDatePickerSet.splice(d, 1);
						return this
					},
					getDatePickerSet : function(c) {
						if (typeof c == "undefined") {
							return this._aDatePickerSet
						}
						for (var b = 0, a = this._aDatePickerSet.length; b < a; b++) {
							if (this._aDatePickerSet[b].elInput == c
									|| this._aDatePickerSet[b].elButton == c) {
								return this._aDatePickerSet[b]
							}
						}
						return false
					},
					getCalendarLayer : function() {
						return this._elCalendarLayer
					},
					_initCalendar : function() {
						var a = this;
						this._oCalendar = new jindo.Calendar(this
								.getCalendarLayer(), this.option("Calendar"))
								.attach({
									beforeDraw : function(b) {
										if (!a.fireEvent("beforeDraw", b)) {
											b.stop()
										}
									},
									draw : function(b) {
										var c = this.option("sClassPrefix");
										var d = a._htSelectedDatePickerSet;
										if (a.isSelectable(d, b)) {
											b.bSelectable = true;
											if (jindo.Calendar.isSameDate(b, d)) {
												jindo.$Element(
														b.elDateContainer)
														.addClass(
																c + "selected")
											}
										} else {
											b.bSelectable = false;
											jindo
													.$Element(b.elDateContainer)
													.addClass(
															this
																	.option("sClassPrefix")
																	+ "unselectable")
										}
										if (!a.fireEvent("draw", b)) {
											b.stop()
										}
									},
									afterDraw : function(b) {
										a.fireEvent("afterDraw", b)
									}
								})
					},
					getCalendar : function() {
						return this._oCalendar
					},
					_initLayerManager : function() {
						var b = this;
						var a = this.getCalendarLayer();
						this._oLayerManager = new jindo.LayerManager(a, this
								.option("LayerManager")).attach({
							hide : function(c) {
								b._htSelectedDatePickerSet = null
							}
						}).link(a)
					},
					getLayerManager : function() {
						return this._oLayerManager
					},
					_initLayerPosition : function() {
						if (this.option("bUseLayerPosition")) {
							this._oLayerPosition = new jindo.LayerPosition(
									null, this.getCalendarLayer(), this
											.option("LayerPosition"))
						}
					},
					getLayerPosition : function() {
						return this._oLayerPosition
					},
					getInput : function(a) {
						return a.elInput || null
					},
					setInput : function(b, a) {
						this._setDate(b, a)
					},
					getDate : function(a) {
						return {
							nYear : a.nYear,
							nMonth : a.nMonth,
							nDate : a.nDate
						}
					},
					_setDate : function(b, a) {
						b.nYear = a.nYear * 1;
						b.nMonth = a.nMonth * 1;
						b.nDate = a.nDate * 1;
						if (typeof b.elInput != "undefined") {
							b.elInput.value = this._getDateFormat(b, a)
						}
					},
					isSelectable : function(b, a) {
						return jindo.Calendar.isBetween(a,
								b.htOption.htSelectableDateFrom,
								b.htOption.htSelectableDateTo)
					},
					setDate : function(c, a) {
						if (this.isSelectable(c, a)) {
							var b = this._getDateFormat(c, a);
							var d = {
								sText : b,
								nYear : a.nYear,
								nMonth : a.nMonth,
								nDate : a.nDate
							};
							if (this.fireEvent("beforeSelect", d)) {
								this._setDate(c, a);
								if (this.fireEvent("select", d)) {
									this.getLayerManager().hide()
								}
							}
							return true
						}
						return false
					},
					_getDateFormat : function(f, b) {
						var c = b.nYear;
						var e = b.nMonth;
						var a = b.nDate;
						if (e < 10) {
							e = ("0" + (e * 1)).toString()
						}
						if (a < 10) {
							a = ("0" + (a * 1)).toString()
						}
						var d = f.htOption.sDateFormat;
						d = d.replace(/yyyy/g, c).replace(/y/g,
								(c).toString().substr(2, 2)).replace(/mm/g, e)
								.replace(/m/g, (e * 1)).replace(
										/M/g,
										this.getCalendar()
												.option("aMonthTitle")[e - 1])
								.replace(/dd/g, a).replace(/d/g, (a * 1));
						return d
					},
					_linkOnly : function(a) {
						var b = this.getLayerManager();
						b.setLinks([ this.getCalendarLayer() ]);
						if (typeof a.elInput != "undefined") {
							b.link(a.elInput)
						}
						if (typeof a.elButton != "undefined") {
							b.link(a.elButton)
						}
					},
					_onActivate : function() {
						var a = this.getCalendarLayer();
						this._wfMouseOverOutDate.attach(a, "mouseover").attach(
								a, "mouseout");
						this._wfClickDate.attach(a, "click");
						this.getLayerManager().activate();
						this.getCalendar().activate()
					},
					_onDeactivate : function() {
						var a = this.getCalendarLayer();
						this._wfMouseOverOutDate.detach(a, "mouseover").detach(
								a, "mouseout");
						this._wfClickDate.detach(a, "click").detach(a,
								"mouseover").detach(a, "mouseout");
						this.getLayerManager().deactivate();
						this.getCalendar().deactivate()
					},
					attachEvent : function() {
						return this.activate()
					},
					detachEvent : function() {
						return this.deactivate()
					},
					addButton : function() {
						return this
					},
					_onFocusInput : function(a) {
						this.fireEvent("focus")
					},
					_onClickLinkedElement : function(b) {
						b.stop(jindo.$Event.CANCEL_DEFAULT);
						if (this.fireEvent("click", {
							element : b.element
						})) {
							var d = this.getDatePickerSet(b.currentElement);
							if (d) {
								this._htSelectedDatePickerSet = d;
								this._linkOnly(d);
								if (!d.nYear) {
									d.nYear = d.htOption.nYear
								}
								if (!d.nMonth) {
									d.nMonth = d.htOption.nMonth
								}
								if (!d.nDate) {
									d.nDate = d.htOption.nDate
								}
								var a = d.nYear;
								var c = d.nMonth;
								this.getCalendar().draw(a, c);
								this.getLayerManager().show();
								if (this.option("bUseLayerPosition")) {
									if (typeof d.elLayerPosition != "undefined") {
										this.getLayerPosition().setElement(
												d.elLayerPosition)
												.setPosition()
									} else {
										this.getLayerPosition().setElement(
												d.elInput).setPosition()
									}
								}
							}
						}
					},
					_getTargetDateElement : function(b) {
						var a = this.getCalendar().option("sClassPrefix");
						var c = (jindo.$Element(b).hasClass(a + "date")) ? b
								: jindo.$$.getSingle("." + a + "date", b);
						if (c && (c == b || c.length == 1)) {
							return c
						}
						return null
					},
					_getTargetDateContainerElement : function(d) {
						var c = this.getCalendar().option("sClassPrefix");
						var a = jindo.$$.getSingle("! ." + c + "week", d);
						if (a) {
							var b = d;
							while (!jindo.$Element(b.parentNode).hasClass(
									c + "week")) {
								b = b.parentNode
							}
							if (jindo.$Element(b).hasClass(c + "unselectable")) {
								return null
							}
							return b
						} else {
							return null
						}
					},
					_onMouseOverOutDate : function(c) {
						c.stop(jindo.$Event.CANCEL_DEFAULT);
						var e = this.getCalendar().option("sClassPrefix");
						var d = c.element;
						var b = this._getTargetDateContainerElement(d);
						if (b) {
							var a = this.getCalendar().getDateOfElement(b);
							if (this._htSelectedDatePickerSet
									&& this.isSelectable(
											this._htSelectedDatePickerSet, a)) {
								if (c.type == "mouseover") {
									if (!this._elSelected) {
										this._elSelected = jindo.$$.getSingle(
												"." + e + "selected",
												this.elWeekAppendTarget);
										if (this._elSelected) {
											jindo
													.$Element(this._elSelected)
													.removeClass(e + "selected")
										}
									}
									jindo.$Element(b).addClass(e + "over");
									return
								}
								if (c.type == "mouseout") {
									jindo.$Element(b).removeClass(e + "over");
									return
								}
							} else {
								if (this._elSelected) {
									jindo.$Element(this._elSelected).addClass(
											e + "selected");
									this._elSelected = null
								}
							}
						} else {
							if (this._elSelected) {
								jindo.$Element(this._elSelected).addClass(
										e + "selected");
								this._elSelected = null
							}
						}
					},
					_onClickDate : function(c) {
						c.stop(jindo.$Event.CANCEL_DEFAULT);
						var d = c.element;
						var e = this._getTargetDateElement(d);
						if (e) {
							var b = this._getTargetDateContainerElement(e);
							if (b) {
								var a = this.getCalendar().getDateOfElement(b);
								if (this.isSelectable(
										this._htSelectedDatePickerSet, a)) {
									this.setDate(this._htSelectedDatePickerSet,
											a)
								}
							}
						}
					}
				}).extend(jindo.UIComponent);
jindo.StarRating = jindo
		.$Class(
				{
					$init : function(a, b) {
						var c = {
							nStep : 1,
							nMaxValue : 10,
							nDefaultValue : 0,
							bSnap : false,
							bActivateOnload : true
						};
						this.option(c);
						this.option(b || {});
						this._el = jindo.$(a);
						this._wel = jindo.$Element(a);
						this._assignHTMLElements();
						this._wfMouseMove = jindo.$Fn(this._onMouseMove, this);
						this._wfMouseLeave = jindo
								.$Fn(this._onMouseLeave, this);
						this._wfClick = jindo.$Fn(this._onClick, this);
						if (this.option("bActivateOnload")) {
							this.activate()
						}
					},
					_assignHTMLElements : function() {
						this._elRatingElement = jindo.$$.getSingle("span", this
								.getBaseElement());
						this._welRatingElement = jindo
								.$Element(this._elRatingElement)
					},
					getBaseElement : function() {
						return this._el
					},
					getRatingElement : function() {
						return this._elRatingElement
					},
					getValue : function() {
						return this._nValue
					},
					getValueByWidth : function() {
						return this._welRatingElement.width()
								/ this._nBaseWidth * this.option("nMaxValue")
					},
					getValueToBeSet : function(a) {
						a = this._round(a, this.option("nStep"));
						a = Math.min(a, this.option("nMaxValue"));
						a = Math.max(a, 0);
						return a
					},
					setValue : function(b, c) {
						if (typeof c == "undefined") {
							c = true
						}
						var d = this.option("nMaxValue");
						b = this.getValueToBeSet(b);
						var a = this._nBaseWidth * b / d;
						a = Math.min(a, this._nBaseWidth);
						this._welRatingElement.width(a);
						this._nValue = b;
						if (c) {
							this.fireEvent("set", {
								nValue : this._nValue
							})
						}
						return this
					},
					reset : function() {
						var a = this.option("nDefaultValue") || 0;
						this.setValue(a, false);
						return this
					},
					_round : function(c, i) {
						var f = c, a = Math.floor(c), e = a + 1, h = 1, d, b, g;
						for (b = a; b <= e; b += i) {
							d = Math.abs(c - b);
							if (d <= h) {
								h = d;
								f = b
							}
						}
						return f
								.toFixed(Math.max((i.toString().length - 2), 0))
					},
					_onActivate : function() {
						var a = this.getBaseElement();
						this._wfMouseMove.attach(a, "mousemove");
						this._wfMouseLeave.attach(a, "mouseleave");
						this._wfClick.attach(a, "click");
						this._nBaseWidth = this._wel.width();
						this.reset()
					},
					_onDeactivate : function() {
						var a = this.getBaseElement();
						this._wfMouseMove.detach(a, "mousemove");
						this._wfMouseLeave.detach(a, "mouseleave");
						this._wfClick.detach(a, "click")
					},
					_onMouseMove : function(d) {
						var a = d.pos(true).offsetX + 1, b = (a > this._nBaseWidth) ? this._nBaseWidth
								: a, c;
						if (this.option("bSnap")) {
							c = a / this._nBaseWidth * this.option("nMaxValue");
							b = this._round(c, this.option("nStep"))
									* this._nBaseWidth
									/ this.option("nMaxValue");
							b = Math.min(b, this._nBaseWidth)
						}
						this._welRatingElement.css("width", b + "px");
						c = this.getValueByWidth();
						this.fireEvent("move", {
							nValue : c,
							nValueToBeSet : this.getValueToBeSet(c)
						})
					},
					_onMouseLeave : function(a) {
						this.setValue(this._nValue, false);
						this.fireEvent("out")
					},
					_onClick : function(a) {
						this.setValue(this.getValueByWidth())
					}
				}).extend(jindo.UIComponent);
jindo.DragArea = jindo
		.$Class(
				{
					$init : function(a, b) {
						this.option({
							sClassName : "draggable",
							bFlowOut : true,
							bSetCapture : true,
							nThreshold : 0
						});
						this.option(b || {});
						this._el = a;
						this._bIE = jindo.$Agent().navigator().ie;
						this._htDragInfo = {
							bIsDragging : false,
							bPrepared : false,
							bHandleDown : false,
							bForceDrag : false
						};
						this._wfOnMouseDown = jindo
								.$Fn(this._onMouseDown, this);
						this._wfOnMouseMove = jindo
								.$Fn(this._onMouseMove, this);
						this._wfOnMouseUp = jindo.$Fn(this._onMouseUp, this);
						this._wfOnDragStart = jindo
								.$Fn(this._onDragStart, this);
						this._wfOnSelectStart = jindo.$Fn(this._onSelectStart,
								this);
						this.activate()
					},
					_findDraggableElement : function(c) {
						if (c.nodeType === 1
								&& jindo.$$.test(c,
										"input[type=text], textarea, select")) {
							return null
						}
						var a = this;
						var e = "." + this.option("sClassName");
						var d = function(f) {
							if (f === null) {
								return false
							}
							if (a._el === document || a._el === f) {
								return true
							}
							return jindo.$Element(a._el).isParentOf(f)
						};
						var b = jindo.$$.test(c, e) ? c : jindo.$$.getSingle(
								"! " + e, c);
						if (!d(b)) {
							b = null
						}
						return b
					},
					isDragging : function() {
						var a = this._htDragInfo;
						return a.bIsDragging && !a.bPrepared
					},
					stopDragging : function() {
						this._stopDragging(true);
						return this
					},
					_stopDragging : function(a) {
						this._wfOnMouseMove.detach(document, "mousemove");
						this._wfOnMouseUp.detach(document, "mouseup");
						if (this.isDragging()) {
							var b = this._htDragInfo, c = jindo
									.$Element(b.elDrag);
							b.bIsDragging = false;
							b.bForceDrag = false;
							b.bPrepared = false;
							if (this._bIE && this._elSetCapture) {
								this._elSetCapture.releaseCapture();
								this._elSetCapture = null
							}
							this.fireEvent("dragEnd", {
								elArea : this._el,
								elHandle : b.elHandle,
								elDrag : b.elDrag,
								nX : parseInt(c.css("left"), 10) || 0,
								nY : parseInt(c.css("top"), 10) || 0,
								bInterupted : a
							})
						}
					},
					_onActivate : function() {
						this._wfOnMouseDown.attach(this._el, "mousedown");
						this._wfOnDragStart.attach(this._el, "dragstart");
						this._wfOnSelectStart.attach(this._el, "selectstart")
					},
					_onDeactivate : function() {
						this._wfOnMouseDown.detach(this._el, "mousedown");
						this._wfOnDragStart.detach(this._el, "dragstart");
						this._wfOnSelectStart.detach(this._el, "selectstart")
					},
					attachEvent : function() {
						this.activate()
					},
					detachEvent : function() {
						this.deactivate()
					},
					isEventAttached : function() {
						return this.isActivating()
					},
					startDragging : function(b) {
						var a = this._findDraggableElement(b);
						if (a) {
							this._htDragInfo.bForceDrag = true;
							this._htDragInfo.bPrepared = true;
							this._htDragInfo.elHandle = a;
							this._htDragInfo.elDrag = a;
							this._wfOnMouseMove.attach(document, "mousemove");
							this._wfOnMouseUp.attach(document, "mouseup");
							return true
						}
						return false
					},
					_onMouseDown : function(c) {
						var b = c.mouse(true);
						if (!b.left || b.right || b.scrollbar) {
							this._stopDragging(true);
							return
						}
						var e = this._findDraggableElement(c.element);
						if (e) {
							var a = c.pos(), d = this._htDragInfo;
							d.bHandleDown = true;
							d.bPrepared = true;
							d.nButton = c._event.button;
							d.elHandle = e;
							d.elDrag = e;
							d.nPageX = a.pageX;
							d.nPageY = a.pageY;
							if (this.fireEvent("handleDown", {
								elHandle : e,
								elDrag : e,
								weEvent : c
							})) {
								this._wfOnMouseMove.attach(document,
										"mousemove")
							}
							this._wfOnMouseUp.attach(document, "mouseup");
							c.stop(jindo.$Event.CANCEL_DEFAULT)
						}
					},
					_onMouseMove : function(c) {
						var n = this._htDragInfo, a, o, j = c.pos(), g = {
							nX : j.pageX - n.nPageX,
							nY : j.pageY - n.nPageY
						};
						if (n.bPrepared) {
							var l = this.option("nThreshold"), q = {};
							if (!n.bForceDrag && l) {
								q.nPageX = j.pageX - n.nPageX;
								q.nPageY = j.pageY - n.nPageY;
								var d = Math.sqrt(q.nPageX * q.nPageX
										+ q.nPageY * q.nPageY);
								if (l > d) {
									return
								}
							}
							if (this._bIE && this.option("bSetCapture")) {
								this._elSetCapture = (this._el === document) ? document.body
										: this._findDraggableElement(c.element);
								if (this._elSetCapture) {
									this._elSetCapture.setCapture(false)
								}
							}
							a = {
								elArea : this._el,
								elHandle : n.elHandle,
								elDrag : n.elDrag,
								htDiff : q,
								weEvent : c
							};
							n.bIsDragging = true;
							n.bPrepared = false;
							if (this.fireEvent("dragStart", a)) {
								var p = jindo.$Element(a.elDrag), i = p
										.offset();
								n.elHandle = a.elHandle;
								n.elDrag = a.elDrag;
								n.nX = parseInt(p.css("left"), 10) || 0;
								n.nY = parseInt(p.css("top"), 10) || 0;
								n.nClientX = i.left + p.width() / 2;
								n.nClientY = i.top + p.height() / 2
							} else {
								n.bPrepared = true;
								return
							}
						}
						if (n.bForceDrag) {
							g.nX = j.clientX - n.nClientX;
							g.nY = j.clientY - n.nClientY
						}
						a = {
							elArea : this._el,
							elFlowOut : n.elDrag.parentNode,
							elHandle : n.elHandle,
							elDrag : n.elDrag,
							weEvent : c,
							nX : n.nX + g.nX,
							nY : n.nY + g.nY,
							nGapX : g.nX,
							nGapY : g.nY
						};
						if (this.fireEvent("beforeDrag", a)) {
							var f = n.elDrag;
							if (this.option("bFlowOut") === false) {
								var e = a.elFlowOut, m = [ f.offsetWidth,
										f.offsetHeight ], b = 0, h = 0;
								if (e == document.body) {
									e = null
								}
								if (e && m[0] <= e.scrollWidth
										&& m[1] <= e.scrollHeight) {
									o = {
										nWidth : e.clientWidth,
										nHeight : e.clientHeight
									};
									b = e.scrollLeft;
									h = e.scrollTop
								} else {
									var k = jindo.$Document().clientSize();
									o = {
										nWidth : k.width,
										nHeight : k.height
									}
								}
								if (a.nX !== null) {
									a.nX = Math.max(a.nX, b);
									a.nX = Math.min(a.nX, o.nWidth - m[0] + b)
								}
								if (a.nY !== null) {
									a.nY = Math.max(a.nY, h);
									a.nY = Math.min(a.nY, o.nHeight - m[1] + h)
								}
							}
							if (a.nX !== null) {
								f.style.left = a.nX + "px"
							}
							if (a.nY !== null) {
								f.style.top = a.nY + "px"
							}
							this.fireEvent("drag", a)
						} else {
							n.bIsDragging = false
						}
					},
					_onMouseUp : function(a) {
						this._stopDragging(false);
						var b = this._htDragInfo;
						b.bHandleDown = false;
						this.fireEvent("handleUp", {
							weEvent : a,
							elHandle : b.elHandle,
							elDrag : b.elDrag
						})
					},
					_onDragStart : function(a) {
						if (this._findDraggableElement(a.element)) {
							a.stop(jindo.$Event.CANCEL_DEFAULT)
						}
					},
					_onSelectStart : function(a) {
						if (this.isDragging()
								|| this._findDraggableElement(a.element)) {
							a.stop(jindo.$Event.CANCEL_DEFAULT)
						}
					}
				}).extend(jindo.UIComponent);
jindo.DefaultTextValue = jindo.$Class({
	$init : function(a, b) {
		this.option({
			sValue : "",
			bActivateOnload : true
		});
		this.option(b || {});
		this._elBaseTarget = jindo.$(a);
		this._wfOnFocusAndBlur = jindo.$Fn(this._onFocusAndBlur, this);
		if (this.option("bActivateOnload")) {
			this.activate()
		}
	},
	getBaseElement : function() {
		return this._elBaseTarget
	},
	setDefault : function() {
		this.getBaseElement().value = this.option("sValue");
		return this
	},
	setDefaultValue : function(b) {
		var a = this.option("sValue");
		this.option("sValue", b);
		if (this.getBaseElement().value == a) {
			this.setDefault()
		}
		return this
	},
	getDefaultValue : function() {
		return this.option("sValue")
	},
	paint : function() {
		return this
	},
	_onActivate : function() {
		var a = this.getBaseElement();
		if (a.value == "") {
			this.setDefault()
		}
		this._wfOnFocusAndBlur.attach(a, "focus").attach(a, "blur")
	},
	_onDeactivate : function() {
		var a = this.getBaseElement();
		this._wfOnFocusAndBlur.detach(a, "focus").detach(a, "blur")
	},
	_onFocusAndBlur : function(a) {
		var b = this._elBaseTarget;
		var c = b.value;
		switch (a.type) {
		case "focus":
			if (c == this.getDefaultValue()) {
				b.value = "";
				b.select()
			}
			break;
		case "blur":
			if (jindo.$S(c).trim().$value() == "") {
				this.setDefault()
			}
			break
		}
	}
}).extend(jindo.UIComponent);
jindo.NumericStepper = jindo
		.$Class(
				{
					_bIsOnFocus : false,
					$init : function(a, b) {
						this._el = jindo.$(a);
						this.option({
							sClassPrefix : "ns-",
							bActivateOnload : true,
							bUseMouseWheel : false,
							nStep : 1,
							nDecimalPoint : 0,
							nMin : -Infinity,
							nMax : Infinity,
							nDefaultValue : 0,
							bInputReadOnly : true
						});
						this.option(b || {});
						this._assignHTMLElements();
						this._initEventHandlers();
						if (this.option("bActivateOnload")) {
							this.activate()
						}
					},
					_assignHTMLElements : function() {
						var a = this.option("sClassPrefix");
						this._elInput = jindo.$$.getSingle("." + a + "input",
								this._el);
						this._elPlusButton = jindo.$$.getSingle("." + a
								+ "plus", this._el);
						this._elMinusButton = jindo.$$.getSingle("." + a
								+ "minus", this._el)
					},
					_initEventHandlers : function() {
						this._wfPlusClick = jindo.$Fn(this._onPlusClick, this);
						this._wfMinusClick = jindo
								.$Fn(this._onMinusClick, this);
						this._wfWheel = jindo.$Fn(this._onWheel, this);
						this._wfFocus = jindo.$Fn(this._onFocus, this);
						this._wfBlur = jindo.$Fn(this._onBlur, this)
					},
					reset : function() {
						this._elInput.value = this.option("nDefaultValue")
								.toFixed(this.option("nDecimalPoint"))
					},
					getValue : function() {
						return parseFloat(this._elInput.value)
					},
					setValue : function(d) {
						d = d.toFixed(this.option("nDecimalPoint"));
						var a = this.option("nMin"), b = this.option("nMax"), c = {
							nValue : d,
							nMin : a,
							nMax : b
						};
						if (d > b || d < a) {
							this.fireEvent("overLimit", c);
							return
						}
						if (!this.fireEvent("beforeChange", c)) {
							return
						}
						this._elInput.value = c.nValue;
						this.fireEvent("change", c)
					},
					getBaseElement : function() {
						return this._el
					},
					getInputElement : function() {
						return this._elInput
					},
					getPlusElement : function() {
						return this._elPlusButton
					},
					getMinusElement : function() {
						return this._elMinusButton
					},
					isFocused : function() {
						return this._bIsOnFocus
					},
					_onActivate : function() {
						var a = this.getInputElement();
						this._wfPlusClick
								.attach(this.getPlusElement(), "click");
						this._wfMinusClick.attach(this.getMinusElement(),
								"click");
						this._wfFocus.attach(a, "focus");
						this._wfBlur.attach(a, "blur");
						if (this.option("bUseMouseWheel")) {
							this._wfWheel.attach(a, "mousewheel")
						}
						this._elInput.readOnly = this.option("bInputReadOnly");
						this.reset()
					},
					_onDeactivate : function() {
						var a = this.getInputElement();
						this._wfPlusClick
								.detach(this.getPlusElement(), "click");
						this._wfMinusClick.detach(this.getMinusElement(),
								"click");
						this._wfInputClick.detach(a, "click");
						this._wfFocus.detach(a, "focus");
						this._wfBlur.detach(a, "blur");
						this._wfWheel.detach(a, "mousewheel")
					},
					_onMinusClick : function(a) {
						this.setValue(this.getValue() - this.option("nStep"))
					},
					_onPlusClick : function(a) {
						this.setValue(this.getValue() + this.option("nStep"))
					},
					_onWheel : function(a) {
						if (this.isFocused()) {
							a.stop(jindo.$Event.CANCEL_DEFAULT);
							if (a.mouse().delta > 0) {
								this._onPlusClick()
							} else {
								this._onMinusClick()
							}
						}
					},
					_onFocus : function(a) {
						this._bIsOnFocus = true
					},
					_onBlur : function(a) {
						this._bIsOnFocus = false;
						this.setValue(this.getValue());
						this._elInput.readOnly = this.option("bInputReadOnly")
					}
				}).extend(jindo.UIComponent);
jindo.LazyLoading = {
	_waLoading : jindo.$A([]),
	_waLoaded : jindo.$A([]),
	_whtScript : jindo.$H({}),
	_whtCallback : jindo.$H({})
};
jindo.LazyLoading.load = function(d, f, e) {
	if (typeof f != "function") {
		f = function() {
		}
	}
	this._queueCallback(d, f);
	if (this._checkIsLoading(d)) {
		return false
	}
	if (this._checkAlreadyLoaded(d)) {
		this._doCallback(d);
		return true
	}
	this._waLoading.push(d);
	var b = this;
	var a = document.getElementsByTagName("head")[0];
	var c = document.createElement("script");
	c.type = "text/javascript";
	c.charset = e || "utf-8";
	c.src = d;
	this._whtScript.add(d, c);
	if ("onload" in c) {
		c.onload = function() {
			b._waLoaded.push(d);
			b._waLoading = b._waLoading.refuse(d);
			b._doCallback(d)
		}
	} else {
		c.onreadystatechange = function() {
			if (this.readyState == "complete" || this.readyState == "loaded") {
				b._waLoaded.push(d);
				b._waLoading = b._waLoading.refuse(d);
				b._doCallback(d);
				this.onreadystatechange = null
			}
		}
	}
	a.appendChild(c);
	return true
};
jindo.LazyLoading._queueCallback = function(b, c) {
	var a = this._whtCallback.$(b);
	if (a) {
		a.push(c)
	} else {
		this._whtCallback.$(b, [ c ])
	}
};
jindo.LazyLoading._doCallback = function(c) {
	var a = this._whtCallback.$(c).concat();
	for (var b = 0; b < a.length; b++) {
		this._whtCallback.$(c).splice(b, 1);
		a[b]()
	}
};
jindo.LazyLoading.abort = function(b) {
	if (this._checkIsLoading(b)) {
		var a = this.getScriptElement(b);
		this._waLoading = this._waLoading.refuse(b);
		if ("onload" in a) {
			a.onload = null
		} else {
			a.onreadystatechange = null
		}
		jindo.$Element(a).leave();
		this._whtScript.remove(b);
		this._whtCallback.remove(b);
		return true
	} else {
		return false
	}
};
jindo.LazyLoading._checkAlreadyLoaded = function(a) {
	return this._waLoaded.has(a)
};
jindo.LazyLoading._checkIsLoading = function(a) {
	return this._waLoading.has(a)
};
jindo.LazyLoading.getLoaded = function() {
	return this._waLoaded.$value()
};
jindo.LazyLoading.getLoading = function() {
	return this._waLoading.$value()
};
jindo.LazyLoading.getScriptElement = function(a) {
	return this._whtScript.$(a) || null
};