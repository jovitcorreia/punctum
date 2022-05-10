settings_table = {
	{
		name='time',
		arg='%I.%M',
		max=12,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xffffff,
		fg_alpha=0.2,
		x=1460, y=165,
		radius=50,
		thickness=5,
		start_angle=0,
		end_angle=360
	},
	{
		name='time',
		arg='%M.%S',
		max=60,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xA7A7A7,
		fg_alpha=0.4,
		x=1460, y=165,
		radius=56,
		thickness=5,
		start_angle=0,
		end_angle=360
	},
	{
		name='time',
		arg='%S',
		max=60,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xE8E8E8,
		fg_alpha=0.6,
		x=1460, y=165,
		radius=62,
		thickness=5,
		start_angle=0,
		end_angle=360
	},
	{
		name='cpu',
		arg='cpu1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0,
		fg_colour=0xffffff,
		fg_alpha=0.1,
		x=1460, y=165,
		radius=70,
		thickness=5,
		start_angle=60,
		end_angle=120
	},
	{
		name='cpu',
		arg='cpu2',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0,
		fg_colour=0xFFFFFF,
		fg_alpha=0.1,
		x=1460, y=165,
		radius=76,
		thickness=5,
		start_angle=60,
		end_angle=120
	},
	{
		name='cpu',
		arg='cpu0',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xA6A6A6,
		fg_alpha=0.4,
		x=1460, y=165,
		radius=84.5,
		thickness=8,
		start_angle=60,
		end_angle=120
	},
	{
		name='memperc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xA6A6A6,
		fg_alpha=0.8,
		x=1460, y=165,
		radius=83.5,
		thickness=8,
		start_angle=122,
		end_angle=210
	},
	{
		name='time',
		arg='%d',
		max=31,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xFFFFFF,
		fg_alpha=0.8,
		x=1460, y=165,
		radius=70,
		thickness=5,
		start_angle=212,
		end_angle=360
	},
	{
		name='time',
		arg='%m',
		max=12,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xF4F4F4,
		fg_alpha=0.8,
		x=1460, y=165,
		radius=76,
		thickness=5,
		start_angle=212,
		end_angle=360
	},
	{
		name='memperc',
		arg='%m',
		max=100,
		bg_colour=0xb7b7b7,
		bg_alpha=0.5,
		fg_colour=0x2c2c2c,
		fg_alpha=1.0,
		x=1460, y=165,
		radius=120,
		thickness=17,
		start_angle=-90,
		end_angle=30
	},
	{
		name='',
		arg='',
		max=100,
		bg_colour=0xb7b7b7,
		bg_alpha=0.2,
		fg_colour=0x2c2c2c,
		fg_alpha=1.0,
		x=1460, y=165,
		radius=116,
		thickness=17,
		start_angle=82,
		end_angle=180
	},
	{
		name='fs_used_perc',
		arg='/home',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.5,
		fg_colour=0xffffff,
		fg_alpha=0.6,
		x=1460, y=165,
		radius=95,
		thickness=5,
		start_angle=0,
		end_angle=90
	},
}
clock_r=125
clock_x=1460
clock_y=165
clock_colour=0xffffff
clock_alpha=0.5
show_seconds=true
require 'cairo'
function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']
	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
end
function draw_clock_hands(cr,xc,yc)
	local secs,mins,hours,secs_arc,mins_arc,hours_arc
	local xh,yh,xm,ym,xs,ys
	secs=os.date("%S")
	mins=os.date("%M")
	hours=os.date("%I")
	secs_arc=(2*math.pi/60)*secs
	mins_arc=(2*math.pi/60)*mins+secs_arc/60
	hours_arc=(2*math.pi/12)*hours+mins_arc/12
	xh=xc+0.7*clock_r*math.sin(hours_arc)
	yh=yc-0.7*clock_r*math.cos(hours_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xh,yh)
	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr,7)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colour,clock_alpha))
	cairo_stroke(cr)
	xm=xc+clock_r*math.sin(mins_arc)
	ym=yc-clock_r*math.cos(mins_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xm,ym)
	cairo_set_line_width(cr,5)
	cairo_stroke(cr)
	if show_seconds then
		xs=xc+clock_r*math.sin(secs_arc)
		ys=yc-clock_r*math.cos(secs_arc)
		cairo_move_to(cr,xc,yc)
		cairo_line_to(cr,xs,ys)
		cairo_set_line_width(cr,2)
		cairo_stroke(cr)
	end
end
function conky_clock_rings()
	local function setup_rings(cr,pt)
		local str=''
		local value=0
		str=string.format('{%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
		draw_ring(cr,pct,pt)
	end
	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	local cr=cairo_create(cs)	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end
	draw_clock_hands(cr,clock_x,clock_y)
end
function ring(cr, name, arg, max, bgc, bga, fgc, fga, xc, yc, r, t, sa, ea)
	local function rgb_to_r_g_b(colour,alpha)
		return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
	end
	local function draw_ring(pct)
		local angle_0=sa*(2*math.pi/360)-math.pi/2
		local angle_f=ea*(2*math.pi/360)-math.pi/2
		local pct_arc=pct*(angle_f-angle_0)
		cairo_arc(cr,xc,yc,r,angle_0,angle_f)
		cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
		cairo_set_line_width(cr,t)
		cairo_stroke(cr)
		cairo_arc(cr,xc,yc,r,angle_0,angle_0+pct_arc)
		cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
		cairo_stroke(cr)
	end
	local function setup_ring()
		local str = ''
		local value = 0
		str = string.format('${%s %s}', name, arg)
		str = conky_parse(str)
		value = tonumber(str)
		if value == nil then value = 0 end
		pct = value/max
		draw_ring(pct)
	end	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	if update_num>5 then setup_ring() end
end