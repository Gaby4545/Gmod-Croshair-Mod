-- hiding things
local hide = {
	CHudCrosshair = true, -- hide the default Gmod crosshair
	CHudZoom 	  = true, -- this is ugly and useless so I'm hiding it
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )