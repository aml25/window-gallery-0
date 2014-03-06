{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 304.0, 93.0, 1039.0, 829.0 ],
		"bglocked" : 0,
		"defrect" : [ 304.0, 93.0, 1039.0, 829.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "u184000026",
					"text" : "autopattr @autoname 1",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-10",
					"numoutlets" : 4,
					"fontname" : "Arial",
					"outlettype" : [ "", "", "", "" ],
					"patching_rect" : [ 5.0, 5.0, 137.0, 20.0 ],
					"restore" : 					{
						"autohelp_dac" : [ "object (ezdac~)" ],
						"button" : [ "object (button)" ],
						"button[1]" : [ "object (button)" ],
						"button[2]" : [ "object (button)" ],
						"button[3]" : [ "object (button)" ],
						"flonum" : [ 0.0 ],
						"flonum[1]" : [ 0.0 ],
						"flonum[2]" : [ 0.0 ],
						"flonum[3]" : [ 0.0 ],
						"flonum[4]" : [ 0.7 ],
						"line" : [ "object (line)" ],
						"line~" : [ "object (line~)" ],
						"message" : [ "object (message)" ],
						"message[1]" : [ "object (message)" ],
						"message[2]" : [ "object (message)" ],
						"noise~" : [ "object (noise~)" ],
						"toggle" : [ 0 ]
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"varname" : "button[3]",
					"numinlets" : 1,
					"id" : "obj-61",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 715.0, 320.0, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"varname" : "toggle",
					"numinlets" : 1,
					"id" : "obj-59",
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 280.0, 460.0, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"varname" : "button[2]",
					"numinlets" : 1,
					"id" : "obj-56",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 135.0, 600.0, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print ifstatement",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-55",
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 135.0, 570.0, 96.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "if ($i1 >= 0.8 || $i2 >= 0.8) && $i3 == 0 then bang",
					"fontsize" : 12.0,
					"numinlets" : 3,
					"id" : "obj-54",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patching_rect" : [ 50.0, 490.0, 270.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"varname" : "button[1]",
					"numinlets" : 1,
					"id" : "obj-44",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 645.0, 180.0, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "line",
					"text" : "line",
					"fontsize" : 12.0,
					"numinlets" : 3,
					"id" : "obj-43",
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 815.0, 470.0, 46.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"varname" : "message[2]",
					"text" : "0, 3000 1500 0 500",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"id" : "obj-42",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patching_rect" : [ 815.0, 425.0, 114.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tapout~",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-40",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 590.0, 455.0, 51.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"varname" : "button",
					"numinlets" : 1,
					"id" : "obj-39",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 665.0, 400.0, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tapin~",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-36",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "tapconnect" ],
					"patching_rect" : [ 590.0, 400.0, 44.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "flonum[4]",
					"fontsize" : 12.0,
					"minimum" : 0.0,
					"numinlets" : 1,
					"id" : "obj-34",
					"maximum" : 0.75,
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 510.0, 310.0, 50.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.75",
					"fontsize" : 11.595187,
					"numinlets" : 2,
					"id" : "obj-28",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 480.0, 335.0, 49.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "flonum[3]",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-27",
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 665.0, 425.0, 50.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "line~",
					"text" : "line~",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"id" : "obj-22",
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 645.0, 280.0, 36.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"varname" : "message[1]",
					"text" : "500, 40 1000 100 1000",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"id" : "obj-21",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patching_rect" : [ 645.0, 260.0, 134.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "noise~",
					"text" : "noise~",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-19",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 590.0, 225.0, 46.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "reson~ 1. 200 23",
					"fontsize" : 12.0,
					"numinlets" : 4,
					"id" : "obj-18",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 590.0, 315.0, 101.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.75",
					"fontsize" : 11.595187,
					"numinlets" : 2,
					"id" : "obj-14",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 300.0, 210.0, 48.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "flonum[2]",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-5",
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 140.0, 190.0, 49.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~",
					"fontsize" : 11.595187,
					"numinlets" : 2,
					"id" : "obj-45",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 500.0, 515.0, 32.5, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~",
					"fontsize" : 11.595187,
					"numinlets" : 2,
					"id" : "obj-31",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 535.0, 515.0, 32.5, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 440",
					"fontsize" : 11.595187,
					"numinlets" : 2,
					"id" : "obj-32",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 300.0, 185.0, 66.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"varname" : "autohelp_dac",
					"numinlets" : 2,
					"id" : "obj-38",
					"numoutlets" : 0,
					"local" : 1,
					"patching_rect" : [ 585.0, 575.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "flonum[1]",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-24",
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 85.0, 190.0, 50.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "flonum",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-23",
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 30.0, 190.0, 50.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "unpack 0. 0. 0.",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-8",
					"numoutlets" : 3,
					"fontname" : "Arial",
					"outlettype" : [ "float", "float", "float" ],
					"patching_rect" : [ 30.0, 165.0, 89.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-6",
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 10.0, 125.0, 34.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"varname" : "message",
					"text" : "host localhost",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"id" : "obj-4",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patching_rect" : [ 10.0, 65.0, 84.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "udpreceive 6100",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"id" : "obj-1",
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patching_rect" : [ 10.0, 90.0, 99.0, 20.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 2 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 1 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-32", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-18", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-28", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-36", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 0 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-36", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-42", 0 ],
					"destination" : [ "obj-43", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-43", 0 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-44", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-44", 0 ],
					"destination" : [ "obj-42", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-45", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-31", 0 ],
					"destination" : [ "obj-38", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-45", 0 ],
					"destination" : [ "obj-38", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-56", 0 ],
					"destination" : [ "obj-44", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-45", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-31", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-56", 0 ],
					"destination" : [ "obj-59", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 1 ],
					"destination" : [ "obj-61", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-61", 0 ],
					"destination" : [ "obj-59", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-54", 0 ],
					"destination" : [ "obj-56", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-54", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-54", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-54", 0 ],
					"destination" : [ "obj-55", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-59", 0 ],
					"destination" : [ "obj-54", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
