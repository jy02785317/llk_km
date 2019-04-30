MOUSE=	{
			x=0,
			y=0,
			hx=0,
			hy=0,
			rx=0,
			ry=0,
			status='IDLE',
			Holdtime=0;	--用于计算长按
			enableclick=true;
			EXIT=	function()
						if MOUSE.status=='EXIT' then
							-- MOUSE.status='IDLE';
							return true;
						end
						return false;
					end,
			ESC=	function()
						if MOUSE.status=='ESC' then
							-- MOUSE.status='IDLE';
							return true;
						end
						return false;
					end,
			IN=	function(x1,y1,x2,y2)
						if MOUSE.status=='IDLE' or MOUSE.status=='HOLD' or MOUSE.status=='CLICK' or MOUSE.status=='ESC'then
							if 	between(MOUSE.x,x1,x2) and
								between(MOUSE.y,y1,y2) then
								return true;
							end
						end
						return false;
					end,
			HOLD=	function(x1,y1,x2,y2,t)
						t=t or 0;
						if MOUSE.status=='HOLD' then
							if 	between(MOUSE.x,x1,x2) and
								between(MOUSE.y,y1,y2) and
								between(MOUSE.hx,x1,x2) and
								between(MOUSE.hy,y1,y2) then
								return true;
							end
						end
						return false;
					end,
			CLICK=	function(x1,y1,x2,y2)
						if MOUSE.status=='CLICK' then
							--[[if 	(CC.MouseClickType==1 or (between(MOUSE.rx,x1,x2) and
								between(MOUSE.ry,y1,y2))) and
								(CC.MouseClickType==2 or (between(MOUSE.hx,x1,x2) and
								between(MOUSE.hy,y1,y2))) then
								MOUSE.status='IDLE';
								return true;
							end]]--
							if x1==nil then
								-- MOUSE.status='IDLE';
								return true;
							end
							if 	between(MOUSE.rx,x1,x2) and
								between(MOUSE.ry,y1,y2) and
								between(MOUSE.hx,x1,x2) and
								between(MOUSE.hy,y1,y2) then
								-- MOUSE.status='IDLE';
								return true;
							end
						end
						return false;
					end,
			EVENT =	function(x1,y1,x2,y2)
        if MOUSE.status=='CLICK' then
          if between(MOUSE.rx,x1,x2) and
            between(MOUSE.ry,y1,y2) and
            between(MOUSE.hx,x1,x2) and
            between(MOUSE.hy,y1,y2) then
            MOUSE.status='IDLE';
            return 3;
          end
        end
        if MOUSE.status=='HOLD' then
          if between(MOUSE.x,x1,x2) and
            between(MOUSE.y,y1,y2) and
            between(MOUSE.hx,x1,x2) and
            between(MOUSE.hy,y1,y2) then
            return 2;
          end
        end
        if between(MOUSE.x,x1,x2) and
          between(MOUSE.y,y1,y2) then
          return 1;
        end
        return 0;        
			end,
		}
function getkey()
	if CONFIG.Windows then
		return getkey_pc();
	else
		return getkey_sp();
	end
end
function getkey_pc()
	local eventtype,keypress,x,y=lib.GetKey(1);
	if eventtype==0 then
		MOUSE.status='EXIT';
	elseif eventtype==3 then
		if keypress==1 then
			MOUSE.status='HOLD';
			MOUSE.x,MOUSE.y=x,y;
			MOUSE.hx,MOUSE.hy=x,y;
		elseif keypress==3 then
			MOUSE.status='ESC';
		end
	else
		local mask;
		mask,x,y=lib.GetMouse();
		MOUSE.x,MOUSE.y=x,y;
		if mask==0 then
			if MOUSE.status=='HOLD' then
				if MOUSE.enableclick then
					MOUSE.status='CLICK';
					MOUSE.rx,MOUSE.ry=x,y;
				else
					MOUSE.enableclick=true;
					MOUSE.status='IDLE';
				end
			end
		elseif mask==1 then
			if MOUSE.status~='HOLD' then
				MOUSE.x,MOUSE.y=x,y;
				MOUSE.status='HOLD';
				MOUSE.hx,MOUSE.hy=x,y;
			end
		end
	end
	return eventtype,keypress,x,y;
end
function getkey_sp()
	local eventtype,keypress,x,y=lib.GetMouse(1);
	if eventtype==0 then
		MOUSE.status='EXIT';
	elseif eventtype==2 then
		MOUSE.x,MOUSE.y=x,y;
	elseif eventtype==3 then
		if keypress==1 then
			MOUSE.status='HOLD';
			MOUSE.x,MOUSE.y=x,y;
			MOUSE.hx,MOUSE.hy=x,y;
		elseif keypress==3 then
			MOUSE.status='ESC';
		end
	elseif eventtype==4 then
		if keypress==1 then
			if MOUSE.status=='HOLD' then
				if MOUSE.enableclick then
					MOUSE.status='CLICK';
					MOUSE.x,MOUSE.y=x,y;
					MOUSE.rx,MOUSE.ry=x,y;
				else
					MOUSE.enableclick=true;
					MOUSE.status='IDLE';
					MOUSE.x,MOUSE.y=x,y;
				end
			end
		else
			MOUSE.status='IDLE';
			MOUSE.x,MOUSE.y=x,y;
		end
	end
	return eventtype,keypress,x,y;
end